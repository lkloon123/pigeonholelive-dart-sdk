import 'package:pigeonholelive_sdk/src/config.dart';
import 'package:pigeonholelive_sdk/src/filters/filter.dart';
import 'package:pigeonholelive_sdk/src/models/pagination/pagination_meta.dart';
import 'package:pigeonholelive_sdk/src/service_provider/service_provider_manager.dart';

class ParameterBuilder {
  final Map<String, dynamic>? _parameters = <String, dynamic>{};

  Config get config => ServiceProviderManager.instance.getIt.get<Config>();

  ParameterBuilder addPaginationToParams({
    required PaginationMeta? paginationMeta,
  }) {
    if (paginationMeta?.hasMore ?? false) {
      _parameters?.addAll({'cursor': paginationMeta?.nextCursor});
    }

    if (config.perPage != null) {
      _parameters?.addAll({'count': config.perPage});
    }

    return this;
  }

  ParameterBuilder addFiltersToParams({required dynamic? filter}) {
    if (filter == null) {
      return this;
    }

    if (filter is! Filter && filter is! Map<String, String>) {
      throw Exception(
        'filter should be instance of Filter or Map<String, String>',
      );
    }

    if (filter is Filter) {
      _parameters?.addAll(filter.build());
    }

    if (filter is Map<String, String>) {
      _parameters?.addAll(filter);
    }

    return this;
  }

  Map<String, dynamic>? get parameters {
    if (_parameters?.isEmpty ?? true) {
      return null;
    }

    return _parameters;
  }
}
