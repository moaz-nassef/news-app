import 'dart:convert';
import 'dart:io';

///
/// Local CORS proxy for the news app.
///
/// newsapi.org does not send `Access-Control-Allow-Origin` headers, so browser
/// (Flutter web) builds cannot call it directly. This tiny server forwards the
/// request to newsapi.org and adds the missing CORS headers.
///
/// Usage:
///   dart run tool/news_proxy.dart
///
/// The Flutter web app then calls:
///   http://localhost:8090/?url=<url-encoded newsapi.org url>
///
void main() async {
  const port = 8090;
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, port);
  stdout.writeln('News CORS proxy listening on http://127.0.0.1:$port');

  await for (final request in server) {
    _addCorsHeaders(request.response);

    if (request.method == 'OPTIONS') {
      request.response.statusCode = HttpStatus.ok;
      await request.response.close();
      continue;
    }

    final urlParam = request.uri.queryParameters['url'];
    final target = urlParam == null ? null : Uri.tryParse(urlParam);

    if (target == null ||
        !target.toString().startsWith('https://newsapi.org/')) {
      request.response.statusCode = HttpStatus.badRequest;
      request.response.write(jsonEncode({'error': 'Invalid or missing url'}));
      await request.response.close();
      continue;
    }

    try {
      final client = HttpClient();
      final req = await client.getUrl(target);
      req.headers.set(HttpHeaders.userAgentHeader, 'news-app-proxy');
      final res = await req.close();
      final body = await res.transform(utf8.decoder).join();

      request.response.statusCode = res.statusCode;
      request.response.headers.contentType = ContentType.json;
      request.response.write(body);
      await request.response.close();
      client.close();
    } catch (e) {
      request.response.statusCode = HttpStatus.badGateway;
      request.response.write(jsonEncode({'error': 'Proxy error: $e'}));
      await request.response.close();
    }
  }
}

void _addCorsHeaders(HttpResponse response) {
  response.headers
    ..set('Access-Control-Allow-Origin', '*')
    ..set('Access-Control-Allow-Methods', 'GET, OPTIONS')
    ..set('Access-Control-Allow-Headers', 'Content-Type');
}