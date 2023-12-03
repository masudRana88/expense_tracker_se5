import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expences.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Expense> _registeredExpenes = [
    Expense(
        title: "Flutter course",
        amount: 19.99,
        date: DateTime.now(),
        catagory: Catagory.work),
    Expense(
        title: "Cinema",
        amount: 15.69,
        date: DateTime.now(),
        catagory: Catagory.leisure),
  ];

  void _addNewExpences(Expense expense) {
    setState(() {
      _registeredExpenes.add(expense);
    });
  }

  void _removeExpence(Expense expense) {
    final expanseIndex = _registeredExpenes.indexOf(expense);
    setState(() {
      _registeredExpenes.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Expense Deleted"),
        duration: const Duration(seconds: 10),
        action: SnackBarAction(
          label: "undo",
          onPressed: () {
            setState(() {
              _registeredExpenes.insert(expanseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  void _openAddExpensesModal() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewExpences(
            onAddExpence: _addNewExpences,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("No Expenses Found, Start Adding Some!"),
    );

    if (_registeredExpenes.isNotEmpty) {
      mainContent = Expenseslist(
          expansesList: _registeredExpenes, onRemoveExpence: _removeExpence);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expenses Traker"),
        actions: [
          IconButton(
            onPressed: _openAddExpensesModal,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(children: [
        Chart(expenses: _registeredExpenes),
        Expanded(child: mainContent)
      ]),
    );
  }
}
