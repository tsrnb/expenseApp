import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function addTx;

  NewTransactions(this.addTx);

  @override
  State<NewTransactions> createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  // var _date = DateTime.now();

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount < 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                alignment: Alignment.center,
                child: Text(
                  "New Transaction Form",
                  style: Theme.of(context).textTheme.headline6,
                )),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Enter Title",
                border: OutlineInputBorder(),
                // errorText: "Please enter the Title",
              ),
              // onChanged: (val) {
              //   titleInput = val;
              // },
              controller: _titleController,
              onTap: () => submitData,
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Amount Spent",
                border: OutlineInputBorder(),

                // errorText: "Please enter the amount spent",
              ),
              keyboardType: TextInputType.number,
              // onChanged: (val) => amountInput = val,
              controller: _amountController,
              onTap: () => submitData,
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Text(_selectedDate == null
                      ? "No date Choosen!"
                      : "Picked date: ${DateFormat.yMMMd().format(_selectedDate)}"),
                ),
                TextButton(
                  onPressed: _presentDatePicker,
                  child: Text("Date Picker"),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => submitData(),
                child: Text("Add transaction"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
