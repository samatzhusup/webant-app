import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:webant/presentation/resources/http_strings.dart';

import 'image_model.dart';

part 'photo_model.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 0)
class PhotoModel {
  @HiveField(0)
  @JsonKey(name: 'id')
  final int id;

  @HiveField(1)
  @JsonKey(name: 'name')
  final String name;

  @HiveField(2)
  @JsonKey(name: 'new')
  final bool newType;

  @HiveField(3)
  @JsonKey(name: 'popular')
  final bool popularType;

  @HiveField(4)
  @JsonKey(name: 'description')
  final String description;

  @HiveField(5)
  @JsonKey(name: 'image')
  final ImageModel image;

  @HiveField(6)
  @JsonKey(name: 'dateCreate')
  final String dateCreate;

  @HiveField(7)
  @JsonKey(name: 'user')
  final String user;

  PhotoModel({
    this.id,
    this.name,
    this.newType,
    this.popularType,
    this.description,
    this.image,
    this.dateCreate,
    this.user,
  });

  PhotoModel copyWith({
    int id,
    String name,
    bool newType,
    bool popularType,
    String description,
    ImageModel image,
    String dateCreate,
    String user,
  }) {
    return PhotoModel(
      id: id ?? this.id,
      name: name ?? this.name,
      newType: newType ?? this.newType,
      popularType: popularType ?? this.popularType,
      description: description ?? this.description,
      image: image ?? this.image,
      dateCreate: dateCreate ?? this.dateCreate,
      user: user ?? this.user,
    );
  }

  factory PhotoModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoModelFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoModelToJson(this);

  String getImage() {
    return HttpStrings.urlMedia + this.image.name.toString();
  }

  bool isPhotoSVG() {
    return this.image?.name?.contains('.svg') ?? false;
  }
}
