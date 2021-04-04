import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('no next page exception test', () {
    test('should show correct msg', () {
      var exception = NoNextPageException();

      expect(exception.message, '');
      expect(exception.toString(), 'NoNextPageException');

      exception = NoNextPageException(msg: 'no next page');

      expect(exception.message, 'no next page');
      expect(exception.toString(), 'NoNextPageException: no next page');
    });
  });
}