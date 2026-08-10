import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../features/home/data/model/aticle_model.dart';

const String apiKey = '3bb62a86f53449d59934eacdf7ae37fa';

/// Local CORS proxy started by `dart run tool/news_proxy.dart`.
const String _proxyBase = 'http://127.0.0.1:8090/';

/// newsapi.org does not send CORS headers, so web builds must go through the
/// local proxy while mobile/desktop builds can call the API directly.
bool get _usesProxy => kIsWeb;

Future<List<ArticleModel>?> fetchTopHeadlines({String? category}) async {
  final params = {
    'country': 'us',
    'apiKey': apiKey,
    if (category != null) 'category': category,
  };

  final uri = _usesProxy
      ? Uri.parse(_proxyBase).replace(queryParameters: {
          'url': Uri.https('newsapi.org', '/v2/top-headlines', params).toString(),
        })
      : Uri.https('newsapi.org', '/v2/top-headlines', params);

  try {
    final response = await http.get(uri);
    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    if (decoded['status'] != 'ok') return null;

    final rawArticles = decoded['articles'] as List<dynamic>? ?? const [];

    return rawArticles
        .map((article) => ArticleModel(
              source: article['source']?['name'],
              author: article['author'],
              title: article['title'],
              description: article['description'],
              articleUrl: article['url'],
              imageUrl: article['urlToImage'],
              publishedAt: article['publishedAt'],
              content: article['content'],
            ))
        .toList();
  } catch (e) {
    debugPrint('NewsApiClient error: $e');
    return null;
  }
}