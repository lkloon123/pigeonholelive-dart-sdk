import 'package:pigeonholelive_sdk/src/filters/filter.dart';
import 'package:pigeonholelive_sdk/src/models/custom_profile_field.dart';

class AttendeeFilter implements Filter {
  List<int>? id;
  List<String>? attendeeCode;
  List<int>? sessionId;
  CustomProfileField? customProfileField;

  AttendeeFilter({
    this.id,
    this.attendeeCode,
    this.sessionId,
    this.customProfileField,
  });

  @override
  Map<String, dynamic> build() {
    var filters = <String, dynamic>{};

    if (id != null) {
      filters['filter[id]'] = id!.join(',');
    }

    if (attendeeCode != null) {
      filters['filter[attendeeCode]'] = attendeeCode!.join(',');
    }

    if (sessionId != null) {
      filters['filter[sessionId]'] = sessionId!.join(',');
    }

    if (customProfileField != null) {
      customProfileField!.fields.forEach((key, value) {
        filters['filter[$key]'] = value is List ? value.join(',') : value;
      });
    }

    return filters;
  }
}
