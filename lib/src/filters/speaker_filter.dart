import 'package:pigeonholelive_sdk/src/filters/filter.dart';

class SpeakerFilter implements Filter {
  List<int>? id;
  List<String>? fullName;

  SpeakerFilter({
    this.id,
    this.fullName,
  });

  @override
  Map<String, dynamic> build() {
    var filters = <String, dynamic>{};

    if (id != null) {
      filters['filter[id]'] = id!.join(',');
    }

    if (fullName != null) {
      filters['filter[fullName]'] = fullName!.join(',');
    }

    return filters;
  }
}
