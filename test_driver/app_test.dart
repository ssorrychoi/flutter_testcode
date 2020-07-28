import 'package:flutter_driver/flutter_driver.dart';

import 'package:test/test.dart';

import 'screens/my_home_test_page.dart';
import 'screens/test_list_page.dart';

void main() {
//  group('Counter App', () {
//    final counterTextFinder = find.byValueKey('counter');
//    final incrementBtn = find.byValueKey('Increment');
//    final decrementBtn = find.byValueKey('Decrement');
//
//    final listPage = find.byValueKey('listPage');
//
//    FlutterDriver driver;
//
//    setUpAll(() async {
//      driver = await FlutterDriver.connect();
//    });
//
//    tearDownAll(() async {
//      if (driver != null) {
//        driver.close();
//      }
//    });
//
//    test('starts at 0', () async {
//      expect(await driver.getText(counterTextFinder), "0");
//    });
//
//    test('Increments the counter', () async {
//      await driver.tap(incrementBtn);
//
//      expect(await driver.getText(counterTextFinder), "1");
//    });
//
//    test('Decrements the counter', () async {
//      await driver.tap(decrementBtn);
//      expect(await driver.getText(counterTextFinder), "0");
////      await driver.tap(listPage);
//    });
//  });
//
////  group('Move to next Page', () {
////    final httpPage = find.byValueKey('httpPage');
////
////    FlutterDriver driver;
////
////    setUpAll(() async {
////      driver = await FlutterDriver.connect();
////    });
////
////    tearDownAll(() async {
////      if (driver != null) {
////        driver.close();
////      }
////    });
////
////    test('next page', () async {
////      await driver.tap(httpPage);
////    });
////  });
//
//  group('Move to List Page', () {
//    final listPage = find.byValueKey('listPage');
//    final listFinder = find.byValueKey('long_list');
//    final itemFinder = find.byValueKey('item_50_text');
//
//    FlutterDriver driver;
//    setUpAll(() async {
//      driver = await FlutterDriver.connect();
//      await driver.tap(listPage);
//    });
//
//    tearDownAll(() async {
//      if (driver != null) {
//        driver.close();
//      }
//    });
//
//    test('tap list page btn', () async {
//      await driver.scrollUntilVisible(listFinder, itemFinder, dyScroll: -900);
//      expect(await driver.getText(itemFinder), 'Item 50');
//      await driver.tap(find.pageBack());
//    });
//  });
  group('Counter App Test POM pattern', () {
    FlutterDriver driver;
    MyHomeTestPage homePage;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      homePage = MyHomeTestPage(driver);
    });
    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test('Starts at 0', () async {
      expect(await homePage.textCounter, '0');
    });

    test('Tap Increment button', () async {
      await homePage.tabIncrement();
      expect(await homePage.textCounter, '1');
    });

    test('Tap Decrement button', () async {
      await homePage.tabDecrement();
      expect(await homePage.textCounter, '0');
    });

    test('move to http page', () async {
      await homePage.tabhttpPage();
      await homePage.backButton();
    });

    test('move to List page', () async {
      await homePage.tabListPage();
    });

    test('scrolling list page test', () async {
      final TestListPage listPage = new TestListPage(driver);
      await listPage.scrolling();
      expect(await listPage.item, 'Item 50');
    });

//    test('List page', () async {
//      final listPage = TestListPage(driver);
//      await listPage.scrolling();
//      expect(await listPage.item, 'Item 50');
//    });
  });
}
