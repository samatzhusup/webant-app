import 'package:json_annotation/json_annotation.dart';

part 'oauth_model.g.dart';

@JsonSerializable()
class OauthModel {

  final int id;
  final String name;
  final String randomId;
  final String secret;
  final List<String> allowedGrantTypes;

  OauthModel(this.id, this.name, this.randomId, this.secret, this.allowedGrantTypes);

  factory OauthModel.fromJson(Map<String, dynamic> json) =>
      _$OauthModelFromJson(json);

  Map<String, dynamic> toJson() => _$OauthModelToJson(this);
}