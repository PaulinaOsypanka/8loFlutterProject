// To parse this JSON data, do
//
//     final articles = articlesFromJson(jsonString);

import 'dart:convert';

List<Article> articlesFromJson(String str) =>
    List<Article>.from(json.decode(str).map((x) => Article.fromJson(x)));

String articlesToJson(List<Article> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Article {
  int id;
  String link;
  String title;
  String lead;
  String date;
  String author;
  String content;
  List<ExternalLink> externalLinks;
  List<ExternalLink> images;
  List<Tag> tags;

  Article({
    required this.id,
    required this.link,
    required this.title,
    required this.lead,
    required this.date,
    required this.author,
    required this.content,
    required this.externalLinks,
    required this.images,
    required this.tags,
  });

  factory Article.fromRawJson(String str) => Article.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        id: json["id"],
        link: json["link"],
        title: json["title"],
        lead: json["lead"],
        date: json["date"],
        author: json["author"],
        content: json["content"],
        externalLinks: List<ExternalLink>.from(
            json["externalLinks"].map((x) => ExternalLink.fromJson(x))),
        images: List<ExternalLink>.from(
            json["images"].map((x) => ExternalLink.fromJson(x))),
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "link": link,
        "title": title,
        "lead": lead,
        "date": date,
        "author": author,
        "content": content,
        "externalLinks":
            List<dynamic>.from(externalLinks.map((x) => x.toJson())),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
      };
}

class ExternalLink {
  String link;

  ExternalLink({
    required this.link,
  });

  factory ExternalLink.fromRawJson(String str) =>
      ExternalLink.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ExternalLink.fromJson(Map<String, dynamic> json) => ExternalLink(
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "link": link,
      };
}

class Tag {
  String name;

  Tag({
    required this.name,
  });

  factory Tag.fromRawJson(String str) => Tag.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
