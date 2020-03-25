import 'package:flutter/material.dart';
import 'package:flutter_quizapp/StartQuiz.dart';

import 'controller/Quiz.dart';

class GradeQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Grade();
  }
}

class Grade extends StatefulWidget {
  @override
  _GradeState createState() => _GradeState();
}

class _GradeState extends State<Grade> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  Quiz quiz = Quiz();

  @override
  Widget build(BuildContext context) {
    var evaluation = quiz.evaluate();

    final reviewButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xFFFFC107),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          quiz.startReview();
          Navigator.pop(context);
        },
        child: Text("Review Wrong Questions",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final exitButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff37474F),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          //Navigator.pushAndRemoveUntil(context, newRoute, predicate)
          Navigator.popUntil(context, (routes) => routes == StartQuiz());
          //Navigator.popAndPushNamed(context, '.StartQuiz');
        },
        child: Text("Exit",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Congratulations',
          ),
          textTheme: TextTheme(
              title: TextStyle(
                  fontFamily: 'Lobster', fontSize: 30, color: Colors.black)),
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.all(36.0),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Grade',
                  style: style.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                      fontSize: 50.0),
                ),
                SizedBox(height: 25.0),
                Text(
                  '${evaluation['grade'] / 10}/10.0',
                  style: style.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 65.0),
                ),
                SizedBox(height: 100.0),
                reviewButton,
                SizedBox(height: 25.0),
                exitButton
              ],
            )),
          ),
        ));
  }
}
