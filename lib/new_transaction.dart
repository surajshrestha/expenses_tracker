import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  Function(String name, double price, DateTime choosenDate) addTransaction;

  NewTransaction(this.addTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final itemInput = TextEditingController();
  final priceInput = TextEditingController();
  DateTime? selectedDate;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Item"),
              controller: itemInput,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Price"),
              controller: priceInput,
              keyboardType: TextInputType.number,
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Text(
                    selectedDate == null
                        ? "No Date Choosen!"
                        : DateFormat('yMd').format(selectedDate!),
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: ElevatedButton(
                          onPressed: _presentDatePicker,
                          child: Text("Date Picker"))),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                var item = itemInput.text;
                var price = priceInput.text;
                print('Item {$item} && Price {$price}');

                widget.addTransaction!(
                    itemInput.text, double.parse(priceInput.text), selectedDate!);
                Navigator.of(context).pop();
              },
              child: Text("Add Transaction"),
              style: ElevatedButton.styleFrom(foregroundColor: Colors.purple),
            )
          ],
        ),
      ),
    );
  }
}
