import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpences extends StatefulWidget {
  const NewExpences({
    super.key,
    required this.onAddExpence,
  });

  final void Function(Expense expense) onAddExpence;

  @override
  State<NewExpences> createState() => _NewExpencesState();
}

class _NewExpencesState extends State<NewExpences> {
  //
  final _textInputController = TextEditingController();
  final _amountInputController = TextEditingController();
  DateTime? _selectedDate;
  Catagory _selectedCatagory = Catagory.leisure;

  void _datepicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year + 1, now.month, now.day);
    final selected = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate);
    setState(() {
      _selectedDate = selected;
    });
  }

  void _submitExpences() {
    final amount = double.tryParse(_amountInputController.text);
    final invalideAmount = amount == null || amount <= 0;

    if (_textInputController.text.trim().isEmpty ||
        invalideAmount ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Inviled Inpute"),
          content: const Text(
              "Please make sure a valid Title, Amount, Date and Category was enterd.."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("Okay"),
            ),
          ],
        ),
      );
      return;
    }
    widget.onAddExpence(
      Expense(
          title: _textInputController.text.trim(),
          amount: amount,
          date: _selectedDate!,
          catagory: _selectedCatagory),
    );
    Navigator.pop(context);
  }

  //! Dispose everything in Modal
  @override
  void dispose() {
    _textInputController.dispose();
    _amountInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          //**  Title Fild
          TextField(
            controller: _textInputController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text("Title"),
            ),
          ),

          Row(
            children: [
              //** Amount Fild
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _amountInputController,
                  decoration: const InputDecoration(
                    prefixText: "\$ ",
                    label: Text("Amount"),
                  ),
                ),
              ),
              //** Date Piker
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? "No date selectad"
                          : formater.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: () {
                        _datepicker();
                      },
                      icon: const Icon(Icons.calendar_month),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              //** Dropdown Manue
              DropdownButton(
                value: _selectedCatagory,
                items: [
                  ...Catagory.values.map(
                    (catagory) => DropdownMenuItem(
                      value: catagory,
                      child: Text(catagory.name.toUpperCase()),
                    ),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    if (value == null) {
                      return;
                    }
                    _selectedCatagory = value;
                  });
                },
              ),
              const Spacer(),
              //** Cancle Expences BUtton
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancle"),
              ),
              //** Save Expences BUtton
              ElevatedButton(
                onPressed: _submitExpences,
                child: const Text("Save Expences"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
