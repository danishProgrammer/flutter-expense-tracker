import 'package:expense_tracker/model/expense.model.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddNewExpense});

  final void Function(Expense expense) onAddNewExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category _selectedCategory = Category.leisure;
  DateTime? _selectedDate;

  void _presentDatePicker() async {
    final now = DateTime.now();

    final pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate == null ? now : _selectedDate!,
        firstDate: DateTime(now.year - 1),
        lastDate: now);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    _titleController
        .dispose(); // add this inside dispose to avoid controllers to consume more memory.
    _amountController.dispose();
    super.dispose();
  }

  void _changeCategory(value) {
    if (value == null) {
      return;
    }
    setState(() {
      _selectedCategory = value;
    });
  }

  void _saveExpense() {
    final enteredAmount = double.tryParse(_amountController.text);
    final invalidAmount = enteredAmount == null || enteredAmount < 0;
    final enteredTitle = _titleController.text.trim();
    if (invalidAmount || _selectedDate == null || enteredTitle.isEmpty) {
      // invalid form.
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invalid Input'),
                content: const Text(
                    'Please enter a valid title, date, amount and category'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text('Okay'))
                ],
              ));
      return;
    }
    widget.onAddNewExpense(Expense(
        title: enteredTitle,
        date: _selectedDate!,
        amount: enteredAmount,
        category: _selectedCategory));
    _cancelNewExpense(); // close the modal after adding a new expense.
  }

  void _cancelNewExpense() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width > 600)
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          maxLength: 50,
                          controller: _titleController,
                          decoration:
                              const InputDecoration(label: Text('Title')),
                        ),
                      ),
                      const SizedBox(width: 24,),
                      Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _amountController,
                        decoration: const InputDecoration(
                            label: Text('Amount'), prefixText: '\$ '),
                      ),
                    ),
                    ],
                  )
                else
                  TextField(
                    maxLength: 50,
                    controller: _titleController,
                    decoration: const InputDecoration(label: Text('Title')),
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _amountController,
                        decoration: const InputDecoration(
                            label: Text('Amount'), prefixText: '\$ '),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(_selectedDate == null
                              ? 'No date selected'
                              : formatter.format(_selectedDate!)),
                          IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month))
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(category.name.toUpperCase())))
                            .toList(),
                        onChanged: _changeCategory),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: _saveExpense,
                        child: const Text('Save Expense')),
                    TextButton(
                        onPressed: _cancelNewExpense,
                        child: const Text('Cancel'))
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
