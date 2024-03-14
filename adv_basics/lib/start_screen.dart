import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});
  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/images/quiz-logo.png",
            height: 300,
            color: const Color.fromARGB(153, 255, 255, 255),
          ),
          const SizedBox(
            height: 70,
          ),
          Text(
            "A Quiz and Easy Way to Learn Flutter",
            style: GoogleFonts.lato(
              fontSize: 20,
              color: const Color.fromARGB(255, 229, 217, 246),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          OutlinedButton.icon(
            onPressed: startQuiz,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.arrow_right_alt),
            label: const Text(
              "Start Quiz",
            ),
          ),
        ],
      ),
    );
  }
}
