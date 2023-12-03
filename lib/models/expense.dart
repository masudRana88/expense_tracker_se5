import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final formater = DateFormat.yMd();

enum Catagory { food, travel, leisure, work }

const catagortIcon = {
  Catagory.food: Icons.lunch_dining,
  Catagory.travel: Icons.flight_takeoff,
  Catagory.leisure: Icons.movie,
  Catagory.work: Icons.work,
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.catagory})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Catagory catagory;

  String get formatedDate {
    return formater.format(date).substring(5);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.catagory, required this.expences});

  final Catagory catagory;
  final List<Expense> expences;

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.catagory)
      : expences = allExpenses
            .where((element) => element.catagory == catagory)
            .toList();

  double get totalExpenses {
    double sum = 0;
    for (final expense in expences) {
      sum = sum + expense.amount;
    }
    return sum;
  }
}
