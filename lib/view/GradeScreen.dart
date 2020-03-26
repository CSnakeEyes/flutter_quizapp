import 'package:flutter/material.dart';
import 'package:flutter_quizapp/controller/Quiz.dart';
import 'package:flutter_quizapp/view/ReviewScreen.dart';
import 'package:flutter_quizapp/view/StartScreen.dart';
import 'package:flutter_quizapp/widgets/CustomButton.dart';

class GradeScreen extends StatefulWidget {
  static final String id = "grade_screen";

  @override
  _GradeScreenState createState() => _GradeScreenState();
}

class _GradeScreenState extends State<GradeScreen> {
  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final Quiz quiz = Quiz();

  Map evaluation;

  _GradeScreenState() {
    evaluation = quiz.evaluate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Congratulations',
          ),
          textTheme: TextTheme(
            title: TextStyle(
              fontFamily: 'Lobster',
              fontSize: 30,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(36.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Grade',
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w100,
                    fontSize: 50.0),
              ),
              SizedBox(height: 25.0),
              Text(
                '${evaluation['grade']}/10.0',
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 65.0),
              ),
              SizedBox(height: 100.0),
              (evaluation['correct'] == quiz.questions.length)
                  ? SizedBox()
                  : CustomButton(
                      text: "Review Wrong Questions",
                      onPressed: () {
                        quiz.startReview();
                        Navigator.popAndPushNamed(context, ReviewScreen.id);
                      },
                    ),
              SizedBox(height: 25.0),
              CustomButton(
                text: "Exit",
                contained: false,
                onPressed: () {
                  quiz.resetQuiz();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    StartScreen.id,
                    ModalRoute.withName(StartScreen.id),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
