import 'package:flutter/material.dart';
import 'package:flutter_quizapp/view/GradeScreen.dart';
import 'package:flutter_quizapp/view/QuizScreen.dart';
import 'package:flutter_quizapp/view/StartScreen.dart';

import 'view/LoginScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: LoginScreen(),
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        StartScreen.id: (context) => StartScreen(),
        QuizScreen.id: (context) => QuizScreen(),
        GradeScreen.id: (context) => GradeScreen(),
      },
    );
  }
}
