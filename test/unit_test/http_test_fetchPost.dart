import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'package:test_code/service/api_provider.dart';

class MockClient extends Mock implements http.Client {}

main() {
  test('성공적으로 POST를 반환',() async {
    final client = MockClient();
    
    when(client.get('https://jsonplaceholder.typicode.com/posts/1')).thenAnswer((_) async => http.Response('{"title" : "Test"}',200));
    expect(await fetchPost(client),isInstanceOf<Post>());

  });

  test('err를 반환', () {
    final client = MockClient();

    when(client.get('https://jsonplaceholder.typicode.com/posts/1')).thenAnswer((_) async => http.Response('Not Found',404));
    expect(fetchPost(client), throwsException);
  });

}