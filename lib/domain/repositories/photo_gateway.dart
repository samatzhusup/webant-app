import 'package:webant/domain/models/base_model/base_model.dart';

abstract class PhotoGateway<T> {

  String enumToString();

  Future<BaseModel<T>> fetchPhotos({int page, var queryText});

}
