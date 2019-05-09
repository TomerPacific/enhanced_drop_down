import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:enhanced_drop_down/enhanced_drop_down.dart';

void main() {
  testWidgets("Testing widget creation", (WidgetTester tester) async {
    var widget = EnhancedDropDown(defaultOptionText: "Choose Me",
        dropdownLabelTitle: "Label",
        dataSource: ["A", "B"],
        urlToFetchData: "",
        valueReturned: null);

    await tester.pumpWidget(
      StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return MaterialApp(
          home: Material(
            child: Center(
              child: widget,
            ),
          ),
        );
      },
    ),
    );

    final titleFinder = find.text('Label');
    expect(titleFinder, findsOneWidget);
  });


  testWidgets("Testing widget creation", (WidgetTester tester) async {
    var widget = EnhancedDropDown(defaultOptionText: "Choose Me",
        dropdownLabelTitle: "Label",
        dataSource: ["A"],
        urlToFetchData: "",
        valueReturned: null);

    await tester.pumpWidget(
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return MaterialApp(
            home: Material(
              child: Center(
                child: widget,
              ),
            ),
          );
        },
      ),
    );

    await tester.tap(find.text("Choose Me"));
    await tester.pump();

  });
}
