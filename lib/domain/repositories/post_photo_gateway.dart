import 'dart:io';

import 'package:webant/domain/models/photos_model/photo_model.dart';

abstract class PostPhotoGateway{
  Future<void> postPhoto({File file, String name});
  Future<void> deletePhoto(PhotoModel photo);
  Future<void> editPhoto(PhotoModel photo, String name, String description);

}