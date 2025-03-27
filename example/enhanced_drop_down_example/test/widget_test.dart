import 'package:enhanced_drop_down_example/constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:enhanced_drop_down_example/main.dart';

void main() {
  testWidgets('Pressing on dropdown with objects as data source test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text(EDW_WITH_DATA_OBJECT_LABEL), findsOneWidget);

    await tester.tap(find.text('Choose Person'));
    await tester.pumpAndSettle();

    expect(find.text('First'), findsOneWidget);
    expect(find.text('Last'), findsOneWidget);
  });

  testWidgets('Pressing on dropdown with array as data source test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text(EDW_WITH_DATA_STRING_LABEL), findsOneWidget);

    await tester.tap(find.text('Choose Letter'));
    await tester.pumpAndSettle();

    expect(find.text('A'), findsOneWidget);
    expect(find.text('B'), findsOneWidget);
  });
}
