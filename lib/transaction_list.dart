import 'package:expenses_tracker/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(String id) deleteTransaction;
  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child:ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Row(children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 3,
                      child: Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 2.0)),
                          padding: EdgeInsets.all(10),
                          child: Text(
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Theme.of(context).primaryColor,
                              ),
                              '\$ ${transactions[index].price.toString()}')),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transactions[index].name.toString(),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            DateFormat('yMMMd')
                                .format(transactions[index].dateTime as DateTime),
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: IconButton(onPressed: (){
                        deleteTransaction(transactions[index].id.toString());
                      }, icon: Icon(Icons.delete))),
                  ]),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
