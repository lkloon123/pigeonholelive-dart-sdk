import 'package:json_annotation/json_annotation.dart';

class DateTimeConverter implements JsonConverter<DateTime?, String?> {
  const DateTimeConverter();

  @override
  DateTime? fromJson(String? json) {
    return json == null ? null : DateTime.parse(json);
  }

  @override
  String? toJson(DateTime? object) {
    return object?.toIso8601String();
  }
}
