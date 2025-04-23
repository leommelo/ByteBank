import 'package:bytebank_full/components/centered_message.dart';
import 'package:bytebank_full/models/transaction.dart';
import 'package:bytebank_full/webAPI/webclient.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatefulWidget {
  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  final List<Transaction> transactions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transactions')),
      body: FutureBuilder<List<Transaction>>(
        future: findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              final List<Transaction>? transactions = snapshot.data;
              if (transactions != null && transactions.isNotEmpty) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final Transaction transaction = transactions![index];
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.monetization_on),
                        title: Text(
                          transaction.value.toString(),
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          transaction.contact.accountNumber.toString(),
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    );
                  },
                  itemCount: transactions?.length,
                );
              }else {
                return CenteredMessage(
                  "No transactions found",
                  icon: Icons.warning,
                );
              }

            default:
          }
          return CenteredMessage("unknow error");
        },
      ),
    );
  }
}
