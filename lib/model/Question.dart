/**
 * Name: Question
 * Authors: Miguel A. Zamudio & Cristian Ayub
 * Description: Contains all methods that identify what kind of question we are
 * receiving from the server
 * Last update: Mar 19, 2020
 */

import './FillBlankQuestion.dart';
import './MultipleQuestion.dart';

class Question {
  var question;

  /// Identifies question type.
  ///
  /// Selects a way to retrieve such a question depending its type
  Question(Map question) {
    switch (question["type"]) {

      /// Type 1: Multiple question
      case (1):
        this.question = MultipleQuestion(question);
        break;

      /// Type 2: Fill the blank
      case (2):
        this.question = FillBlankQuestion(question);
        break;

      /// Otherwise: incorrect type of question
      default:
        this.question = null;
        break;
    }
  }

  /// Checks the response given by the user depending on the type of question
  bool checkAnswer(var response) {
    return question.checkAnswer(response);
  }
}
