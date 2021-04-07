import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('Session Filter test', () {
    test('should build correct Map', () {
      var now = DateTime.now();
      var filter = SessionFilter(
        id: [1],
        startsBefore: now,
        startsAfter: now,
        startsBetween: [now, now.add(Duration(days: 1))],
        endsBefore: now,
        endsAfter: now,
        endsBetween: [now, now.add(Duration(days: 2))],
      );

      var result = filter.build();
      expect(result.length, equals(7));
      expect(result['filter[id]'], equals('1'));
      expect(result['filter[startsBefore]'], equals(now.toIso8601String()));
      expect(result['filter[startsAfter]'], equals(now.toIso8601String()));
      expect(
        result['filter[startsBetween]'],
        equals(
          now.toIso8601String() +
              ',' +
              now.add(Duration(days: 1)).toIso8601String(),
        ),
      );
      expect(result['filter[endsBefore]'], equals(now.toIso8601String()));
      expect(result['filter[endsAfter]'], equals(now.toIso8601String()));
      expect(
        result['filter[endsBetween]'],
        equals(
          now.toIso8601String() +
              ',' +
              now.add(Duration(days: 2)).toIso8601String(),
        ),
      );
    });
  });
}
