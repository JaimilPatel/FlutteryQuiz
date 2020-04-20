import 'package:flutter/material.dart';
import 'package:flutteryquiz/QuizPage.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "productsans",
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
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
                  height: 90.0,
                ),
                Center(
                  child: Image(
                    image: AssetImage('assets/quiz_icon.png'),
                    height: 300,
                    width: 300,
                  ),
                ),
                Text(
                  "Quiz",
                  style: TextStyle(color: Color(0xFFA20CBE), fontSize: 90.0),
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
                      "Play",
                      style: TextStyle(fontSize: 32.0),
                    ),
                    textColor: Color(0xFF2D046E),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
