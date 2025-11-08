// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

WelcomeImg welcomeFromJson(String str) => WelcomeImg.fromJson(json.decode(str));

String welcomeToJson(WelcomeImg data) => json.encode(data.toJson());

class WelcomeImg {
  WelcomeImg({
    this.msg,
    this.display,
    this.data,
  });

  String? msg;
  String? display;
  List<Datum>? data;

  factory WelcomeImg.fromJson(Map<String, dynamic> json) => WelcomeImg(
    msg: json["msg"],
    display: json["display"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "display": display,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.location,
    this.description,
    this.image,
    this.v,
    this.status,
    this.date,
    this.category,
  });

  String? id;
  String? name;
  String? location;
  String? description;
  String? image;
  int? v;
  String? status;
  DateTime? date;
  String? category;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    name: json["name"],
    location: json["location"],
    description: json["description"],
    image: json["image"],
    v: json["__v"],
    status: json["status"],
    date: DateTime.parse(json["date"]),
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "location": location,
    "description": description,
    "image": image,
    "__v": v,
    "status": status,
    "date": date!.toIso8601String(),
    "category": category,
  };
}