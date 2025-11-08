// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<WelcomeCommuter> welcomeFromJson(String str) => List<WelcomeCommuter>.from(json.decode(str).map((x) => WelcomeCommuter.fromJson(x)));

String welcomeToJson(List<WelcomeCommuter> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WelcomeCommuter {
  WelcomeCommuter({
    this.id,
    this.name,
    this.location,
    this.description,
    this.v,
    this.status,
    this.date,
  });

  String? id;
  String? name;
  String? location;
  String? description;
  int? v;
  String? status;
  DateTime? date;

  factory WelcomeCommuter.fromJson(Map<String, dynamic> json) => WelcomeCommuter(
    id: json["_id"],
    name: json["name"],
    location: json["location"],
    description: json["description"],
    v: json["__v"],
    status: json["status"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "location": location,
    "description": description,
    "__v": v,
    "status": status,
    "date": date!.toIso8601String(),
  };
}
