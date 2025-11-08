// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<WelcomeOAPs> welcomeFromJson(String str) => List<WelcomeOAPs>.from(json.decode(str).map((x) => WelcomeOAPs.fromJson(x)));

String welcomeToJson(List<WelcomeOAPs> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WelcomeOAPs {
  WelcomeOAPs({
    this.id,
    this.oapFullName,
    this.oapPersonalityName,
    this.gender,
    this.profile,
    this.oapVideo,
    this.oapPicture,
    this.businessLocation,
    this.v,
    this.profileActive,
  });

  String? id;
  String? oapFullName;
  String? oapPersonalityName;
  String? gender;
  String? profile;
  String? oapVideo;
  String? oapPicture;
  String? businessLocation;
  int? v;
  String? profileActive;

  factory WelcomeOAPs.fromJson(Map<String, dynamic> json) =>
      WelcomeOAPs(
        id: json["_id"],
        oapFullName: json["oapFullName"],
        oapPersonalityName: json["oapPersonalityName"],
        gender: json["gender"],
        profile: json["profile"],
        oapVideo: json["oapVideo"],
        oapPicture: json["oapPicture"],
        businessLocation: json["businessLocation"],
        v: json["__v"],
        profileActive: json["profileActive"],
      );

  Map<String, dynamic> toJson() =>
      {
        "_id": id,
        "oapFullName": oapFullName,
        "oapPersonalityName": oapPersonalityName,
        "gender": gender,
        "profile": profile,
        "oapVideo": oapVideo,
        "oapPicture": oapPicture,
        "businessLocation": businessLocation,
        "__v": v,
        "profileActive": profileActive,
      };
}