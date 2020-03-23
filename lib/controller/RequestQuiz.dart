import 'dart:convert';
import 'dart:io';

class RequestQuiz {
  final String BASE_URI =
      "http://www.cs.utep.edu/cheon/cs4381/homework/quiz/post.php";
  final List<int> validQuizzes = [0, 1, 2, 3, 4, 5, 6, 7];
  String error;

  bool _isValidQuiz(quiz) {
    return validQuizzes.contains(quiz);
  }

  String quizToString(quiz) {
    if (quiz < 10) {
      return "quiz0${quiz}";
    }
    return "quiz${quiz}";
  }

  Future<Map<String, dynamic>> getQuiz(Map body) async {
    if (!_isValidQuiz(body["quiz"])) {
      this.error = "Invalid quiz";
      return null;
    }
    body["quiz"] = quizToString(body["quiz"]);

    HttpClient httpClient = HttpClient();

    HttpClientRequest req = await httpClient.postUrl(Uri.parse(BASE_URI));
    req.headers.set('content-type', 'application/json');
    req.add(utf8.encode(json.encode(body)));

    HttpClientResponse res = await req.close();
    if (res.statusCode == 200) {
      String reply = await res.transform(utf8.decoder).join();
      httpClient.close();

      var response = reply.substring(reply.indexOf('"response"') - 1);
      Map<String, dynamic> resMap = jsonDecode(response);
      if (resMap["response"]) {
        return resMap["quiz"];
      } else {
        this.error = resMap["reason"];
        return null;
      }
    } else {
      this.error = "Server returned an 404 status code";
      return null;
    }
  }
}
