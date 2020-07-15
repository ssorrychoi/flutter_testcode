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

