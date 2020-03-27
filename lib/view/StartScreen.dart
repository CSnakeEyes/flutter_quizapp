import 'package:flutter/material.dart';
import 'package:flutter_quizapp/controller/Quiz.dart';
import 'package:flutter_quizapp/view/LoginScreen.dart';
import 'package:flutter_quizapp/widgets/CustomButton.dart';
import 'package:flutter_quizapp/widgets/LoadingModal.dart';

import 'QuizScreen.dart';

class StartScreen extends StatefulWidget {
  static final String id = "start_screen";

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final Quiz quiz = Quiz();
  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 18.0);
  final List<String> quizes = [
    'Quiz 0',
    'Quiz 1',
    'Quiz 2',
    'Quiz 3',
    'Quiz 4',
    'Quiz 5',
    'Quiz 6',
    'Quiz 7',
  ];

  String error;
  bool visible = false;
  String dropdownValue = 'Quiz 0';
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'QuizApp',
        ),
        textTheme: TextTheme(
          title: TextStyle(
            fontFamily: 'Lobster',
            fontSize: 30,
            color: Colors.black,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(36.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
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
                Text(
                  "Select a quiz:",
                  style: style.copyWith(),
                ),
                SizedBox(height: 10.0),
                DropdownButton(
                  isExpanded: true,
                  value: dropdownValue,
                  style: style.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 30,
                  elevation: 5,
                  items: generateDropdownItems(),
                  onChanged: (newValue) {
                    setState(() {
                      // ignore: unrelated_type_equality_checks
                      selectedIndex =
                          quizes.indexWhere((item) => item == newValue);
                      dropdownValue = newValue;
                    });
                  },
                ),
                SizedBox(height: 30.0),
                CustomButton(
                  text: "Start quiz",
                  contained: true,
                  onPressed: () async {
                    setState(() => visible = true);
                    bool check = await quiz.startQuiz(selectedIndex);
                    setState(() => visible = false);
                    if (check) {
                      Navigator.pushNamed(context, QuizScreen.id);
                    } else {
                      setState(() => error = quiz.error);
                    }
                  },
                ),
                SizedBox(height: 20.0),
                CustomButton(
                  text: "Log out",
                  contained: false,
                  onPressed: () {
                    Navigator.popUntil(
                        context, ModalRoute.withName(LoginScreen.id));
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

  List<DropdownMenuItem<String>> generateDropdownItems() {
    return quizes.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }
}
