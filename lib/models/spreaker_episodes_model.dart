// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

WelcomeSpreakerEpisode welcomeFromJson(String str) => WelcomeSpreakerEpisode.fromJson(json.decode(str));

String welcomeToJson(WelcomeSpreakerEpisode data) => json.encode(data.toJson());

class WelcomeSpreakerEpisode {
  WelcomeSpreakerEpisode({
    this.response,
  });

  Response? response;

  factory WelcomeSpreakerEpisode.fromJson(Map<String, dynamic> json) => WelcomeSpreakerEpisode(
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
    this.episodeId,
    this.type,
    this.title,
    this.duration,
    this.explicit,
    this.showId,
    this.authorId,
    this.imageUrl,
    this.imageOriginalUrl,
    this.imageTransformation,
    this.publishedAt,
    this.downloadEnabled,
    this.streamId,
    this.waveformUrl,
    this.siteUrl,
    this.downloadUrl,
    this.playbackUrl,
  });

  int? episodeId;
  Type? type;
  String? title;
  int? duration;
  bool? explicit;
  int? showId;
  int? authorId;
  String? imageUrl;
  String? imageOriginalUrl;
  ImageTransformation? imageTransformation;
  DateTime? publishedAt;
  bool? downloadEnabled;
  dynamic streamId;
  String? waveformUrl;
  String? siteUrl;
  String? downloadUrl;
  String? playbackUrl;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    episodeId: json["episode_id"],
    type: typeValues.map[json["type"]],
    title: json["title"],
    duration: json["duration"],
    explicit: json["explicit"],
    showId: json["show_id"],
    authorId: json["author_id"],
    imageUrl: json["image_url"],
    imageOriginalUrl: json["image_original_url"],
    imageTransformation: imageTransformationValues.map[json["image_transformation"]],
    publishedAt: DateTime.parse(json["published_at"]),
    downloadEnabled: json["download_enabled"],
    streamId: json["stream_id"],
    waveformUrl: json["waveform_url"],
    siteUrl: json["site_url"],
    downloadUrl: json["download_url"],
    playbackUrl: json["playback_url"],
  );

  Map<String, dynamic> toJson() => {
    "episode_id": episodeId,
    "type": typeValues.reverse![type],
    "title": title,
    "duration": duration,
    "explicit": explicit,
    "show_id": showId,
    "author_id": authorId,
    "image_url": imageUrl,
    "image_original_url": imageOriginalUrl,
    "image_transformation": imageTransformationValues.reverse![imageTransformation],
    "published_at": publishedAt!.toIso8601String(),
    "download_enabled": downloadEnabled,
    "stream_id": streamId,
    "waveform_url": waveformUrl,
    "site_url": siteUrl,
    "download_url": downloadUrl,
    "playback_url": playbackUrl,
  };
}

enum ImageTransformation { SQUARE_LIMITED_100 }

final imageTransformationValues = EnumValues({
  "square_limited_100": ImageTransformation.SQUARE_LIMITED_100
});

enum Type { RECORDED }

final typeValues = EnumValues({
  "RECORDED": Type.RECORDED
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
