import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:subject/home_page.dart';

void main() {
  testWidgets('App loads and shows student info and subjects', (WidgetTester tester) async {
    // 🧩 Try to build your main app widget (replace HomePage if needed)
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    // ✅ Verify your info appears
    expect(find.text('Amr Khalid Abdelmgeed'), findsOneWidget);
    expect(find.text('ID: 221002193'), findsOneWidget);
    expect(find.text('Email: a.khalid2293@nu.edu.eg'), findsOneWidget);

    // ✅ Verify the subjects exist
    expect(find.text('IS Subject'), findsOneWidget);
    expect(find.text('TS Subject'), findsOneWidget);

    // ✅ Navigate to IS page
    await tester.tap(find.text('IS Subject'));
    await tester.pumpAndSettle();
    expect(find.text('Information Systems'), findsOneWidget);

    // ✅ Navigate back
    await tester.pageBack();
    await tester.pumpAndSettle();

    // ✅ Navigate to TS page
    await tester.tap(find.text('TS Subject'));
    await tester.pumpAndSettle();
    expect(find.text('Technical Skills'), findsOneWidget);
  });
}
