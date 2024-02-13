import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';

// global variable
var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);
var kdarkColorScheme = ColorScheme.fromSeed(
  // instructs flutter to generate shades for dark mode
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 25),
);
void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kdarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kdarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kdarkColorScheme.primaryContainer,
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                color: kColorScheme.onSecondaryContainer,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
      ),
      debugShowCheckedModeBanner: false,
      home: const Expenses(),
    ),
  );
}
