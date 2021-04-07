import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('Speaker Filter test', () {
    test('should build correct Map', () {
      var filter = SpeakerFilter(
        id: [1],
        fullName: ['david', 'john'],
      );

      var result = filter.build();
      expect(result.length, equals(2));
      expect(result['filter[id]'], equals('1'));
      expect(result['filter[fullName]'], equals('david,john'));
    });
  });
}