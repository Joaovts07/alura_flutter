import 'package:bytebank/componentes/response_dialog.dart';
import 'package:bytebank/componentes/transaction_auth_dialog.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/screens/transaction_form.dart';
import 'package:bytebank/screens/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/test_matchers.dart';
import '../mocks/mocks.dart';
import 'actions.dart';

void main() {
  testWidgets('Should transfer to a contact', (tester) async {
    final mockContactDao = MockContactDao();
    final mockTransactionWebClient = MockWebClient();
    final joe = Contact(0, 'Joe', '1000');

    await openDashboard(tester, mockContactDao, mockTransactionWebClient);
    when(mockContactDao.findAll()).thenAnswer((invocation) async => [joe]);

    when(mockTransactionWebClient.saveTransaction(
            Transaction(null, 200, joe), '1000'))
        .thenAnswer((_) async => Transaction(null, 200, joe));
    await verifyFeatureItemAndClick(
        tester, 'Transaction Feed', Icons.description);
    await tester.pumpAndSettle();

    final transactionList = find.byType(TransactionsList);
    expect(transactionList, findsOneWidget);

    final fabNewTransaction =
        find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabNewTransaction, findsOneWidget);
    await tester.tap(fabNewTransaction);
    await tester.pumpAndSettle();
    final transactionForm = find.byType(TransactionForm);
    expect(transactionForm, findsOneWidget);

    final textFieldValue = find.byWidgetPredicate((widget) {
      return textFieldByLabelTextMatcher(widget, 'Value');
    });
    expect(textFieldValue, findsOneWidget);
    await tester.enterText(textFieldValue, '200');

    final transferButton = find.widgetWithText(ElevatedButton, 'Transfer');
    expect(transferButton, findsOneWidget);
    await tester.tap(transferButton);
    await tester.pumpAndSettle();

    final transactionAuthDialog = find.byType(TransactionAuthDialog);
    expect(transactionAuthDialog, findsOneWidget);

    final textFieldPassword =
        find.byKey(transactionAuthDialogTextFieldPasswordKey);
    expect(textFieldPassword, findsOneWidget);
    await tester.enterText(textFieldPassword, '1000');

    final cancelButton = find.widgetWithText(TextButton, 'Cancel');
    expect(cancelButton, findsOneWidget);

    final confirmButton = find.widgetWithText(TextButton, 'Confirm');
    expect(confirmButton, findsOneWidget);

    /*await tester.tap(confirmButton);
    await tester.pumpAndSettle();

    final successDialog = find.byType(SuccessDialog);
    expect(successDialog, findsOneWidget);

    final okButton = find.widgetWithText(TextButton, 'Ok');
    expect(okButton, findsOneWidget);
    await tester.tap(okButton);
    await tester.pumpAndSettle();*/
  });
}
