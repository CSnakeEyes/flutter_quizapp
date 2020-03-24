import 'package:flutter/material.dart';

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
  Quiz quiz = Quiz();

  @override
  Widget build(BuildContext context) {
    var evaluation = quiz.evaluate();

    return Scaffold(
      body: Center(
        child: Text(
          'Congratulation you have finished the quiz! \n'
              'With a grade of ${quiz.getProgress()}'
        ),
      ),
    );
  }
}