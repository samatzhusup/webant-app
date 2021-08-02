import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:webant/data/repositories/http_post_photo.dart';
import 'package:webant/domain/models/photos_model/photo_model.dart';
import 'package:webant/domain/repositories/firestore_repository.dart';

part 'add_photo_event.dart';
part 'add_photo_state.dart';

class AddPhotoBloc extends Bloc<AddPhotoEvent, AddPhotoState> {
  PhotoModel photo;
  final HttpPostPhoto _httpPostPhoto;
  final FirestoreRepository _firestoreRepository;
  StreamSubscription _countSubscription;

  AddPhotoBloc(this._httpPostPhoto, {FirestoreRepository firestoreRepository})
      : _firestoreRepository = firestoreRepository,
        super(AddPhotoInitial());

  @override
  Stream<AddPhotoState> mapEventToState(
    AddPhotoEvent event,
  ) async* {
    if (event is CountUpdated) {
      yield CountOfViews(event.count);
    }
    if (event is PostPhoto) {
      yield* _mapPostPhotoToCompletePost(event);
    }
    if (event is DeletingPhoto) {
      yield* _mapEditingPhotoToDeletePhoto(event);
    }
    if (event is EditingPhoto) {
      yield* _mapEditingPhotoToCompletePost(event);
    }
    if (event is ViewsCounter) {
      yield* _mapViewsCounterToCountUpdated(event);
    }
    if (event is InitialEvent){
      yield AddPhotoInitial();
    }
  }

  Stream<AddPhotoState> _mapViewsCounterToCountUpdated(
      ViewsCounter event) async* {
    yield CountOfViews('');
    await _firestoreRepository.incrementViewsCount(event.photo);
    _countSubscription?.cancel();
    _countSubscription = _firestoreRepository.getCount(event.photo).listen(
          (count) => add(CountUpdated(count)),
        );
  }


  Stream<AddPhotoState> _mapEditingPhotoToCompletePost(
      EditingPhoto event) async* {
    try {
      _httpPostPhoto.editPhoto(event.photo, event.name, event.description);
      await _firestoreRepository.createPhoto(event.photo, event.tags);
      yield CompletePost();
    } on DioError {
      yield ErrorPostPhoto('Lost internet connection');
    }
  }

  Stream<AddPhotoState> _mapEditingPhotoToDeletePhoto(
      DeletingPhoto event) async* {
    try {
      await _httpPostPhoto.deletePhoto(event.photo);
      yield DeletePhoto();
    } on DioError {
      yield ErrorPostPhoto('Lost internet connection');
    }
  }

  Stream<AddPhotoState> _mapPostPhotoToCompletePost(PostPhoto event) async* {
    try {
      yield LoadingPostPhoto();
      photo =
          await _httpPostPhoto.postPhoto(file: event.file, name: event.name);
      await _firestoreRepository.createPhoto(photo, event.tags);
      yield CompletePost();
    } on DioError {
      yield ErrorPostPhoto('Lost internet connection');
    }
  }
}
