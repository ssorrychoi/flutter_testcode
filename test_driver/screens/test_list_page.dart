import 'package:flutter_driver/flutter_driver.dart';

import 'test_screen.dart';

class TestListPage extends TestScreen {
  final _listPage = find.byValueKey('listPage');
  final _listFinder = find.byValueKey('long_list');
  final _itemFinder = find.byValueKey('item_50_text');

  TestListPage(FlutterDriver driver) : super(driver);

  Future<Null> scrolling() async {
    await driver.scrollUntilVisible(_listFinder, _itemFinder, dyScroll: -300);
  }

  Future<String> get item => driver.getText(_itemFinder);
}
