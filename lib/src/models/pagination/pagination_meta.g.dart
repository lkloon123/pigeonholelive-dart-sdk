// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationMeta _$PaginationMetaFromJson(Map<String, dynamic> json) {
  return PaginationMeta(
    perPage: json['perPage'] as int?,
    nextCursor: json['nextCursor'] as String?,
    hasMore: json['hasMore'] as bool?,
  );
}

Map<String, dynamic> _$PaginationMetaToJson(PaginationMeta instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('perPage', instance.perPage);
  writeNotNull('nextCursor', instance.nextCursor);
  writeNotNull('hasMore', instance.hasMore);
  return val;
}
