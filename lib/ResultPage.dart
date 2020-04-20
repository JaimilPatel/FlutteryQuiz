import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutteryquiz/QuizPage.dart';

class ResultPage extends StatefulWidget {
  final int score;

  ResultPage({Key key, @required this.score}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState(score: score);
}

class _ResultPageState extends State<ResultPage> {
  final int score;

  _ResultPageState({Key key, @required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D046E),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ),
                Center(
                  child: Image(
                    image: AssetImage('assets/quiz_icon.png'),
                    height: 300,
                    width: 300,
                  ),
                ),
                Text(
                  "Result",
                  style: TextStyle(color: Colors.white, fontSize: 35.0),
                ),
                Text(
                  "Score $score/10",
                  style: TextStyle(color: Color(0xFFFFBA00), fontSize: 60.0),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => QuizPage()));
                    },
                    color: Colors.white,
                    child: Text(
                      "Restart",
                      style: TextStyle(fontSize: 32.0),
                    ),
                    textColor: Color(0xFF2D046E),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    color: Colors.white,
                    child: Text(
                      "Exit",
                      style: TextStyle(fontSize: 32.0),
                    ),
                    textColor: Color(0xFF2D046E),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
