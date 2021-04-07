import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('One Time Link Filter test', () {
    test('should build correct Map', () {
      var filter = OneTimeLinkFilter(
        token: ['xxx', 'yyy'],
        used: true,
      );

      var result = filter.build();
      expect(result.length, equals(2));
      expect(result['filter[token]'], equals('xxx,yyy'));
      expect(result['filter[used]'], equals(true));
    });
  });
}