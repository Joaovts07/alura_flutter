import 'package:bytebank/database/DAO/contact_dao.dart';
import 'package:bytebank/https/webclients/transaction_webclient.dart';
import 'package:bytebank/screens/dashboard/dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_dependencies.dart';
import 'componentes/bytebank_theme.dart';
import 'models/saldo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var debug = false;
  if (debug) {
    // Esta linha avisa a todas as instâncias do Crashlytics no projeto que ele não poderá registrar relatórios de erro
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  } else {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FirebaseCrashlytics.instance.setUserIdentifier('alura123');
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => Saldo(0),
      )
    ],
    child: BytebankApp(
      contactDao: ContactDao(),
      transactionWebClient: TransactionWebClient(),
    ),
  ));
}

class BytebankApp extends StatelessWidget {
  // This widget is the root of your application.
  final ContactDao contactDao;
  final TransactionWebClient transactionWebClient;

  const BytebankApp({this.contactDao, this.transactionWebClient});

  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      contactDao: contactDao,
      transactionWebClient: transactionWebClient,
      child: MaterialApp(
        theme: bytebankTheme,
        home: Dashboard(),
      ),
    );
  }
}
