import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/ui/detail_page.dart';

class HomePage extends StatelessWidget {
  static const routeName = "/home_page";

  const HomePage({super.key});

  List<Article> parseArticles(String? json) {
    if (json == null) {
      return [];
    }

    final List parsed = jsonDecode(json);
    return parsed.map((json) => Article.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("News App"),
        ),
        body: FutureBuilder(
          future:
              DefaultAssetBundle.of(context).loadString("assets/articles.json"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            final List<Article> articles = parseArticles(snapshot.data);
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return _buildArticleItem(context, articles[index]);
              },
            );
          },
        ));
  }
}

Widget _buildArticleItem(BuildContext context, Article article) {
  return ListTile(
    onTap: () => Navigator.pushNamed(
      context,
      DetailPage.routeName,
      arguments: article,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    leading: Hero(
      tag: article.urlToImage,
      child: Image.network(
        article.urlToImage,
        width: 100,
        errorBuilder: (ctx, error, _) => const Center(child: Icon(Icons.error)),
      ),
    ),
    title: Text(article.title),
    subtitle: Text(article.author),
  );
}
