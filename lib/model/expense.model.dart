import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

const uuid = Uuid();

enum Category { food, travel, leisure, work }

final formatter = DateFormat.yMd();

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work
};

class Expense {
  Expense(
      {required this.title,
      required this.date,
      required this.amount,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final DateTime date;
  final double amount;
  final Category category;

  String get getFormattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.expenses, required this.category});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (var expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
