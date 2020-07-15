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



