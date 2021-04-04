import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('Pigeonhole Filter test', () {
    test('should build correct Map', () {
      var filter = PigeonholeFilter(
        id: [1],
        timezone: ['timezone'],
        passcode: ['KQWBC9'],
        name: ['hello world'],
        status: [PigeonholeStatus.live],
      );

      var result = filter.build();
      expect(result.length, equals(5));
      expect(result['filter[id]'], equals('1'));
      expect(result['filter[timezone]'], equals('timezone'));
      expect(result['filter[passcode]'], equals('KQWBC9'));
      expect(result['filter[name]'], equals('hello world'));
      expect(result['filter[status]'], equals('live'));
    });
  });
}