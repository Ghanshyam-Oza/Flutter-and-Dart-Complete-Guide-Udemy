import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionSummary extends StatelessWidget {
  const QuestionSummary(this.summaryData, this.correctQuestionIndex,
      {super.key});
  final List<Map<String, Object>> summaryData;
  final List correctQuestionIndex;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map((data) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor:
                      correctQuestionIndex.contains(data['question_index'])
                          ? const Color.fromARGB(255, 31, 255, 247)
                          : const Color.fromARGB(255, 255, 129, 249),
                  minRadius: 15,
                  maxRadius: 20,
                  child: Text(
                    ((data['question_index'] as int) + 1).toString(),
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['question'].toString(),
                        style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        data['user_answer'].toString(),
                        style: GoogleFonts.lato(
                          color: const Color.fromARGB(172, 255, 255, 255),
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        data['correct_answer'].toString(),
                        style: GoogleFonts.lato(
                          color: const Color.fromARGB(217, 0, 234, 255),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
