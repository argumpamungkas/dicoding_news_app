import 'package:flutter/material.dart';
import 'package:news_app/package/custom_scaffold.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleWebView extends StatelessWidget {
  static const routeName = "/article_web_view";

  const ArticleWebView({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()..loadRequest(Uri.parse(url));
    return CustomScaffold(
      body: WebViewWidget(controller: controller),
    );
  }
}
