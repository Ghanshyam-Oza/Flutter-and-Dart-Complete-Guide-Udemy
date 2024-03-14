import 'package:adv_basics/components/option_button.dart';
import 'package:adv_basics/models/quiz_questions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen(this.questions, this.onSelectAnswer, {super.key});
  final List<QuizQuestion> questions;
  final void Function(String answer) onSelectAnswer;
  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuestionIndex = 0;

  void changeQuestion(String selectedAnswer) {
    widget.onSelectAnswer(selectedAnswer);
    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //question
            Text(
              widget.questions[currentQuestionIndex].question,
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 234, 222, 251),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            //dynamically generate options list using map and spread operator
            ...widget.questions[currentQuestionIndex]
                .getShuffledList()
                .map((item) {
              return OptionButton(
                optionText: item,
                onClick: () {
                  changeQuestion(item);
                },
              );
            })
          ],
        ),
      ),
    );
  }
}
