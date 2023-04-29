import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'Quiz_Brain.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [];

  void checkAnswer(bool userPickedAnswer) {
    bool cans = quizBrain.getQuestionAnswer();

    setState(() {
    if (quizBrain.isFinished() == true) {

        Alert(
          context: context,
          type: AlertType.warning,
          title: "Finished!",
          desc: "You've reached the end of the quiz",
          buttons: [
            DialogButton(
              child: Text(
                "Restart",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              color: Color.fromRGBO(0, 179, 134, 1.0),
            ),
          ],
        ).show();
        quizBrain.reset();
        scoreKeeper = [];
      }
    else {
      if (userPickedAnswer == cans) {
        scoreKeeper.add(
          Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      } else {
        scoreKeeper.add(
          Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }
      quizBrain.getQuestion();
    }
  });
    }

    @override
    Widget build(BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  quizBrain.getQuestionText(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: GestureDetector(
                onTap: () {
                  checkAnswer(true);
                },
                child: Container(
                  color: Colors.green,
                  child: Center(
                    child: Text(
                      'True',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: GestureDetector(
                onTap: () {
                  checkAnswer(false);
                },
                child: Container(
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      'False',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: scoreKeeper,
          )
        ],
      );
    }
  }
