import 'package:flutter/material.dart';
import 'package:basics/gradient_container.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GradientContainer([
        Color.fromARGB(255, 255, 188, 87),
        Color.fromARGB(255, 255, 140, 0)
      ]),
    );
  }
}
