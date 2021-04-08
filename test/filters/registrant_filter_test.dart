import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('Registrant Filter test', () {
    test('should build correct Map', () {
      var filter = RegistrantFilter(
        id: [1],
        attendeeCode: ['xxx', 'yyy'],
        signedId: true,
        customProfileField: CustomProfileField(fields: {
          'name': 'david',
          'organization': 'xxx',
        }),
      );

      var result = filter.build();
      expect(result.length, equals(5));
      expect(result['filter[id]'], equals('1'));
      expect(result['filter[attendeeCode]'], equals('xxx,yyy'));
      expect(result['filter[signedId]'], equals(true));
      expect(result['filter[name]'], equals('david'));
      expect(result['filter[organization]'], equals('xxx'));
    });
  });
}
