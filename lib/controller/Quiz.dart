/**
 * Name: Quiz
 * Authors: Miguel A. Zamudio & Cristian Ayub
 * Description: Contains the controller for the quiz
 * Last update: Mar 19, 2020
 */

import 'package:flutter_quizapp/controller/RequestQuiz.dart';
import 'package:flutter_quizapp/model/Question.dart';

class Quiz {
  String error; //Any error related with the server

  static final Quiz _instance = Quiz._internal();

  String username;
  String pin;

  String name; //Quiz name
  List<dynamic> questions; //Quiz questions
  List<dynamic> answers; //User answers to questions
  int pos = 0; //Actual position
  bool isReview = false; //User decide to review its incorrect answers
  List<dynamic> incorrectAnswers; //List of incorrect answers
  List<dynamic> currentList; //List of questions or list of incorrect answers

  ///Constructor for singleton Quiz controller.
  factory Quiz() {
    return _instance;
  }

  Quiz._internal();

  ///Calls the server with [user] and [pin] credentials to
  ///get the quiz number [quiz] and updates the quiz object in case
  ///call was successfully, otherwise updates [error].
  Future<bool> startQuiz(int quiz) async {
    ///Create map of parameters to send it to the server
    ///Needed parameters: user, pin, quiz
    Map data = {"user": username, "pin": pin, "quiz": quiz};

    ///Call to the server
    RequestQuiz requester = RequestQuiz();
    var receivedQuiz = await requester.getQuiz(data);

    ///Check if server returned an error with the sent data
    if (receivedQuiz == null) {
      ///Set error to the server error
      this.error = requester.error;
      return false;
    }

    ///Otherwise, initialize quiz
    this.name = receivedQuiz["name"];
    this.questions = List<dynamic>();
    receivedQuiz["question"].forEach((item) {
      var question = Question(item);
      questions.add(question);
    });
    this.answers = List<dynamic>(questions.length);
    this.currentList = this.questions;
    return true;
  }

  ///Method to get question in [pos] returning a map with
  ///['type'], ['stem'], ['figure'], ['options'].
  Map getCurrentQuestion() {
    var currentQuestion = this.currentList[pos];
    Map questionData = {
      'type': currentQuestion.question.type,
      'stem': currentQuestion.question.stem,
      'figure': currentQuestion.question.figure,
      'options': (currentQuestion.question.type == 1)
          ? currentQuestion.question.option
          : null,
      'answer': (this.answers[pos] != null) ? this.answers[pos] : null,
    };
    return questionData;
  }

  ///Get the progress of the quiz.
  double getProgress() {
    ///if the length of the current list is less or equal to 0 [error]
    if (this.currentList.length <= 0) return -1;

    /// else if is review calculate progress according to current [pos]
    if (isReview) return pos + 1 / this.currentList.length;

    /// else calculate progress according to answered questions on [answers]
    int answered = 0;
    this.answers.forEach((item) {
      if (item != null) {
        answered++;
      }
    });
    return answered / this.currentList.length;
  }

  ///It recieves an [answer] for the question in the position [pos].
  void updateAnswer(dynamic answer) {
    ///If [isReview] update an answer is not needed
    if (isReview) return;

    ///Update value
    this.answers[this.pos] = answer;
    return;
  }

  ///Go to the previous question.
  bool previous() {
    //If we are not in the first question, go to previous
    if (this.pos > 0) {
      this.pos = this.pos - 1;
      return true;
    }
    return false;
  }

  ///Go to next question.
  bool next() {
    //if que are not in the last question, go to next
    if (this.pos < this.currentList.length - 1) {
      this.pos = this.pos + 1;
      return true;
    }
    return false;
  }

  ///Evaluate list of [answers], create a list of [incorrectAnswers] and return a map with
  ///['correct'] answers, ['incorrect'] answers and quiz ['grade'].
  Map evaluate() {
    //Initialize
    int correct = 0;
    int incorrect = 0;
    this.incorrectAnswers = List<dynamic>();

    //Go through all questions and check answers
    for (int i = 0; i < this.questions.length; i++) {
      if (this.questions[i].checkAnswer(this.answers[i])) {
        correct++;
      } else {
        this.incorrectAnswers.add({
          'index': i,
          'answer': this.answers[i],
        });
        incorrect++;
      }
    }

    //Create evaluation map and return it
    Map evaluation = {
      'correct': correct,
      'incorrect': incorrect,
      'grade': (correct / this.questions.length) * 10,
    };
    return evaluation;
  }

  ///Update quiz to start a review the list of [incorrectAnswers].
  void startReview() {
    this.isReview = true;
    this.pos = 0;
    this.currentList = this.incorrectAnswers;
  }

  ///Method to return a map of the question with incorrect answer the map contains:
  ///['type'], ['stem'], ['figure'], ['options'], ['correct'], ['incorrect'].
  Map getCurrentIncorrect() {
    if (this.currentList.length > 0 && isReview) {
      var currentIncorrect = this.currentList[pos];
      var question = this.questions[currentIncorrect["index"]].question;
      return {
        'type': question.type,
        'stem': question.stem,
        'figure': question.figure,
        'options': (question.type == 1) ? question.option : null,
        'correct': (question.type == 1)
            ? question.option[currentIncorrect['answer']]
            : question.answer,
        'incorrect': (question.type == 1)
            ? question.option[currentIncorrect['answer']]
            : currentIncorrect['answer']
      };
    }
    return null;
  }

  void resetQuiz() {
    name = null;
    questions = null;
    answers = null;
    pos = 0;
    isReview = false;
    incorrectAnswers = null;
    currentList = null;
  }
}
