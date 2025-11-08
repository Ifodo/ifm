// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.schedule,
    this.oapData,
    this.nextProgram,
  });

  NextProgram? schedule;
  OapData? oapData;
  NextProgram? nextProgram;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    schedule: NextProgram.fromJson(json["schedule"]),
    oapData: OapData.fromJson(json["oapData"]),
    nextProgram: NextProgram.fromJson(json["nextProgram"]),
  );

  Map<String, dynamic> toJson() => {
    "schedule": schedule!.toJson(),
    "oapData": oapData!.toJson(),
    "nextProgram": nextProgram!.toJson(),
  };
}

class NextProgram {
  NextProgram({
    this.id,
    this.v,
    this.nextProgramId,
    this.dayOfWeek,
    this.businessLocation,
    this.programEndTime,
    this.programStartTime,
    this.end,
    this.start,
    this.oapId,
    this.title,
  });

  String? id;
  int? v;
  int? nextProgramId;
  String? dayOfWeek;
  String? businessLocation;
  DateTime? programEndTime;
  DateTime? programStartTime;
  String? end;
  String? start;
  String? oapId;
  String? title;

  factory NextProgram.fromJson(Map<String, dynamic> json) => NextProgram(
    id: json["_id"],
    v: json["__v"],
    nextProgramId: json["id"],
    dayOfWeek: json["dayOfWeek"],
    businessLocation: json["businessLocation"],
    programEndTime: DateTime.parse(json["programEndTime"]),
    programStartTime: DateTime.parse(json["programStartTime"]),
    end: json["end"],
    start: json["start"],
    oapId: json["oapID"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "__v": v,
    "id": nextProgramId,
    "dayOfWeek": dayOfWeek,
    "businessLocation": businessLocation,
    "programEndTime": programEndTime!.toIso8601String(),
    "programStartTime": programStartTime!.toIso8601String(),
    "end": end,
    "start": start,
    "oapID": oapId,
    "title": title,
  };
}

class OapData {
  OapData({
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

  factory OapData.fromJson(Map<String, dynamic> json) => OapData(
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

  Map<String, dynamic> toJson() => {
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
