import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/widgets/Expense_List/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final void Function(Expense expense) onRemoveExpense;
  final List<Expense> expenses;

  @override
  Widget build(context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
            background: Container(color: Theme.of(context).colorScheme.error.withOpacity(0.8),
            margin: EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal),),
            key: ValueKey(expenses[index]),
            onDismissed: (direction) => onRemoveExpense(expenses[index]),
            child: ExpenseItem(expense: expenses[index])));
  }
}
