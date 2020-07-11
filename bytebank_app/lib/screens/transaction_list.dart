import 'package:bytebank_app/components/centured_message.dart';
import 'package:bytebank_app/components/progress.dart';
import 'package:bytebank_app/http/webclients/transaction_webclient.dart';
import 'package:bytebank_app/models/transfer.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final TransactionWebClient webClient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Transaction Feed'),
        ),
        body: FutureBuilder<List<Transfer>>(
          initialData: List(),
          future: webClient.findAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Progress();

              case ConnectionState.done:
                if (snapshot.hasData) {
                  final List<Transfer> transfers = snapshot.data;

                  if (transfers.isNotEmpty) {
                    return ListView.builder(
                        itemCount: transfers.length,
                        itemBuilder: (context, index) {
                          final transfer = transfers[index];
                          return _transactionItem(transfer);
                        }
                    );
                  }
                }

                return CenturedMessage('No Transactions', icon: Icons.warning,);
                break;
            }

            return Text('Erro Generico');
          },
        )
    );
  }
}

class _transactionItem extends StatelessWidget {
  final Transfer _transfer;

  _transactionItem(this._transfer);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          _transfer.contact.fullName,
          style: TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(
          _transfer.value.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}