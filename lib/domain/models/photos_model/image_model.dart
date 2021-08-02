
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class ImageModel {

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;

  ImageModel(this.id, this.name);

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);
}