import 'dart:io';

import 'package:path/path.dart' as path;

void main() {
  final buffer = StringBuffer();
  var filenames = <String>[];

  buffer.writeln('/// GENERATED FILE TO RUN ALL TEST');

  Directory('./test').listSync(recursive: true).toList().forEach((element) {
    if (element is File) {
      if (element.path.endsWith('test.dart')) {
        var basePath = element.path.replaceAll('./test/', '');

        var filename = basePath.split('/').last.split('.').first;
        filenames.add(filename);

        buffer.writeln("import '$basePath' as $filename;");
      }
    }
  });

  buffer.writeln();
  buffer.writeln('void main() {');
  filenames.forEach((filename) {
    buffer.writeln('  $filename.main();');
  });
  buffer.writeln('}');

  File(
    path.join(Directory('./test').path, '.test_all_with_coverage.dart'),
  ).writeAsStringSync(buffer.toString());
}
