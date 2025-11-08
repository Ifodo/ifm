import 'package:inspiration/widgets/submit_quiz.dart';
import 'package:flutter/material.dart';
import 'package:inspiration/widgets/register_for_quiz.dart';


// ignore: must_be_immutable
class Quiz extends StatefulWidget {
  const Quiz({super.key});



  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {

  @override
  void initState() {
    super.initState();
  }

  int index = 1;
  List<Widget> list = [
    const SubmitQuiz(),
    const RegisterQuiz()
  ];


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: list[index],
      );
  }




}
