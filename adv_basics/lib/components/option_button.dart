import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  OptionButton({super.key, required this.optionText, required this.onClick});
  final String optionText;
  final void Function() onClick;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 64, 2, 111),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      ),
      onPressed: onClick,
      child: Text(
        optionText,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
