import 'package:flutter/material.dart';
import 'package:flutter_quizapp/controller/Quiz.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return QuizQuestion(title: 'Flutter Quizapp');
  }
}

class QuizQuestion extends StatefulWidget {
  QuizQuestion({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _QuizQuestionState createState() => _QuizQuestionState();
}

class _QuizQuestionState extends State<QuizQuestion> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  Quiz quiz = Quiz();
  Map currentQuestion;
  int selectedBox;

  _QuizQuestionState() {
    currentQuestion = quiz.getCurrentQuestion();
  }

  void goToNextQuestion() {
    setState(() {
      selectedBox = null;
      quiz.next();
      currentQuestion = quiz.getCurrentQuestion();
    });
  }

  void goToPrevQuestion() {
    setState(() {
      selectedBox = null;
      quiz.previous();
      currentQuestion = quiz.getCurrentQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    final answerField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Write your answer here",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final submitButton = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xFFFFC107),
        child: IconButton(
            icon: Icon(Icons.file_upload),
            color: Colors.white,
            tooltip: 'Submit quiz',
            onPressed: () {}));

    final previousButton = IconButton(
        icon: Icon(Icons.arrow_back_ios),
        color: Color(0xFFFFC107),
        tooltip: 'Previous question',
        onPressed: () {
          goToPrevQuestion();
        });

    final nextButton = IconButton(
        icon: Icon(Icons.arrow_forward_ios),
        color: Color(0xFFFFC107),
        tooltip: 'Next question',
        onPressed: () {
          goToNextQuestion();
        });

    return Scaffold(
        body: Center(
            child: Container(
      child: Padding(
        padding: EdgeInsets.all(35.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text("${currentQuestion['stem']}",
                      style: style.copyWith(fontWeight: FontWeight.bold)),
                )
              ],
            ),
            (currentQuestion["options"] != null)
                ? Column(
                    children: _buildCheckboxes(currentQuestion["options"]),
                  )
                : answerField,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[previousButton, submitButton, nextButton],
            )
          ],
        ),
      ),
    )));
  }

  List<Widget> _buildCheckboxes(List<dynamic> options) {
    return options.asMap().entries.map((entry) {
      return CheckboxListTile(
        title: Text(entry.value),
        value: selectedBox == entry.key,
        onChanged: (newValue) {
          setState(() {
            selectedBox = entry.key;
          });
        },
        controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
      );
    }).toList();
  }
}
