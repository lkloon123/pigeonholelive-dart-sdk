import 'package:pigeonholelive_sdk/src/filters/filter.dart';
import 'package:pigeonholelive_sdk/src/models/custom_profile_field.dart';

class RegistrantFilter implements Filter {
  List<int>? id;
  List<String>? attendeeCode;
  bool? signedId;
  CustomProfileField? customProfileField;

  RegistrantFilter({
    this.id,
    this.attendeeCode,
    this.signedId,
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

    if (signedId != null) {
      filters['filter[signedId]'] = signedId;
    }

    if (customProfileField != null) {
      customProfileField!.fields.forEach((key, value) {
        filters['filter[$key]'] = value is List ? value.join(',') : value;
      });
    }

    return filters;
  }
}
