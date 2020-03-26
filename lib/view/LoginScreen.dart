import 'package:flutter/material.dart';
import 'package:flutter_quizapp/controller/Quiz.dart';
import 'package:flutter_quizapp/widgets/CustomButton.dart';
import 'package:flutter_quizapp/widgets/CustomTextField.dart';
import 'package:flutter_quizapp/widgets/LoadingModal.dart';

import 'StartScreen.dart';

class LoginScreen extends StatefulWidget {
  static final String id = "login_screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Quiz quiz = Quiz();

  bool visible = false;
  String error;
  String username;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(36.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 135.0,
                  child: Text(
                    'QuizApp',
                    style: TextStyle(fontSize: 75, fontFamily: 'Lobster'),
                  ),
                ),
                (error != null)
                    ? Container(
                        child: Text(
                          error,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18.0,
                          ),
                        ),
                      )
                    : SizedBox(),
                CustomTextField(
                  hintText: "Username",
                  obscure: false,
                  onChanged: (input) {
                    setState(() {
                      username = input;
                    });
                  },
                ),
                SizedBox(height: 25.0),
                CustomTextField(
                  hintText: "Password",
                  obscure: true,
                  onChanged: (input) {
                    setState(() {
                      password = input;
                    });
                  },
                ),
                SizedBox(height: 40.0),
                CustomButton(
                  text: "Login",
                  contained: true,
                  onPressed: () async {
                    error = null;
                    quiz.username = username;
                    quiz.pin = password;
                    setState(() {
                      visible = true;
                    });
                    bool check = await quiz.startQuiz(0);
                    setState(() {
                      visible = false;
                    });
                    if (check) {
                      Navigator.pushNamed(context, StartScreen.id);
                    } else {
                      setState(() => error = quiz.error);
                    }
                  },
                ),
              ],
            ),
          ),
          LoadingModal(visible),
        ],
      ),
    );
  }
}
