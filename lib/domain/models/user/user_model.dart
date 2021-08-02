import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends ChangeNotifier{

  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'email')
  String email;
  @JsonKey(name: 'enabled')
  bool enabled;
  @JsonKey(name: 'phone')
  String phone;
  @JsonKey(name: 'password')
  String password;
  @JsonKey(name: 'fullName')
  String fullName;
  @JsonKey(name: 'username')
  String username;
  @JsonKey(name: 'birthday')
  String birthday;
  @JsonKey(name: 'roles')
  List<String> roles;

  UserModel({
    this.id,
    this.email,
    this.enabled,
    this.phone,
    this.password,
    this.fullName,
    this.username,
    this.birthday,
    this.roles,
  });

  UserModel copyWith({
    int id,
    String email,
    bool enabled,
    String phone,
    String password,
    String fullName,
    String username,
    String birthday,
    List<String> roles,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      enabled: enabled ?? this.enabled,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      username: username ?? this.username,
      birthday: birthday ?? this.birthday,
      roles: roles ?? this.roles,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  String toJsonPost(UserModel data) {
    final jdata = data.toJson();
    return json.encode(jdata);
  }
}
