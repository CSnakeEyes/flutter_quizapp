/**
 * Name: MultipleQuestion
 * Authors: Miguel A. Zamudio & Cristian Ayub
 * Description: Contains all methods that allow the creation and management of
 * a multiple choice question
 * Last update: Mar 19, 2020
 */

class MultipleQuestion {
  var type;
  var stem;
  var figure;
  var answer;
  var option;

  /// Contructor
  ///
  /// Receives a Map @question of type <String, dynamic>
  /// and populates @stem, @answer, and @option
  MultipleQuestion(Map question) {
    this.type = question["type"];
    this.stem = question["stem"];
    this.figure = question["figure"];
    this.answer = question["answer"];
    this.option = question["option"];
  }

  /// Checks if the response given by the user is correct
  bool checkAnswer(int response) {
    return response == this.answer;
  }
}
