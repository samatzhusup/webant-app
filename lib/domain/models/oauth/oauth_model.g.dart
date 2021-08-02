// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oauth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OauthModel _$OauthModelFromJson(Map<String, dynamic> json) {
  return OauthModel(
    json['id'] as int,
    json['name'] as String,
    json['randomId'] as String,
    json['secret'] as String,
    (json['allowedGrantTypes'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
  );
}

Map<String, dynamic> _$OauthModelToJson(OauthModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'randomId': instance.randomId,
      'secret': instance.secret,
      'allowedGrantTypes': instance.allowedGrantTypes,
    };
