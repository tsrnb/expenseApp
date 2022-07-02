import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: [
              SizedBox(
                height: 200,
                width: 300,
                child: Image.asset(
                  'assets/images/nodata.png',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(),
              Text(
                "No transactions found!",
                style: Theme.of(context).textTheme.headline6,
              )
            ],
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text("\$${transactions[index].amount}")),
                      ),
                    ),
                    title: Text(
                      "${transactions[index].title}",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: GestureDetector(
                      onTap: () => deleteTx(transactions[index].id),
                      child: Icon(
                        Icons.delete_forever,
                        // size: 30,
                        color: Theme.of(context).errorColor,
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
