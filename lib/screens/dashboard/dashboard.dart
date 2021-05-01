import 'package:bytebank/componentes/container.dart';
import 'package:bytebank/models/name.dart';
import 'package:bytebank/screens/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:bytebank/componentes/localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../contacts_list.dart';
import '../deposit_form.dart';
import 'feature_itens.dart';
import 'saldo_card.dart';

class DashboardContainer extends BlocContainer {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NameCubit("Joao"),
      child: Dashboard(),
    );
  }
}

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = DashboardViewI18N(context);
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
          SaldoCard(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FeatureItem(
                  i18n.contacts,
                  Icons.contacts,
                  onClick: () => _showContactsList(context),
                ),
                FeatureItem(
                  i18n.deposit,
                  Icons.monetization_on,
                  onClick: () => _showDepositForm(context),
                ),
                FeatureItem(
                  i18n.transactionFeed,
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

class DashboardViewI18N extends ViewI18N {
  DashboardViewI18N(BuildContext context) : super(context);

  String get contacts => localize({"pt-br": "Contatos", "en": "Contacts"});

  String get transactionFeed =>
      localize({"pt-br": "Depositar", "en": "Depposit"});

  String get deposit =>
      localize({"pt-br": "Lista de Transações", "en": 'Transaction Feed'});
}

void _showContactsList(BuildContext blocContext) {
  push(blocContext, ContactsListContainer());
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
