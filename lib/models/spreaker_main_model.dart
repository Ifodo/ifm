// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

WelcomeSpreakerMain welcomeFromJson(String str) => WelcomeSpreakerMain.fromJson(json.decode(str));

String welcomeToJson(WelcomeSpreakerMain data) => json.encode(data.toJson());

class WelcomeSpreakerMain {
  WelcomeSpreakerMain({
    this.response,
  });

  Response? response;

  factory WelcomeSpreakerMain.fromJson(Map<String, dynamic> json) => WelcomeSpreakerMain(
    response: Response.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "response": response?.toJson(),
  };
}

class Response {
  Response({
    this.show,
  });

  Show? show;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    show: Show.fromJson(json["show"]),
  );

  Map<String, dynamic> toJson() => {
    "show": show?.toJson(),
  };
}

class Show {
  Show({
    this.showId,
    this.title,
    this.imageUrl,
    this.imageOriginalUrl,
    this.explicit,
    this.authorId,
    this.lastEpisodeAt,
    this.siteUrl,
    this.description,
    this.categoryId,
    this.language,
    this.permalink,
    this.coverImageUrl,
    this.coverOffset,
    this.episodesSorting,
    this.author,
    this.websiteUrl,
    this.email,
    this.facebookUrl,
    this.itunesUrl,
    this.twitterName,
    this.skypeName,
    this.telNumber,
    this.smsNumber,
  });

  int? showId;
  String? title;
  String? imageUrl;
  String? imageOriginalUrl;
  bool? explicit;
  int? authorId;
  DateTime? lastEpisodeAt;
  String? siteUrl;
  String? description;
  int? categoryId;
  String? language;
  String? permalink;
  dynamic coverImageUrl;
  dynamic coverOffset;
  String? episodesSorting;
  Author? author;
  dynamic websiteUrl;
  dynamic email;
  dynamic facebookUrl;
  dynamic itunesUrl;
  dynamic twitterName;
  dynamic skypeName;
  dynamic telNumber;
  dynamic smsNumber;

  factory Show.fromJson(Map<String, dynamic> json) => Show(
    showId: json["show_id"],
    title: json["title"],
    imageUrl: json["image_url"],
    imageOriginalUrl: json["image_original_url"],
    explicit: json["explicit"],
    authorId: json["author_id"],
    lastEpisodeAt: DateTime.parse(json["last_episode_at"]),
    siteUrl: json["site_url"],
    description: json["description"],
    categoryId: json["category_id"],
    language: json["language"],
    permalink: json["permalink"],
    coverImageUrl: json["cover_image_url"],
    coverOffset: json["cover_offset"],
    episodesSorting: json["episodes_sorting"],
    author: Author.fromJson(json["author"]),
    websiteUrl: json["website_url"],
    email: json["email"],
    facebookUrl: json["facebook_url"],
    itunesUrl: json["itunes_url"],
    twitterName: json["twitter_name"],
    skypeName: json["skype_name"],
    telNumber: json["tel_number"],
    smsNumber: json["sms_number"],
  );

  Map<String, dynamic> toJson() => {
    "show_id": showId,
    "title": title,
    "image_url": imageUrl,
    "image_original_url": imageOriginalUrl,
    "explicit": explicit,
    "author_id": authorId,
    "last_episode_at": lastEpisodeAt?.toIso8601String(),
    "site_url": siteUrl,
    "description": description,
    "category_id": categoryId,
    "language": language,
    "permalink": permalink,
    "cover_image_url": coverImageUrl,
    "cover_offset": coverOffset,
    "episodes_sorting": episodesSorting,
    "author": author?.toJson(),
    "website_url": websiteUrl,
    "email": email,
    "facebook_url": facebookUrl,
    "itunes_url": itunesUrl,
    "twitter_name": twitterName,
    "skype_name": skypeName,
    "tel_number": telNumber,
    "sms_number": smsNumber,
  };
}

class Author {
  Author({
    this.userId,
    this.fullname,
    this.siteUrl,
    this.imageUrl,
    this.imageOriginalUrl,
    this.acceptLatestTosUrl,
    this.username,
    this.description,
    this.kind,
    this.plan,
  });

  int? userId;
  String? fullname;
  String? siteUrl;
  String? imageUrl;
  String? imageOriginalUrl;
  dynamic acceptLatestTosUrl;
  String? username;
  String? description;
  String? kind;
  String? plan;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    userId: json["user_id"],
    fullname: json["fullname"],
    siteUrl: json["site_url"],
    imageUrl: json["image_url"],
    imageOriginalUrl: json["image_original_url"],
    acceptLatestTosUrl: json["accept_latest_tos_url"],
    username: json["username"],
    description: json["description"],
    kind: json["kind"],
    plan: json["plan"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "fullname": fullname,
    "site_url": siteUrl,
    "image_url": imageUrl,
    "image_original_url": imageOriginalUrl,
    "accept_latest_tos_url": acceptLatestTosUrl,
    "username": username,
    "description": description,
    "kind": kind,
    "plan": plan,
  };
}
