import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery/fooddeliveryform.dart';
//import 'package:your_app_name/main.dart';

void main() {
  testWidgets('Simple form UI test', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Find the submit button
    final submitButtonFinder = find.text('Submit');

    // Verify that the submit button is present
    expect(submitButtonFinder, findsOneWidget);

    // Tap the submit button
    await tester.tap(submitButtonFinder);

    // Wait for the animation to finish
    await tester.pumpAndSettle();

    // Verify that the form is submitted
    // For now, let's just verify that no exception was thrown
    expect(tester.takeException(), isNull);
  });
}
