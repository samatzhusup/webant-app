import 'package:json_annotation/json_annotation.dart';
import 'package:webant/domain/models/photos_model/photo_model.dart';
part 'base_model.g.dart';

@JsonSerializable()
class BaseModel<T> {

 @JsonKey(name: 'data')
 @_Converter()
 final List<T> data;

 final int countOfPages;
 final int totalItems;
 final int itemsPerPage;

 BaseModel(this.data, this.countOfPages, this.totalItems, this.itemsPerPage);

 factory BaseModel.fromJson(Map<String, dynamic> json) =>
     _$BaseModelFromJson<T>(json);

 Map<String, dynamic> toJson() => _$BaseModelToJson<T>(this);
}

class _Converter<T> implements JsonConverter<T, Object> {
 const _Converter();

 @override
 T fromJson(Object json) {
  if (json is Map<String, dynamic>) {
   return PhotoModel.fromJson(json) as T;
  }
  return json as T;
 }

 @override
 Object toJson(T object) {
  return Object;
 }
}