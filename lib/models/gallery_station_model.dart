// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<WelcomeStation> welcomeFromJson(String str) => List<WelcomeStation>.from(json.decode(str).map((x) => WelcomeStation.fromJson(x)));

String welcomeToJson(List<WelcomeStation> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WelcomeStation {
  WelcomeStation({
    this.id,
    this.title,
    this.galleryImage,
    this.businessLocation,
    this.v,
    this.date,
  });

  String? id;
  String? title;
  String? galleryImage;
  String? businessLocation;
  int? v;
  DateTime? date;

  factory WelcomeStation.fromJson(Map<String, dynamic> json) => WelcomeStation(
    id: json["_id"],
    title: json["title"],
    galleryImage: json["galleryImage"],
    businessLocation: json["businessLocation"],
    v: json["__v"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "galleryImage": galleryImage,
    "businessLocation": businessLocation,
    "__v": v,
    "date": date!.toIso8601String(),
  };
}
