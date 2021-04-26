import 'package:bytebank/models/saldo.dart';
import 'package:bytebank/screens/transactions_list.dart';
import 'package:flutter/material.dart';

import 'contacts_list.dart';
import 'dashboard/feature_itens.dart';
import 'dashboard/saldo.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              color: Colors.blue,
              height: 300,
              width: 400,
              child: Image.asset(
                'images/bytebank_logo.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          SaldoCard(Saldo(35.0)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FeatureItem(
                  'Contacts',
                  Icons.contacts,
                  onClick: () => _showContactList(context),
                ),
                FeatureItem(
                  'Transfer',
                  Icons.monetization_on,
                  onClick: () => null,
                ),
                FeatureItem(
                  'Transaction Feed',
                  Icons.description,
                  onClick: () => _showTransactionFeed(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _showContactList(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => ContactsList(),
    ),
  );
}

void _showTransactionFeed(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => TransactionsList(),
    ),
  );
}
