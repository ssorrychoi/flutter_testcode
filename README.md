# test_code

A Flutter test code for basic counter app.

[앱 테스트](https://flutter-ko.dev/docs/testing)

- Unit Test : 단위 기능, 방법 또는 클래스를 테스트. (가장 작은 단위의 테스트)
- Widget Test : 단일 위젯을 테스트. (컴포넌트 테스트)
- Integration Test : 완성된 앱이나 앱의 상당 부분을 테스트



## Unit Test(단위 테스트)

- 단위기능, 방법 또는 클래스를 테스트한다. 단위 테스트의 목적은 다양한 조건 아래에서 로직 단위의 정확성을 검증하는 것이다.
- 일반적으로 테스트 되는 단위 조직의 외부 의존성은 모의 객체로 대체한다.
- 사용방법
  - [Mockito를 사용해서 mock 객체 생성하기](https://flutter-ko.dev/docs/cookbook/testing/unit/mocking)
  - [단위 테스트 소개](https://flutter-ko.dev/docs/cookbook/testing/unit/introduction)



## Widget Test(위젯 테스트)

- 단일 위젯을 테스트한다. 위젯 테스트의 목적은 위젯 UI가 예상한대로 보이고 상호 작용하는지 검증하는 것이다.
- 위젯 테스트는 다수의 클래스를 포함하며 적합한 위젯 생명주기 컨텍스트를 제공하는 테스트 환경을 요구한다.
- 사용방법
  - [위젯 테스트 소개](https://flutter-ko.dev/docs/cookbook/testing/widget/introduction)
  - [Find Widgets](https://flutter-ko.dev/docs/cookbook/testing/widget/finders)
  - [Tap, rag, and enter text](https://flutter-ko.dev/docs/cookbook/testing/widget/tap-drag)



## Integration Test(통합 테스트)

- 완성된 앱이나 앱의 상당 부분을 테스트한다. 통합 테스트의 목적은 앱이 전체적으로 작동하는지, 모든 위젯이 예상대로 서로 통합되어 있는지를 확인하는 것이다.
- 앱의 성능 검증을 위해 사용할 수도 있다.
- 사용방법
  - [Handle Scrolling](https://flutter-ko.dev/docs/cookbook/testing/integration/scrolling)
  - [Performance profiling](https://flutter-ko.dev/docs/cookbook/testing/integration/profiling)
  - [통합테스트 소개](https://flutter-ko.dev/docs/cookbook/testing/integration/introduction)



---

## ✅ TestCode

우선 `Provider` 를 이용해서 `Counter app` 을 구현했다.

앱의 구조는 아래와 캡쳐 사진과 같이 구조를 짜봤다.

![image](https://user-images.githubusercontent.com/43080040/87552601-dd8fed00-c6ec-11ea-9be1-499955ead2c3.png)



👨‍💻 `lib/main.dart`

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_code/screens/my_home_page.dart';

import 'model/counter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Counter(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Flutter Counter App'),
      ),
    );
  }
}
```

> ✓ `MaterialApp` 을  `ChangeNotifierProvider` 로 감싼 이유는, `Provider`에 접근하기 위해서다.



👨‍💻 `lib/model/counter.dart` : `Provider` 로 클래스를 구현.

```dart
import 'package:flutter/cupertino.dart';

class Counter extends ChangeNotifier {
  int count = 0;

  void increment() {
    count++;
    notifyListeners();
  }
}
```



👨‍💻 `lib/screens/my_home_page` : 화면을 따로 빼서 구현.

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_code/model/counter.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Consumer<Counter>(
              builder: (context, counter, child) {
                return Text(
                  counter.count.toString(),
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            ///Text(Provider.of<Counter>(context).count.toString())
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Provider.of<Counter>(context, listen: false).increment(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
```

> `Counter` 클래스에서 숫자값인 count를 가져오기 위해선 `Consumer` 위젯을 사용했는데, 이는 return 값이 `Text` 라는 위젯이기 때문이다. 위젯을 return 값으로 받을 때는 `Consumer` 를  사용하고, `floatingActionButton` 에서 쓴 것과 같이, 함수만 불러오거나, 값만을 불러올 때는, `Provider.of<Counter>`를 사용해도 된다.
>
> `Counter` 클래스에서 숫자값만을 가져올때, `Consumer` 대신 `Provider.of<Counter>` 를 사용해도 무방하다. 
>
> ❌결국 둘다 같은 역할이지만, 상황에 따라 다르게 쓰면 된다.
>
> ‼️`Provider.of<Counter>(context,listen:false).increment()` 에서 `listen`은 버튼에 적용시킬땐 무조건 false값을 줘야한다. 기본값은 true인데, true로 해놓으면 계속해서 바라보고 있기 때문에 과부화(?)같은게 걸릴 수 있다.



---

## An introduction to unit testing

새로운 기능을 추가하거나 기존 기능을 변경했을때, 앱이 여전히 제대로 동작한다는 것을 테스트 코드를 통해 보장할 수 있다.

단위 테스트는 하나의 함수, method 또는 클래스의 동작을 검증하기 위해 아주 유용하다. `test` 패키지는 단위 테스트 작성을 위해 핵심 프레임워크를 제공하며, `flutter_test` 패키지는 위젯 테스트를 위한 추가적인 유틸리티를 제공한다.

📝 단위 테스트 시나리오
>1. `test`혹은 `flutter_test` 의존성 추가하기
2. 테스트 파일 생성하기
3. 테스트를 위한 클래스 생성하기
4. 클래스 테스트를 위한 test 코드 작성하기
5. 여러 테스트를 `group`으로 결합하기
6. 테스트 수행하기


### 1. 👨🏻‍💻 test 의존성 추가하기
만약 Flutter에 의존하지 않는 dart packages에서 작업하고 있다면 `test` 패키지를 import 하면 된다. `test`패키지는 dart에서 테스트 코드를 작성하기 위한 핵심 기능을 제공한다. 
```
dev_dependencies:
  test: <latest_version>
```

### 2. 👨🏻‍💻 테스트 파일 생성하기
본 예제에서는 두개의 파일을 만들 것이다. `counter.dart` 와 `counter_test.dart` 파일.
`counter.dart`파일은 테스트 대상이 될 클래스를 포함하며, `lib`폴더에 위치한다. 
`counter_test.dart`파일은 테스트 코드를 포함하며, `test`폴더에 위치한다.

다음과 같은 폴더 구조를 갖게된다.
```
counter_app/
  lib/
    model/
      counter.dart
  test/
    unit_test/
      counter_test.dart
```

### 3. 👨🏻‍💻 테스트를 위한 클래스 생성하기
이제 테스트할 대상이 필요하다. 
✅ 기억할 것 : 함수, method, class 모두 단위 테스트의 최소 단위가 될 수 있다.
본 예제에서는 `lib/model/counter.dart` 파일에 `Counter`클래스를 생성한다. 이 클래스는 0부터 시작하는 value의 증가, 감소를 담당할 것이다.
🚀provider를 이용해 구현했다.
```
import 'package:flutter/cupertino.dart';

class Counter extends ChangeNotifier {
  int count = 0;

  void increment() {
    count++;
    notifyListeners();
  }

  void decrement() {
    count--;
    notifyListeners();
  }
}

```

### 4. 👨🏻‍💻 클래스 테스트를 위한 test 코드 작성하기
`counter_test.dart` 파일에 첫 번째 단위 테스트를 작성해보자. 테스트 코드는 최상위 레벨의 `test`함수를 통해 작성되며, 최상위 레벨의 `expect`함수를 사용하여 그 결과가 올바른지 체크할 수 있다.

```
import 'package:test/test.dart';
import 'package:test_code/model/counter.dart';

void main(){
  test('test for Counter provider', () {
    final counter = Counter();

    counter.increment();
    expect(counter.count, 1);
  });
}
```

### 5. 👨🏻‍💻 여러 테스트를 group으로 결합하기
만약 관련있는 다른 테스트 코드들이 있다면, `test` 패키지에서 제공하는 `group`함수를 사용하여 결합할 수 있다.
```
void main(){
  group('test Counter Provider', (){
    test('test for Counter increment', () {
      final counter = Counter();

      counter.increment();
      expect(counter.count, 1);
    });
    test('test for Counter decrement', (){
      final counter = Counter();

      counter.decrement();
      expect(counter.count, -1);
    });
  });
}
```

### 6. 👨🏻‍💻 테스트 수행하기
IDE를 사용한다면, `counter.dart`파일을 열고 Run 버튼이 소스코드 옆에 있을 것이다. Run 버튼을 클릭하면 수행이 된다.

editor를 사용한다면 터미널에서 테스트를 수행해야 한다.
> flutter test '파일위치'
> ex) $ flutter test test/counter_test.dart