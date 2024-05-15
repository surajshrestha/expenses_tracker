import 'package:expenses_tracker/chart.dart';
import 'package:expenses_tracker/new_transaction.dart';
import 'package:expenses_tracker/transaction.dart';
import 'package:expenses_tracker/transaction_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.amber, // Your accent color
        ),
        fontFamily: 'Spectral',
      ),
      home: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Transaction> transactions = [
    // Transaction(id: "1", name: "Shoes", price: 20.50, dateTime: DateTime.now()),
    //  Transaction(
    //    id: "2", name: "Groceries", price: 50.50, dateTime: DateTime.now()),
  ];

  List<Transaction> get recentTransaction {
    return transactions.where((tx) {
      return tx.dateTime!.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void addTransaction(String item, double amount, DateTime choosenDate) {
    var newTx = Transaction(
        id: DateTime.now().toString(),
        name: item,
        price: amount,
        dateTime: choosenDate);

    setState(() {
      transactions.add(newTx);
    });
  }

  void deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return NewTransaction(addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Expenses"),
        actions: [
          IconButton(
              onPressed: () {
                startAddNewTransaction(context);
              },
              icon: Icon(Icons.add)),
        ],
      ),
      body: transactions.isEmpty
          ? Column(
              children: [
                Text("No Transactions Added Yet"),
                Image.asset(
                  'assets/images/no_expenses.png',
                  fit: BoxFit.cover,
                )
              ],
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Chart(recentTransaction),
                  TransactionList(transactions,deleteTransaction),
                ],
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          startAddNewTransaction(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
