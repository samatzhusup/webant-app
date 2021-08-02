// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PhotoModelAdapter extends TypeAdapter<PhotoModel> {
  @override
  final int typeId = 0;

  @override
  PhotoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PhotoModel(
      id: fields[0] as int,
      name: fields[1] as String,
      newType: fields[2] as bool,
      popularType: fields[3] as bool,
      description: fields[4] as String,
      image: fields[5] as ImageModel,
      dateCreate: fields[6] as String,
      user: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PhotoModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.newType)
      ..writeByte(3)
      ..write(obj.popularType)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.dateCreate)
      ..writeByte(7)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhotoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotoModel _$PhotoModelFromJson(Map<String, dynamic> json) {
  return PhotoModel(
    id: json['id'] as int,
    name: json['name'] as String,
    newType: json['new'] as bool,
    popularType: json['popular'] as bool,
    description: json['description'] as String,
    image: ImageModel.fromJson(json['image'] as Map<String, dynamic>),
    dateCreate: json['dateCreate'] as String,
    user: json['user'] as String,
  );
}

Map<String, dynamic> _$PhotoModelToJson(PhotoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'new': instance.newType,
      'popular': instance.popularType,
      'description': instance.description,
      'image': instance.image.toJson(),
      'dateCreate': instance.dateCreate,
      'user': instance.user,
    };
