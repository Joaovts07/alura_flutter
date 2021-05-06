import 'package:bytebank/main.dart';
import 'package:bytebank/screens/dashboard/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import '../matchers/test_matchers.dart';
import '../mocks/mocks.dart';

Future openDashboard(WidgetTester tester, MockContactDao mockContactDao) async {
  await tester.pumpWidget(BytebankApp(contactDao: mockContactDao));
  final dashboard = find.byType(Dashboard);
  expect(dashboard, findsOneWidget);
}

Future verifyFeatureItemAndClick(
    WidgetTester tester, String description, IconData icon) async {
  final featureItem = find.byWidgetPredicate(
          (widget) => featureItemMatcher(widget, description,icon));
  expect(featureItem, findsOneWidget);
  await tester.tap(featureItem);
}