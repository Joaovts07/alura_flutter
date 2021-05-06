import 'dart:async';

import 'package:bytebank/componentes/components.dart';
import 'package:bytebank/componentes/response_dialog.dart';
import 'package:bytebank/componentes/transaction_auth_dialog.dart';
import 'package:bytebank/https/webclients/transaction_webclient.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../app_dependencies.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final String _transactionID = Uuid().v4();
  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                child: ProgressBar(message: 'Seding...'),
                visible: _sending,
              ),
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text('Transfer'),
                    onPressed: () {
                      final double value =
                          double.tryParse(_valueController.text);
                      final transactionCreated =
                          Transaction(_transactionID, value, widget.contact);
                      showDialog(
                          context: context,
                          builder: (contextDialog) {
                            return TransactionAuthDialog(
                              onConfirm: (String password) {
                                setState(() {
                                  _sending = true;
                                });
                                _save(transactionCreated, password, context,
                                    dependencies.transactionWebClient);
                              },
                            );
                          });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(
    Transaction transactionCreated,
    String password,
    BuildContext context,
    TransactionWebClient transactionWebClient,
  ) async {
    final Transaction transaction = await transactionWebClient
        .saveTransaction(transactionCreated, password)
        .catchError((error) {
      showDialog(
          context: context,
          builder: (contextDialog) {
            return FailureDialog(error.message);
          });
    }, test: (error) => error is HttpException).catchError((error) {
      _showFailureMessage(context, messageError: 'Timeout error');
    }, test: (error) => error is TimeoutException).catchError((error) {
      _showFailureMessage(context);
    }).whenComplete(() {
      setState(() {
        _sending = false;
      });
    });
    if (transaction != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog('successful transaction');
          });
      Navigator.pop(context);
    }
  }

  Future _showFailureMessage(BuildContext context,
      {String messageError = 'Unknow Error'}) {
    return showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(messageError);
        });
  }
}
