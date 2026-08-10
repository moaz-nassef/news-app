import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/shared/bottom_navigation.dart';
import '../../../../core/themes/my_theme.dart';

class ArticleView extends StatefulWidget {

  final String articleUrl;
  final String articleName;
  const ArticleView({super.key, required this.articleUrl, required this.articleName});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        launchUrl(Uri.parse(widget.articleUrl), mode: LaunchMode.externalApplication);
      });
    }
  }

  Future<void> _openInBrowser() async {
    await launchUrl(
      Uri.parse(widget.articleUrl),
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: null,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //normal text
              // const Text(
              //   "Flutter",
              //   style: TextStyle(
              //     letterSpacing: -.5,
              //     fontSize: 28,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),

              //gradient text
              GradientText("News",
                  style: const TextStyle(
                    letterSpacing: -.5,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                  colors: [
                    MyTheme.myTheme.colorScheme.primary,
                    MyTheme.myTheme.colorScheme.secondary,
                    MyTheme.myTheme.colorScheme.tertiary,
                  ])
            ],
          ),
          centerTitle: false,
          elevation: .1,
          actions: [
            IconButton(onPressed: ()async{
              await Share.share('Read the article : ${widget.articleName}\n Link : ${widget.articleUrl}');
            }, icon: const Icon(CupertinoIcons.share)),
            IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.heart))
          ],
          bottom: const PreferredSize(preferredSize: Size(0, 6), child: SizedBox()),
        ),

        bottomNavigationBar: const BottomNavigation(),
        body: kIsWeb
            ? Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(CupertinoIcons.link, size: 56, color: Colors.black54),
                      const SizedBox(height: 16),
                      Text(
                        "WebView isn't available on the web.\nThe article was opened in a new tab.",
                        textAlign: TextAlign.center,
                        style: MyTheme.myTheme.textTheme.displayMedium,
                      ),
                      const SizedBox(height: 24),
                      MaterialButton(
                        onPressed: _openInBrowser,
                        color: Colors.black,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text("Open the article"),
                      ),
                    ],
                  ),
                ),
              )
            : _WebArticleView(url: widget.articleUrl));
  }
}

class _WebArticleView extends StatefulWidget {
  const _WebArticleView({required this.url});

  final String url;

  @override
  State<_WebArticleView> createState() => _WebArticleViewState();
}

class _WebArticleViewState extends State<_WebArticleView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}