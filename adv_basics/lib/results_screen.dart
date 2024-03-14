import 'package:flutter/material.dart';
import 'package:adv_basics/data/questions.dart';
import 'package:adv_basics/question_summary.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen(this.choosenAnswerList, this.onRestart, {super.key});
  final List<String> choosenAnswerList;
  final void Function() onRestart;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];
    for (int i = 0; i < choosenAnswerList.length; i++) {
      summary.add({
        "question_index": i,
        "question": questions[i].question,
        "correct_answer": questions[i].options[0],
        "user_answer": choosenAnswerList[i],
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    var summaryData = getSummaryData();
    final numOfTotalQuestions = questions.length;
    final correctQuestions = summaryData.where(
      (data) {
        return data['user_answer'] == data['correct_answer'];
      },
    );
    final correctQuestionsIndex = correctQuestions.map((data) {
      return data['question_index'];
    });
    final numOfCorrectQuestions = correctQuestions.length;

    return Center(
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Summary Title text
            Text(
              "You answered $numOfCorrectQuestions out $numOfTotalQuestions answers Correctily",
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionSummary(summaryData, correctQuestionsIndex.toList()),
            const SizedBox(
              height: 30,
            ),
            TextButton.icon(
              onPressed: onRestart,
              icon: const Icon(
                Icons.restart_alt,
                color: Colors.white,
              ),
              label: Text(
                "Restart Quiz",
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
