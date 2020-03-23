/**
 * Name: FillBlankQuestion
 * Authors: Miguel A. Zamudio & Cristian Ayub
 * Description: Contains all methods that allow the creation and management of
 * a fill-in-the-blank question
 * Last update: Mar 19, 2020
 */
class FillBlankQuestion {
  var type;
  var stem;
  var answer;
  var figure;

  /// Contructor
  ///
  /// Receives @question and populates @stem & @answer
  FillBlankQuestion(question) {
    this.type = question["type"];
    this.stem = question["stem"];
    this.figure = question["figure"];
    this.answer = question["answer"];
  }

  /// Checks if the response given by the user is correct
  /// going though all possible answers
  ///
  /// Receives a String @response and compares such String with @answer
  bool checkAnswer(String response) {
    for (var i = 0; i < this.answer.length; i++) {
      if (response == this.answer[i]) {
        return true;
      }
    }
    return false;
  }
}
