import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:webant/domain/models/photos_model/photo_model.dart';
import 'package:webant/domain/models/user/user_model.dart';
import 'package:webant/domain/repositories/firestore_repository.dart';

class FirebaseFirestoreRepository extends FirestoreRepository {
  final _photos = FirebaseFirestore.instance.collection('photos');

  @override
  Stream<int> getCount(PhotoModel photo) {
    return _photos
        .doc(photo.id.toString())
        .snapshots()
        .map((doc) => doc['viewsCount']);
  }

  Future<void> uploadFile(File file) async {
    try {
      await FirebaseStorage.instance
          .ref('uploads/file-to-upload.png')
          .putFile(file);
    } catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  @override
  Stream<int> getViewsCountOfUserPhoto(UserModel user) {
    return _photos
        .where('user', isEqualTo: '/api/users/${user.id}')
        .snapshots()
        .map((event) =>
            event.docs.fold(0, (prev, next) => prev + next['viewsCount']));
  }

  @override
  Future<void> createPhoto(PhotoModel photo, List<String> tags) async {
    Map<String, dynamic> data = photo.toJson();
    data.addAll({
      'tags': tags,
      'viewsCount': 0,
    });
    _photos
        .doc(photo.id.toString())
        .set(data)
        .onError((error, stackTrace) => null);
  }

  @override
  Future<void> incrementViewsCount(PhotoModel photo) async {
    var photoRef = _photos.doc(photo.id.toString());
    await photoRef.get().then((DocumentSnapshot doc) {
      if (!doc.exists) {
        Map<String, dynamic> data = photo.toJson();
        data.addAll({
          'viewsCount': 0,
        });
        photoRef.set(data);
      }
    }).catchError((onError) {
      return;
    });
    await photoRef.get().then((DocumentSnapshot doc) {
      photoRef.update({'viewsCount': FieldValue.increment(1)});
    });
  }

  @override
  Future<List<dynamic>> getTags(PhotoModel photo) async {
    DocumentSnapshot doc = await _photos.doc(photo.id.toString()).get();
    if (doc.exists) {
      try {
        List<dynamic> tags = doc['tags'];
        if (tags.isNotEmpty || tags != null) {
          return tags;
        }
      } catch (e) {
        return [];
      }
    }
    return [];
  }
}
