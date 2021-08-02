import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:webant/domain/models/photos_model/image_model.dart';
import 'package:webant/domain/models/photos_model/photo_model.dart';
import 'package:webant/domain/repositories/post_photo_gateway.dart';
import 'http_oauth_gateway.dart';
import 'http_oauth_interceptor.dart';

class HttpPostPhoto extends PostPhotoGateway {
  final Dio _dio = Dio()
    ..interceptors.add(LogInterceptor(responseBody: true))
    ..options.baseUrl = 'http://gallery.dev.webant.ru/api';

  @override
  Future<PhotoModel> postPhoto(
      {File file, String name, String description}) async {
    _dio.interceptors.add(HttpOauthInterceptor(_dio, HttpOauthGateway()));
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: fileName),
    });
    Response response = await _dio.post('/media_objects', data: formData);
    var mediaObject = ImageModel.fromJson(response.data);
    Response photo = await _dio.post('/photos', data: {
      'name': name,
      'description': description,
      'new': true,
      'popular': false,
      'image': 'api/media_objects/${mediaObject.id}'
    });
    return PhotoModel.fromJson(photo.data);
  }

  @override
  Future<void> deletePhoto(PhotoModel photo) async {
    await _dio.delete('/photos/${photo.id}');
    //await dio.delete('/media_objects/${photo.image.id}');
  }

  @override
  Future<void> editPhoto(
      PhotoModel photo, String name, String description) async {
    await _dio.put('/photos/${photo.id}', data: {
      'name': name,
      'description': description,
    });
  }

  Future<void> incrementViewsCount(PhotoModel photo) async {
    int count = 1;
    CollectionReference counter =
        FirebaseFirestore.instance.collection('photos');
    var photoRef = counter.doc(photo.id.toString());
    await photoRef.get().then((DocumentSnapshot doc) {
      if (doc.exists) {
        doc.reference.update({'viewsCount': FieldValue.increment(1)});
      } else {
        photoRef.set(photo.toJson());
        photoRef.update({'viewsCount': count});
      }
    }).catchError((onError) {
      return 0;
    });
  }
}
