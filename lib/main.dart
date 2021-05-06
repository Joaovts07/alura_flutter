import 'package:bytebank/database/DAO/contact_dao.dart';
import 'package:bytebank/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_dependencies.dart';
import 'componentes/bytebank_theme.dart';
import 'models/saldo.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => Saldo(0),
      )
    ],
    child: BytebankApp(contactDao: ContactDao(),),
  ));
}

class BytebankApp extends StatelessWidget {
  // This widget is the root of your application.
  final ContactDao contactDao;

  const BytebankApp({this.contactDao});
  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      child: MaterialApp(
        theme: bytebankTheme,
        home: Dashboard(contactDao: contactDao,),
      ),
    );
  }
}
