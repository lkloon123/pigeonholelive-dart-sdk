import 'package:pigeonholelive_sdk/src/filters/filter.dart';

class SessionFilter implements Filter {
  List<int>? id;
  DateTime? startsBefore;
  DateTime? startsAfter;
  List<DateTime>? startsBetween;
  DateTime? endsBefore;
  DateTime? endsAfter;
  List<DateTime>? endsBetween;

  SessionFilter({
    this.id,
    this.startsBefore,
    this.startsAfter,
    this.startsBetween,
    this.endsBefore,
    this.endsAfter,
    this.endsBetween,
  });

  @override
  Map<String, dynamic> build() {
    var filters = <String, dynamic>{};

    if (id != null) {
      filters['filter[id]'] = id!.join(',');
    }

    if (startsBefore != null) {
      filters['filter[startsBefore]'] = startsBefore!.toIso8601String();
    }

    if (startsAfter != null) {
      filters['filter[startsAfter]'] = startsAfter!.toIso8601String();
    }

    if (startsBetween != null) {
      filters['filter[startsBetween]'] = startsBetween!.join(',');
    }

    if (endsBefore != null) {
      filters['filter[endsBefore]'] = endsBefore!.toIso8601String();
    }

    if (endsAfter != null) {
      filters['filter[endsAfter]'] = endsAfter!.toIso8601String();
    }

    if (endsBetween != null) {
      filters['filter[endsBetween]'] = endsBetween!.join(',');
    }

    return filters;
  }
}
