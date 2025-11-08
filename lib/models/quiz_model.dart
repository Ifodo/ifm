// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

WelcomeQuiz welcomeFromJson(String str) => WelcomeQuiz.fromJson(json.decode(str));

String welcomeToJson(WelcomeQuiz data) => json.encode(data.toJson());

class WelcomeQuiz {
  WelcomeQuiz({
    this.msg,
    this.data,
  });

  String? msg;
  List<Datum>? data;

  factory WelcomeQuiz.fromJson(Map<String, dynamic> json) => WelcomeQuiz(
    msg: json["msg"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.title,
    this.questionOfDay,
    this.answerToQuestion,
    this.v,
    this.dateCreated,
    this.imageAvailable,
    this.startDate,
    this.questionOptions,
  });

  String? id;
  String? title;
  String? questionOfDay;
  String? answerToQuestion;
  int? v;
  DateTime? dateCreated;
  String? imageAvailable;
  DateTime? startDate;
  List<dynamic>? questionOptions;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    title: json["title"],
    questionOfDay: json["questionOfDay"],
    answerToQuestion: json["answerToQuestion"],
    v: json["__v"],
    dateCreated: DateTime.parse(json["dateCreated"]),
    imageAvailable: json["imageAvailable"],
    startDate: DateTime.parse(json["startDate"]),
    questionOptions: List<dynamic>.from(json["questionOptions"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "questionOfDay": questionOfDay,
    "answerToQuestion": answerToQuestion,
    "__v": v,
    "dateCreated": dateCreated!.toIso8601String(),
    "imageAvailable": imageAvailable,
    "startDate": startDate!.toIso8601String(),
    "questionOptions": List<dynamic>.from(questionOptions!.map((x) => x)),
  };
}