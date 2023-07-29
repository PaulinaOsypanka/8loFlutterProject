import 'package:flutter/material.dart';
import 'package:lo_news/app_provider.dart';

import 'article.dart';

extension BuildContextExt on BuildContext {
  bool get isLargeScreen {
    Size size = MediaQuery.of(this).size;
    double width = size.width > size.height ? size.height : size.width;

    return width > 600;
  }

  // Accounts for extremely large screens
  bool get isExpanded {
    Size size = MediaQuery.of(this).size;
    double width = size.width > size.height ? size.height : size.width;

    return width > 1200;
  }

  static Article initialArticle = Article(
      link: "link",
      title: "title",
      lead: "lead",
      date: "date",
      author: "author",
      content: "content",
      externalLinks: List.empty(),
      images: List.empty(),
      tags: List.empty());

  static List<Article>? _jobs = List<Article>.filled(1, initialArticle);

  static set jobs(List<Article>? val) => _jobs = val;

  static List<Article>? get jobs {
    return _jobs;
  }

  AppProvider get provider => AppProvider.of(this);
}
