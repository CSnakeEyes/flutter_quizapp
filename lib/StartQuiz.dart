import 'package:flutter/material.dart';

import 'package:flutter_quizapp/QuizScreen.dart';

import 'controller/Quiz.dart';

class StartQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomePage(title: 'Flutter Quizapp');
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  String dropdownValue = 'Quiz 0';
  int selectedQuiz = 0;

  List<DropdownMenuItem<String>> quizList = ['Quiz 0', 'Quiz 1', 'Quiz 2', 'Quiz 3', 'Quiz 4', 'Quiz 5', 'Quiz 6', 'Quiz 7']
      .map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList();

  @override
  Widget build(BuildContext context) {
    final quizMenu = DropdownButton(
        value: dropdownValue,
        style: style.copyWith(
          color: Colors.black, fontWeight: FontWeight.bold
        ),
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 30,
        elevation: 5,
        items: quizList,
        onChanged: (String newValue) {
          setState(() {
            // ignore: unrelated_type_equality_checks
            selectedQuiz = quizList.indexWhere((item) => item == newValue);
            dropdownValue = newValue;
          });
        }
    );

    final startButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xFFFFC107),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          Quiz quiz = Quiz();
          bool check = await quiz.startQuiz(7);
          if (check) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuizScreen()),
            );
          }
        },
        child: Text("Start Quiz",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final logoutButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff37474F),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("Log Out",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'QuizApp',
        ),
        textTheme: TextTheme(
            title: TextStyle(
                fontFamily: 'Lobster', fontSize: 30, color: Colors.black)),
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                quizMenu,
                SizedBox(height: 25.0),
                startButton,
                SizedBox(height: 25.0),
                logoutButton
              ],
            ),
          ),
        ),
      ),
    );
  }
}
