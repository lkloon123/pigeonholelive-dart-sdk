import 'package:pigeonholelive_sdk/src/filters/filter.dart';
import 'package:pigeonholelive_sdk/src/models/enums/pigeonhole_status.dart';
import 'package:pigeonholelive_sdk/src/utils/enum_helper.dart';

class PigeonholeFilter implements Filter {
  List<int>? id;
  List<String>? timezone;
  List<String>? passcode;
  List<String>? name;
  List<PigeonholeStatus>? status;

  PigeonholeFilter({
    this.id,
    this.timezone,
    this.passcode,
    this.name,
    this.status,
  });

  @override
  Map<String, dynamic> build() {
    var filters = <String, dynamic>{};

    if (id != null) {
      filters['filter[id]'] = id!.join(',');
    }

    if (timezone != null) {
      filters['filter[timezone]'] = timezone!.join(',');
    }

    if (passcode != null) {
      filters['filter[passcode]'] = passcode!.join(',');
    }

    if (name != null) {
      filters['filter[name]'] = name!.join(',');
    }

    if (status != null) {
      filters['filter[status]'] = status!.map((pigeonholeStatus) {
        return EnumHelper.getValue(pigeonholeStatus);
      }).join(',');
    }

    return filters;
  }
}
