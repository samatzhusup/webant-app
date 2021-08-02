// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseModel<T> _$BaseModelFromJson<T>(Map<String, dynamic> json) {
  return BaseModel<T>(
    (json['data'] as List<dynamic>)
        .map((e) => _Converter<T>().fromJson(e as Object))
        .toList(),
    json['countOfPages'] as int,
    json['totalItems'] as int,
    json['itemsPerPage'] as int,
  );
}

Map<String, dynamic> _$BaseModelToJson<T>(BaseModel<T> instance) =>
    <String, dynamic>{
      'data': instance.data.map(_Converter<T>().toJson).toList(),
      'countOfPages': instance.countOfPages,
      'totalItems': instance.totalItems,
      'itemsPerPage': instance.itemsPerPage,
    };
