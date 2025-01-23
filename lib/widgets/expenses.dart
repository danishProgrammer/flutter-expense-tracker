import 'package:expense_tracker/widgets/Expense_List/expense_list.dart';
import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpenseState();
  }
}

class _ExpenseState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter course',
        date: DateTime.now(),
        amount: 22.3,
        category: Category.work),
    Expense(
        title: 'Cricket bat',
        date: DateTime.now(),
        amount: 43.3,
        category: Category.leisure),
    Expense(
        title: 'Trip to Mussouri',
        date: DateTime.now(),
        amount: 456,
        category: Category.travel),
  ];

  void _openExpenseForm() {
    showModalBottomSheet(
        isScrollControlled: true,
        useSafeArea: true,
        context: context,
        builder: (ctx) => NewExpense(
              onAddNewExpense: _addNewExpense,
            ));
  }

  void _addNewExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar( 
        SnackBar(
          content: (const Text('Expense deleted')),
          duration: const Duration(seconds: 3),
          action: SnackBarAction(label: 'Undo', onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          }),)
          
        );
  }

  @override
  Widget build(context) {
    final width = MediaQuery.of(context).size.width;

    Widget widget = const Center(child: Text('No expenses inserted'));

    if (_registeredExpenses.isNotEmpty) {
      widget = ExpenseList(
          expenses: _registeredExpenses, onRemoveExpense: _removeExpense);
    }

    return Scaffold(
      appBar: AppBar(
          title: const Text('Flutter Expense app'),
          // backgroundColor: Colors.blue,
          // foregroundColor: Colors.white,
          actions: [
            IconButton(onPressed: _openExpenseForm, icon: const Icon(Icons.add))
          ]),
      body: width < 600 ? Column(
        children: [Chart(expenses: _registeredExpenses), Expanded(child: widget)],
      ) : Row(children: [
        Expanded(child: Chart(expenses: _registeredExpenses)), Expanded(child: widget)
      ],),
    );
  }
}
