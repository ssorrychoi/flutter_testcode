import 'package:flutter_driver/flutter_driver.dart';

import 'test_screen.dart';

class MyHomeTestPage extends TestScreen {
  final _counterTextFinder = find.byValueKey('counter');
  final _incrementBtn = find.byValueKey('Increment');
  final _decrementBtn = find.byValueKey('Decrement');
  final _httpPage = find.byValueKey('httpPage');
  final _listPage = find.byValueKey('listPage');

  MyHomeTestPage(FlutterDriver driver) : super(driver);

  Future<Null> tabIncrement() async {
    await driver.tap(_incrementBtn);
  }

  Future<Null> tabDecrement() async {
    await driver.tap(_decrementBtn);
  }

  Future<String> get textCounter => driver.getText(_counterTextFinder);

  Future<Null> tabhttpPage() async {
    await driver.tap(_httpPage);
  }

  Future<Null> tabListPage() async {
    await driver.tap(_listPage);
  }

  Future<Null> backButton() async {
    await driver.tap(find.pageBack());
  }
}
