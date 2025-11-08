// Model for the new Now on Air API
import 'dart:convert';

NowOnAirResponse nowOnAirResponseFromJson(String str) => 
    NowOnAirResponse.fromJson(json.decode(str));

String nowOnAirResponseToJson(NowOnAirResponse data) => 
    json.encode(data.toJson());

class NowOnAirResponse {
  NowOnAirResponse({
    this.nowOnAir,
    this.upNext,
  });

  ProgramInfo? nowOnAir;
  ProgramInfo? upNext;

  factory NowOnAirResponse.fromJson(Map<String, dynamic> json) => 
      NowOnAirResponse(
        nowOnAir: json["nowOnAir"] != null 
            ? ProgramInfo.fromJson(json["nowOnAir"]) 
            : null,
        upNext: json["upNext"] != null 
            ? ProgramInfo.fromJson(json["upNext"]) 
            : null,
      );

  Map<String, dynamic> toJson() => {
        "nowOnAir": nowOnAir?.toJson(),
        "upNext": upNext?.toJson(),
      };
}

class ProgramInfo {
  ProgramInfo({
    required this.programName,
    required this.duration,
    required this.oaps,
    required this.image,
  });

  String programName;
  Duration duration;
  List<String> oaps;
  String image;

  factory ProgramInfo.fromJson(Map<String, dynamic> json) => ProgramInfo(
        programName: json["programName"] ?? "",
        duration: Duration.fromJson(json["duration"] ?? {}),
        oaps: json["oaps"] != null 
            ? List<String>.from(json["oaps"].map((x) => x.toString())) 
            : [],
        image: json["image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "programName": programName,
        "duration": duration.toJson(),
        "oaps": List<dynamic>.from(oaps.map((x) => x)),
        "image": image,
      };
}

class Duration {
  Duration({
    required this.start,
    required this.end,
  });

  String start;
  String end;

  factory Duration.fromJson(Map<String, dynamic> json) => Duration(
        start: json["start"] ?? "",
        end: json["end"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "start": start,
        "end": end,
      };
}

