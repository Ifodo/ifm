import 'package:inspiration/models/quiz_model.dart';
import 'package:inspiration/pages/home_page.dart';
import 'package:inspiration/services/webservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SubmitQuiz extends StatefulWidget {
  const SubmitQuiz({super.key});

  @override
  _SubmitQuizState createState() => _SubmitQuizState();
}

class _SubmitQuizState extends State<SubmitQuiz> {
  String? uploadProgress;
  String? userId;
  String? fullName;
  String? questionId;

  final myControllerUserAnswer = TextEditingController();
  final _formkeyAnswer = GlobalKey<FormState>();

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void _showScaffold(String message) {
    scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  void initState() {
    super.initState();
    _getSharedPrefs();
  }


  _getSharedPrefs() async {
    var prefs = await SharedPreferences.getInstance();
    var myStringList = prefs.getStringList('ifmData1') ?? [];
    userId = myStringList[0];
    fullName = myStringList[1];
    print('from pref: $userId');
  }


  void submitAnswer() async {
    print(myControllerUserAnswer.text);
    print('$questionId');
    print('$fullName');
    print('$userId');
    try {
      var response = await Dio().post(
          'http://165.227.13.193:80/api/submit_answer',
          data: {
            "questionID": questionId,
            "userID": userId,
            "fullname": fullName,
            "answerToQuestion": myControllerUserAnswer.text,

          },
          onSendProgress: (actualBytes, totalBytes){
            var percentage = actualBytes / totalBytes * 100;
            setState(() {
              uploadProgress = 'Uploading... ${percentage.floor()} %';
            });
          });
      _showScaffold(response.data['display']);
      print('File uploaded response from server Answer: $response');
      setState(() {
        uploadProgress = '';
      });
      myControllerUserAnswer.text = '';
      //_showScaffold('Your Answer was submitted Successfully');
      //_showSnackBarMsg(response.data['display']);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                  pageIndx: 7
              )
          )

      );
    } catch (e) {
      print('Exception $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldMessengerKey,
      body: SingleChildScrollView(
        child: Container(
          margin:
          const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 15.0),
          width: screenWidth,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: FutureBuilder<WelcomeQuiz>(
              future: getQuestion(),
              builder: (context, snapshot) {
                print('sssssssssIII: ${snapshot.hasData}');
                print('sssaaaAS: ${snapshot.connectionState}');
                if (snapshot.hasData) {
                  if(snapshot.data!.data!.isEmpty){
                    print('Quiz has no data');
                    return Padding(
                      padding: const EdgeInsets.only(top: 150),
                      child: Container(
                        child: const Column(
                          children: [
                            Center(
                                child: Text('No Giveaway available at this time',
                                    style: TextStyle(
                                        fontFamily: 'Gotham XLight',
                                        color: Color(0xff264796),
                                        fontWeight: FontWeight.w900))),
                            SizedBox(height: 10.0),
                          ],
                        ),
                      ),
                    );
                  }
                  return Container(
                    child: ListView.builder(
                      itemCount: snapshot.data!.data!.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,

                      itemBuilder: (context, index) {
                        var myData = snapshot.data!.data![index];
                        questionId = snapshot.data!.data![index].id;
                        print('Loaded event: $myData');
                        //return Container();
                        return Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                                child: Container(
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Question: ',
                                          overflow:
                                          TextOverflow.visible,
                                          maxLines: 4,
                                          style: TextStyle(
                                              fontSize: 17.0,
                                              color: Color(
                                                  0xff2a166f),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          myData.questionOfDay.toString(),
                                          overflow:
                                          TextOverflow.visible,
                                          maxLines: 5,
                                          style: const TextStyle(
                                              fontSize: 16.0,
                                              color: Color(
                                                  0xff2a166f)),
                                        ),
                                      ],
                                    )
                                ),

                              ),
                              const SizedBox(height: 20.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
                                child: SizedBox(
                                    width: screenWidth / 1.2,
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Give your correct Answer: ',
                                          overflow:
                                          TextOverflow.visible,
                                          maxLines: 4,
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Color(
                                                  0xff2a166f),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Form(
                                          key: _formkeyAnswer,
                                          child: Column(
                                            children: [
                                              Container(
                                                child: TextFormField(
                                                  autofocus: true,
                                                  maxLines: 5,
                                                  decoration: InputDecoration(
                                                    labelStyle: const TextStyle(fontSize: 19.0, fontFamily: 'Gotham XLight'),
                                                    border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(12)),
                                                  ),
                                                  validator: (val) => val!.isEmpty ? 'Enter your Answer' : null,
                                                  controller: myControllerUserAnswer,
                                                  onChanged: (value) {
                                                    if(value.isNotEmpty){
                                                      _formkeyAnswer.currentState!.validate();
                                                    }
                                                  },
                                                ),
                                              ),
                                              const SizedBox(height: 25.0),

                                              SizedBox(
                                                width: screenWidth / 3,
                                                height: 40,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    textStyle: WidgetStateProperty.all(const TextStyle(color: Colors.white)),
                                                    backgroundColor: WidgetStateProperty.all(const Color(0xff264796)),
                                                    elevation: WidgetStateProperty.all(10.0),
                                                    side: WidgetStateProperty.all(const BorderSide(color: Colors.black26)),
                                                    shape: WidgetStateProperty.all<OutlinedBorder>(
                                                        const RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(10.0),
                                                          ),
                                                        )),
                                                  ),
                                                  onPressed: () {
                                                    if(_formkeyAnswer.currentState!.validate()){
                                                      submitAnswer();
                                                    }
                                                  },
                                                  child: const Text('Submit', style: TextStyle(fontSize: 20, fontFamily: 'Gotham Xlight')),
                                                ),
                                              ),
                                              const SizedBox(height: 10.0),
                                              Text(uploadProgress ?? '')
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                ),

                              ),



                            ],
                          ),
                        );

                      },
                    ),
                  );
                }
                return const Center(child: CupertinoActivityIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }
}
