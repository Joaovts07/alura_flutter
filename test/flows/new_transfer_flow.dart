import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/mocks.dart';
import 'actions.dart';

void main(){
  testWidgets('Should transfer to a contact', (tester) async {
    final mockContactDao = MockContactDao();
    await openDashboard(tester, mockContactDao);
    await verifyFeatureItemAndClick(tester, 'Transaction Feed', Icons.description);
    await tester.pumpAndSettle();
  });
}