import 'package:inspiration/models/quiz_model.dart';
import 'package:inspiration/models/spreaker_episodes_model.dart';
import 'package:inspiration/models/spreaker_main_model.dart';
import 'package:inspiration/models/spreaker_show_model.dart';
import 'package:http/http.dart' as http;
import 'package:inspiration/models/events_model.dart';
import 'dart:convert';
import 'dart:async' show TimeoutException;

import 'package:inspiration/models/noa_model.dart';
import 'package:inspiration/models/noa_new_model.dart' hide Duration;
import 'package:inspiration/models/oap_stations_model.dart';


Future<List> fetchWpPost() async {
  final response = await http.get(Uri.parse("https://ifm923.com/wp-json/wp/v2/posts?_embed"), headers: {"Accept":"application/json"});
  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}

Future<List> fetchWpPostIb() async {
  final response = await http.get(Uri.parse("https://ifm1005.com/wp-json/wp/v2/posts?_embed"), headers: {"Accept":"application/json"});
  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}

Future<List> fetchWpPostUy() async {
  final response = await http.get(Uri.parse("https://ifm1059.com/wp-json/wp/v2/posts?_embed"), headers: {"Accept":"application/json"});
  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}

Future<List> fetchWpPostWFT() async {
  final response = await http.get(Uri.parse("http://gsafng.org/wp-json/wp/v2/posts?_embed"), headers: {"Accept":"application/json"});
  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}

Future<Welcome> nowOnAirData(String businessLocation) async {
  final response = await http.get(Uri.parse("http://backend.servoserver.com.ng:80/webapi/ifmserver/get_current_and_next_program?businessLocation=$businessLocation"), headers: {"Accept":"application/json"});
  var convertDataToJson = jsonDecode(response.body);
  print('Data from services: ${convertDataToJson['oapData']['oapPicture']}');
  return Welcome.fromJson(convertDataToJson);
}

// New Now on Air API
Future<NowOnAirResponse> getNowOnAirNew(String stationName) async {
  final response = await http.get(
    Uri.parse("https://noa.elektranbroadcast.com/api/programs/now-and-next?stationName=$stationName"), 
    headers: {"Accept":"application/json"}
  );
  var convertDataToJson = jsonDecode(response.body);
  print('New NOA Data: $convertDataToJson');
  return NowOnAirResponse.fromJson(convertDataToJson);
}

Future<List<WelcomeOAPs>> getOAPs(String station) async {
  try {
    final response = await http.get(
      Uri.parse("http://backend.servoserver.com.ng:80/api/get_oaps?businessLocation=$station"), 
      headers: {"Accept":"application/json"}
    ).timeout(
      Duration(seconds: 5),
      onTimeout: () {
        throw TimeoutException('Request timeout');
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    print('oaps: $convertDataToJson');
    return List<WelcomeOAPs>.from((convertDataToJson).map((x) => WelcomeOAPs.fromJson(x)));
  } catch (e) {
    print('Error fetching OAPs: $e');
    rethrow;
  }
}

Future<WelcomeEvent> getEvents() async {
  final response = await http.get(Uri.parse("http://backend.servoserver.com.ng:80/api/get_upcoming_events"), headers: {"Accept":"application/json"});
  var convertDataToJson = jsonDecode(response.body);
  print('Events: $convertDataToJson');
  print('Events222: ${convertDataToJson['data']}');
  return WelcomeEvent.fromJson(convertDataToJson);
}

Future<WelcomeQuiz> getQuestion() async {
  final response = await http.get(Uri.parse("http://backend.servoserver.com.ng:80/api/get_question_of_day"), headers: {"Accept":"application/json"});
  var convertDataToJson = jsonDecode(response.body);
  print('Quiz: $convertDataToJson');
  print('Quiz222: ${convertDataToJson['data']}');
  return WelcomeQuiz.fromJson(convertDataToJson);
}

Future<WelcomeSpreakerMain> getMainShow() async {
  final response = await http.get(Uri.parse("https://api.spreaker.com/v2/shows/4835626"), headers: {"Accept":"application/json"});
  var convertDataToJson = jsonDecode(response.body);
  print('Spreaker Main: $convertDataToJson');
  return WelcomeSpreakerMain.fromJson(convertDataToJson);
}

//userID = 14217498
Future<WelcomeSpreakerShow> getShows() async {
  final response = await http.get(Uri.parse("https://api.spreaker.com/v2/users/14217498/shows"), headers: {"Accept":"application/json"});
  var convertDataToJson = jsonDecode(response.body);
  print('Spreaker Show: $convertDataToJson');
  return WelcomeSpreakerShow.fromJson(convertDataToJson);
}

//showID = 4964709
Future<WelcomeSpreakerEpisode> getEpisodes(showID) async {
  final response = await http.get(Uri.parse("https://api.spreaker.com/v2/shows/$showID/episodes"), headers: {"Accept":"application/json"});
  var convertDataToJson = jsonDecode(response.body);
  print('Spreaker Episodes: $convertDataToJson');
  return WelcomeSpreakerEpisode.fromJson(convertDataToJson);
}






