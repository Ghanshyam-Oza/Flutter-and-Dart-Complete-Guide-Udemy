import 'dart:math';

import 'package:flutter/material.dart';

final randomizer = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> {
  var selectedDice = 1;

  void changeDice() {
    setState(() {
      selectedDice = randomizer.nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/dice-$selectedDice.png',
          width: 300,
        ),
        ElevatedButton(
          onPressed: changeDice,
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              Color.fromARGB(255, 255, 60, 0),
            ),
          ),
          child: const Text(
            "Roll Dice",
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
