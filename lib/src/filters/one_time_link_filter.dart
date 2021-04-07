import 'package:pigeonholelive_sdk/src/filters/filter.dart';

class OneTimeLinkFilter implements Filter {
  List<String>? token;
  bool? used;

  OneTimeLinkFilter({
    this.token,
    this.used,
  });

  @override
  Map<String, dynamic> build() {
    var filters = <String, dynamic>{};

    if (token != null) {
      filters['filter[token]'] = token!.join(',');
    }

    if (used != null) {
      filters['filter[used]'] = used.toString();
    }

    return filters;
  }
}
