import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:test_code/model/counter.dart';
import 'package:test_code/screens/my_home_page.dart';

void main() {
  testWidgets('myHomePage Widget Test', (WidgetTester tester) async {
    final _providerKey = GlobalKey();
    BuildContext context;
    await tester.pumpWidget(ChangeNotifierProvider<Counter>(
        key: _providerKey,
        create: (c) {
          context = c;
          return Counter();
        },
        child: MaterialApp(home: MyHomePage(title: 'T'))));

    /// appBar의 title
    final titleFinder = find.text('T');
    expect(titleFinder, findsOneWidget);

    /// body 영역의 Text
    final description =
        find.text('You have pushed the button this many times:');
    expect(description, findsOneWidget);

    /// body 영역의 count
    final countText = find.text('0');
    expect(countText, findsOneWidget);

    /// Flatbutton
    final button = find.byKey(Key('flatButton'));
    expect(button, findsOneWidget);

    /// FloatingActionButton
    final incrementBtn = find.byKey(Key('Increment'));
    expect(incrementBtn, findsOneWidget);

    final decrementBtn = find.byKey(Key('Decrement'));
    expect(decrementBtn, findsOneWidget);

    /// Increment 버튼 tap했을때
    await tester.tap(find.byKey(Key('Increment')));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);

    /// Decrement 버튼 tap했을때
    await tester.tap(find.byKey(Key('Decrement')));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);
  });
}
