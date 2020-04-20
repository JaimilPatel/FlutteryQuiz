import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutteryquiz/QuestionHelper.dart';
import 'package:flutteryquiz/ResultPage.dart';
import 'package:http/http.dart' as http;

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  String apiUrl =
      "https://opentdb.com/api.php?amount=10&category=18&type=multiple";
  QuestionHelper questionHelper;
  int currentQuestion = 0;
  int totalSeconds = 10;
  int elapseSeconds = 0;
  Timer timer;
  int score = 0;

  @override
  void initState() {
    fetchAllQuizQuestions();
    super.initState();
  }

  fetchAllQuizQuestions() async {
    var response = await http.get(apiUrl);
    var body = response.body;
    var json = jsonDecode(body);
    setState(() {
      questionHelper = QuestionHelper.fromJson(json);
      questionHelper.results[currentQuestion].incorrectAnswers
          .add(questionHelper.results[currentQuestion].correctAnswer);
      questionHelper.results[currentQuestion].incorrectAnswers.shuffle();
      showTimer();
    });
  }

  showTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (t.tick == totalSeconds) {
        t.cancel();
        changeQuestion();
      } else {
        setState(() {
          elapseSeconds = t.tick;
        });
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  checkAnswer(answer) {
    String currentAnswer =
        questionHelper.results[currentQuestion].correctAnswer;
    if (currentAnswer == answer) {
      score += 1;
    } else {}
    changeQuestion();
  }

  changeQuestion() {
    timer.cancel();
    if (currentQuestion == questionHelper.results.length - 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ResultPage(
                    score: score,
                  )));
    } else {
      setState(() {
        currentQuestion += 1;
      });
      questionHelper.results[currentQuestion].incorrectAnswers
          .add(questionHelper.results[currentQuestion].correctAnswer);
      questionHelper.results[currentQuestion].incorrectAnswers.shuffle();
      showTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (questionHelper != null) {
      return Scaffold(
        backgroundColor: Color(0xFF2D046E),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/quiz_icon.png'),
                        width: 70,
                        height: 70,
                      ),
                      Text(
                        '$elapseSeconds s',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Q. ${questionHelper.results[currentQuestion].question}",
                    style: TextStyle(fontSize: 35, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Column(
                      children: questionHelper
                          .results[currentQuestion].incorrectAnswers
                          .map((option) {
                    return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        colorBrightness: Brightness.dark,
                        color: Color(0xFF511AA8),
                        child: Text(
                          option,
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: () {
                          checkAnswer(option);
                        },
                      ),
                    );
                  }).toList()),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Color(0xFF2D046E),
        body: Center(child: CircularProgressIndicator()),
      );
    }
  }
}
