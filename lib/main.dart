import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'question_brain.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzy());

class Quizzy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quizzy App'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: QuizzyPage(),
          ),
        ),
      ),
    );
  }
}

class QuizzyPage extends StatefulWidget {
  @override
  _QuizzyPageState createState() => _QuizzyPageState();
}

class _QuizzyPageState extends State<QuizzyPage> {
  List<Expanded> scoreKeeper = [];
  int correctAnswerCounter = 0;

  void checkAnswer(bool userAnswer) {
    bool correctAnswer = quizBrain.getQuestionAnswer();

    if (correctAnswer == userAnswer) {
      setState(
        () {
          correctAnswerCounter++;

          scoreKeeper.add(
            Expanded(
              child: Icon(
                Icons.check,
                color: Colors.green,
              ),
            ),
          );
        },
      );
    } else {
      setState(
        () {
          scoreKeeper.add(
            Expanded(
              child: Icon(
                Icons.close,
                color: Colors.red,
              ),
            ),
          );
        },
      );
    }

    if (quizBrain.isFinished()) {
      Alert(
        context: context,
        type: (correctAnswerCounter >= 5) ? AlertType.success : AlertType.error,
        title: (correctAnswerCounter >= 5) ? 'Passed' : 'Failed',
        desc: "You got $correctAnswerCounter correct answer out of " +
            quizBrain.getNumberOfQuestion() +
            ' questions',
        buttons: [
          DialogButton(
            child: Text(
              "COOL",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();

      setState(
        () {
          quizBrain.reset();
          correctAnswerCounter = 0;
          scoreKeeper = [];
        },
      );
    } else {
      quizBrain.nextQuestion();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 6,
          child: Container(
            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Question',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28.0,
                  ),
                ),
                Text(
                  quizBrain.getQuestionText(),
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 30.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Card(
                  color: Colors.green,
                  child: ListTile(
                    onTap: () {
                      checkAnswer(true);
                    },
                    leading: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    title: Text(
                      'True',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  color: Colors.red,
                  child: ListTile(
                    onTap: () {
                      checkAnswer(false);
                    },
                    leading: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    title: Text(
                      'True',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: scoreKeeper,
          ),
        )
      ],
    );
  }
}
