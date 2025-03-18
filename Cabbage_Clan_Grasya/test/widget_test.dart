import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pass_it_forward/main.dart';

void main() {
  testWidgets('PassItForwardApp loads Home screen and navigation items', (WidgetTester tester) async {
    // Build the app and trigger a frame
    await tester.pumpWidget(const PassItForwardApp());

    // Check that we see the AppBar title "Home"
    expect(find.text('Home'), findsOneWidget);

    // Check that bottom navigation contains "Home", "Search", "Chat", and "Profile"
    expect(find.text('Search'), findsOneWidget);
    expect(find.text('Chat'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });
}
