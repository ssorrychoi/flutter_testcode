import 'package:test/test.dart';
import 'package:test_code/model/counter.dart';

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