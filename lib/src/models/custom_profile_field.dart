import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';

class CustomProfileField implements CastableToJson {
  Map<String, dynamic> fields;

  CustomProfileField({required this.fields});

  dynamic? get(String fieldName) {
    return fields[fieldName];
  }

  dynamic? operator [](String key) {
    return get(key);
  }

  bool has(String fieldName) {
    return fields.containsKey(fieldName);
  }

  List<String> allFieldNames() {
    return fields.keys.toList();
  }

  void set({required String fieldName, required String fieldValue}) {
    fields[fieldName] = fieldValue;
  }

  void operator []=(String key, String value) {
    set(fieldName: key, fieldValue: value);
  }

  factory CustomProfileField.fromJson(Map<String, dynamic> json) {
    return CustomProfileField(fields: json);
  }

  @override
  Map<String, dynamic> toJson() {
    return fields;
  }
}
