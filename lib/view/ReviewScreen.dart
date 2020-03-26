import 'package:flutter/material.dart';
import 'package:flutter_quizapp/controller/Quiz.dart';
import 'package:flutter_quizapp/view/StartScreen.dart';
import 'package:flutter_quizapp/widgets/CustomIconButton.dart';

class ReviewScreen extends StatefulWidget {
  static final String id = 'review_screen';

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 18.0);
  final Quiz quiz = Quiz();

  Map currentQuestion;

  _ReviewScreenState() {
    currentQuestion = quiz.getCurrentIncorrect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(quiz.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(35.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "${quiz.pos + 1}/${quiz.currentList.length}",
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.end,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 24.0,
                  ),
                  child: Container(
                    child: Text(
                      "${currentQuestion['stem']}",
                      style: style.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "Your answer: ${currentQuestion['incorrect']}",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "Correct answer: ${currentQuestion['correct']}",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomIconButton(
                  icon: Icons.arrow_back_ios,
                  onPressed: () => onNavigation(quiz.previous),
                ),
                CustomIconButton(
                  icon: Icons.exit_to_app,
                  contrast: true,
                  onPressed: onExit,
                ),
                CustomIconButton(
                  icon: Icons.arrow_forward_ios,
                  onPressed: () => onNavigation(quiz.next),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void onNavigation(Function action) {
    setState(() {
      action();
      currentQuestion = quiz.getCurrentIncorrect();
    });
  }

  void onExit() {
    quiz.resetQuiz();
    Navigator.pushNamedAndRemoveUntil(
      context,
      StartScreen.id,
      ModalRoute.withName(StartScreen.id),
    );
  }
}
