import 'package:bytebank/componentes/centered_message.dart';
import 'package:bytebank/componentes/components.dart';
import 'package:bytebank/https/webclients/transaction_webclient.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/screens/transaction_form.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatefulWidget {
  @override
  _TransactionsListState createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  final TransactionWebClient _webClient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) =>
                      TransactionForm(Contact(0, 'joao de contatos', '1234')),
                ),
              )
              .then((value) => setState(() {}));
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: _webClient.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return ProgressBar();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<Transaction> transactions = snapshot.data;
                if (transactions.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Transaction transaction = transactions[index];
                      return _BuildCard(
                        context,
                        transaction,
                        onClick: () {
                          Navigator.of(context)
                              .push(
                                MaterialPageRoute(
                                  builder: (context) => TransactionForm(Contact(
                                    0,
                                    transaction.contact.name,
                                    transaction.contact.accountNumber,
                                  )),
                                ),
                              )
                              .then((value) => setState(() {}));
                        },
                      );
                    },
                    itemCount: transactions.length,
                  );
                }
              }
              debugPrint(snapshot.data.toString());
              return CenteredMessage(
                'No transactions found',
                icon: Icons.warning,
              );
              break;
          }

          return CenteredMessage('Unknown error');
        },
      ),
    );
  }
}

class _BuildCard extends StatefulWidget {
  final BuildContext context;
  final Transaction transaction;
  final Function onClick;

  _BuildCard(this.context, this.transaction, {@required this.onClick});

  @override
  _BuildCardState createState() => _BuildCardState();
}

class _BuildCardState extends State<_BuildCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => widget.onClick(),
        leading: Icon(Icons.monetization_on),
        title: Text(
          widget.transaction.contact.name.toString(),
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'conta:' +
              widget.transaction.contact.accountNumber.toString() +
              '/ valor:' +
              widget.transaction.value.toString(),
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
