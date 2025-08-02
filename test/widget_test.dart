import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sautens/main.dart'; // Ensure this is the correct import

void main() {
  testWidgets('App loads BookNowScreen correctly', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const SauteAndSimmerApp());

    // Check if the "BOOK NOW" text is present in the widget tree.
    expect(find.text('BOOK NOW'), findsOneWidget);

    // Check if at least one event card is present
    expect(find.byType(Card), findsWidgets);
  });
}
