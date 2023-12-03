import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expences_item.dart';
import 'package:flutter/material.dart';

class Expenseslist extends StatelessWidget {
  Expenseslist(
      {super.key, required this.expansesList, required this.onRemoveExpence});

  final List<Expense> expansesList;
  void Function(Expense expense) onRemoveExpence;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expansesList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(expansesList[index]),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(0.75),
              margin: const EdgeInsets.only(left: 2),
            ),
            onDismissed: (d) {
              onRemoveExpence(expansesList[index]);
            },
            child: EspencesItem(
              expansesList[index],
            ),
          );
        });
  }
}
