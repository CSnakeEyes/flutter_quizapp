import 'package:flutter/material.dart';
import 'package:flutter_quizapp/controller/Quiz.dart';
import 'package:flutter_quizapp/view/GradeScreen.dart';
import 'package:flutter_quizapp/widgets/CustomIconButton.dart';
import 'package:flutter_quizapp/widgets/CustomTextField.dart';

class QuizScreen extends StatefulWidget {
  static final String id = "quiz_screen";

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 18.0);
  final Quiz quiz = Quiz();
  final TextEditingController inputController = TextEditingController();

  Map currentQuestion;
  int selectedBox;
  String answer;

  _QuizScreenState() {
    currentQuestion = quiz.getCurrentQuestion();
    inputController.addListener(() {
      setState(() {
        answer = inputController.text;
      });
    });
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
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
                _handleQuestionType(),
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
                  icon: Icons.file_upload,
                  contrast: true,
                  onPressed: onSubmit,
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

  Widget _handleQuestionType() {
    if (currentQuestion["type"] == 1) {
      return Column(
        children: _buildCheckboxes(currentQuestion["options"]),
      );
    }
    return CustomTextField(
      hintText: "Input your answer",
      obscure: false,
      inputController: inputController,
    );
  }

  List<Widget> _buildCheckboxes(List<dynamic> options) {
    return options.asMap().entries.map((entry) {
      return CheckboxListTile(
        title: Text(entry.value),
        value: selectedBox == entry.key,
        onChanged: (newValue) => setState(() => selectedBox = entry.key),
        controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
      );
    }).toList();
  }

  void saveAnswer() {
    if (selectedBox != null) {
      quiz.updateAnswer(selectedBox);
    } else if (answer != null) {
      quiz.updateAnswer(answer);
    }
    inputController.clear();
  }

  void onNavigation(Function action) {
    saveAnswer();

    setState(() {
      selectedBox = null;
      answer = null;

      action();
      currentQuestion = quiz.getCurrentQuestion();

      checkForExistingAnswer();
    });
  }

  void checkForExistingAnswer() {
    if (currentQuestion["type"] == 1) {
      selectedBox ??= currentQuestion["answer"];
    } else {
      answer ??= currentQuestion["answer"];
      inputController.text = answer ?? "";
    }
  }

  void onSubmit() {
    saveAnswer();

    if (quiz.getProgress() == 1) {
      Navigator.pushNamed(context, GradeScreen.id);
    } else {
      print("Incomplete bitch");
    }
  }
}
