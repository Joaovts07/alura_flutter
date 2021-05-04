import 'package:bytebank/screens/dashboard/saldo_card.dart';
import 'package:bytebank/screens/transactions_list.dart';
import 'package:flutter/material.dart';

import '../contacts_list.dart';
import '../deposit_form.dart';
import 'feature_itens.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Column(
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
                      SaldoCard(),
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
                              'Deposit',
                              Icons.monetization_on,
                              onClick: () => _showDepositForm(context),
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
                ),
              )),
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

void _showDepositForm(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => DepositForm(),
    ),
  );
}
