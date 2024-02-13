import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expense_list/expense_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expenses> {
  List<Expense> registeredExpenses = [
    Expense(
        title: "Flutter Course",
        category: Category.work,
        date: DateTime.now(),
        amount: 9.99),
    Expense(
        title: "Ice Cream",
        category: Category.food,
        date: DateTime.now(),
        amount: 19.99)
  ];

  _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(_addNewExpense),
    );
  }

  void _addNewExpense(Expense expense) {
    setState(() {
      registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    var expenseIndex = registeredExpenses.indexOf(expense);
    setState(() {
      registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Message Deleted."),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Widget mainContent =
        const Center(child: Text("No Expense Found. Add some to Show.."));
    if (registeredExpenses.isNotEmpty) {
      mainContent = ExpenseList(
          expenses: registeredExpenses, onRemoveExpense: _removeExpense);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(
              icon: const Icon(Icons.add), onPressed: _openAddExpenseOverlay),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: registeredExpenses),
                Expanded(child: mainContent),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: registeredExpenses)),
                Expanded(child: mainContent),
              ],
            ),
    );
  }
}
