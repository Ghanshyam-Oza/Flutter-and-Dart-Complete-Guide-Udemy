import 'package:adv_basics/questions_screen.dart';
import 'package:flutter/material.dart';
import 'package:adv_basics/start_screen.dart';
import 'package:adv_basics/data/questions.dart';
import 'package:adv_basics/results_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<String> answersList = [];
  var activeScreen = 'start-screen';

  void onRestartQuiz() {
    setState(() {
      answersList = [];
      activeScreen = 'questions-screen';
    });
  }

  void switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  void choosenAnswer(String answer) {
    answersList.add(answer);

    if (answersList.length == questions.length) {
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget currentWidget = StartScreen(switchScreen);

    if (activeScreen == 'questions-screen') {
      currentWidget = QuestionsScreen(questions, choosenAnswer);
    }
    if (activeScreen == 'results-screen') {
      currentWidget = ResultsScreen(answersList, onRestartQuiz);
    }

    return MaterialApp(
      title: 'Flutter Quiz App',
      home: Scaffold(
        backgroundColor: Colors.deepPurple,
        body: currentWidget,
      ),
    );
  }
}
