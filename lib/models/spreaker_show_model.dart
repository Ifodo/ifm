// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

WelcomeSpreakerShow welcomeFromJson(String str) => WelcomeSpreakerShow.fromJson(json.decode(str));

String welcomeToJson(WelcomeSpreakerShow data) => json.encode(data.toJson());

class WelcomeSpreakerShow {
  WelcomeSpreakerShow({
    this.response,
  });

  Response? response;

  factory WelcomeSpreakerShow.fromJson(Map<String, dynamic> json) => WelcomeSpreakerShow(
    response: Response.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "response": response?.toJson(),
  };
}

class Response {
  Response({
    this.items,
    this.nextUrl,
  });

  List<Item>? items;
  dynamic nextUrl;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    nextUrl: json["next_url"],
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    "next_url": nextUrl,
  };
}

class Item {
  Item({
    this.showId,
    this.title,
    this.imageUrl,
    this.imageOriginalUrl,
    this.explicit,
    this.authorId,
    this.lastEpisodeAt,
    this.siteUrl,
  });

  int? showId;
  String? title;
  String? imageUrl;
  String? imageOriginalUrl;
  bool? explicit;
  int? authorId;
  DateTime? lastEpisodeAt;
  String? siteUrl;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    showId: json["show_id"],
    title: json["title"],
    imageUrl: json["image_url"],
    imageOriginalUrl: json["image_original_url"],
    explicit: json["explicit"],
    authorId: json["author_id"],
    lastEpisodeAt: DateTime.parse(json["last_episode_at"]),
    siteUrl: json["site_url"],
  );

  Map<String, dynamic> toJson() => {
    "show_id": showId,
    "title": title,
    "image_url": imageUrl,
    "image_original_url": imageOriginalUrl,
    "explicit": explicit,
    "author_id": authorId,
    "last_episode_at": lastEpisodeAt!.toIso8601String(),
    "site_url": siteUrl,
  };
}
