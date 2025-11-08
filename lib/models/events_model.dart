// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

WelcomeEvent welcomeFromJson(String str) => WelcomeEvent.fromJson(json.decode(str));

String welcomeToJson(WelcomeEvent data) => json.encode(data.toJson());

class WelcomeEvent {
  WelcomeEvent({
    this.msg,
    this.data,
    this.paystackApi,
  });

  String? msg;
  List<Datum>? data;
  String? paystackApi;

  factory WelcomeEvent.fromJson(Map<String, dynamic> json) => WelcomeEvent(
    msg: json["msg"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    paystackApi: json["paystackAPI"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "paystackAPI": paystackApi,
  };
}

class Datum {
  Datum({
    this.id,
    this.eventName,
    this.city,
    this.venue,
    this.videoDisplay,
    this.videoLink,
    this.categoryName1,
    this.categoryName2,
    this.categoryName3,
    this.businessLocation,
    this.eventImage,
    this.uploadedBy,
    this.v,
    this.eventTimeString,
    this.eventDateString,
    this.eventDate,
    this.categoryCost3,
    this.categoryCost2,
    this.categoryCost1,
  });

  String? id;
  String? eventName;
  String? city;
  String? venue;
  String? videoDisplay;
  String? videoLink;
  String? categoryName1;
  String? categoryName2;
  String? categoryName3;
  String? businessLocation;
  String? eventImage;
  String? uploadedBy;
  int? v;
  String? eventTimeString;
  String? eventDateString;
  DateTime? eventDate;
  int? categoryCost3;
  int? categoryCost2;
  int? categoryCost1;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    eventName: json["eventName"],
    city: json["city"],
    venue: json["venue"],
    videoDisplay: json["videoDisplay"],
    videoLink: json["videoLink"],
    categoryName1: json["categoryName1"],
    categoryName2: json["categoryName2"],
    categoryName3: json["categoryName3"],
    businessLocation: json["businessLocation"],
    eventImage: json["eventImage"],
    uploadedBy: json["uploadedBy"],
    v: json["__v"],
    eventTimeString: json["eventTimeString"],
    eventDateString: json["eventDateString"],
    eventDate: DateTime.parse(json["eventDate"]),
    categoryCost3: json["categoryCost3"],
    categoryCost2: json["categoryCost2"],
    categoryCost1: json["categoryCost1"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "eventName": eventName,
    "city": city,
    "venue": venue,
    "videoDisplay": videoDisplay,
    "videoLink": videoLink,
    "categoryName1": categoryName1,
    "categoryName2": categoryName2,
    "categoryName3": categoryName3,
    "businessLocation": businessLocation,
    "eventImage": eventImage,
    "uploadedBy": uploadedBy,
    "__v": v,
    "eventTimeString": eventTimeString,
    "eventDateString": eventDateString,
    "eventDate": eventDate!.toIso8601String(),
    "categoryCost3": categoryCost3,
    "categoryCost2": categoryCost2,
    "categoryCost1": categoryCost1,
  };
}
