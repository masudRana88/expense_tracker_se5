import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class EspencesItem extends StatelessWidget {
  const EspencesItem(this.expanses, {super.key});

  final Expense expanses;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expanses.title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("\$${expanses.amount.toStringAsFixed(2)}"),
                const Spacer(),
                Row(
                  children: [
                    Icon(catagortIcon[expanses.catagory]),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(expanses.formatedDate),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
