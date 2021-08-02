import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as Storage;
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:webant/data/repositories/http_photo_gateway.dart';
import 'package:webant/domain/models/base_model/base_model.dart';
import 'package:webant/domain/models/user/user_model.dart';
import 'package:webant/domain/repositories/firestore_repository.dart';
import 'package:webant/domain/repositories/oauth_gateway.dart';
import 'package:webant/domain/repositories/photo_gateway.dart';
import 'package:webant/domain/repositories/user_gateway.dart';
import 'package:webant/presentation/ui/scenes/gallery/main/new_or_popular_photos.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc<T> extends Bloc<UserEvent, UserState> {
  UserBloc(this._oauthGateway, this._userGateway, this._firestoreRepository)
      : super(UserInitial());
  final _storage = Storage.FlutterSecureStorage();
  final UserGateway _userGateway;
  final OauthGateway _oauthGateway;
  final FirestoreRepository _firestoreRepository;
  StreamSubscription _countUserSubscription;
  PhotoGateway _photoGateway = HttpPhotoGateway(type: typePhoto.SEARCH_BY_USER);
  UserModel _user;
  BaseModel<T> _baseModel;
  bool _isUpdate = false;
  var userData;

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UserFetch) {
      yield* _mapUserFetchToUserData(event);
    }
    if (event is UpdateUser) {
      yield* _mapUpdateUserToUserFetch(event);
    }
    if (event is UpdatePassword) {
      yield* _mapUpdatePasswordToUserFetch(event);
    }
    if (event is LogOut) {
      yield* _mapLogOutToExit(event);
    }
    if (event is UserDelete) {
      _mapUserDeleteToExit(event);
    }
    if (event is CountOfViews) {
      yield userData.copyWith(countOfViews: event.count);
    }
  }

  Stream<UserState> _mapUserFetchToUserData(UserFetch event) async* {
    try {
      yield LoadingUpdate();
      _user = await _oauthGateway.getUser();
      _baseModel =
          await _photoGateway.fetchPhotos(page: 1, queryText: _user.id);
      int countOfPhotos = _baseModel.totalItems;
      userData = UserData(
          user: _user, countOfPhotos: countOfPhotos, isUpdate: _isUpdate);
      yield userData;
      _isUpdate = false;
      _countUserSubscription?.cancel();
      _countUserSubscription =
          _firestoreRepository.getViewsCountOfUserPhoto(_user).listen(
                (count) => add(CountOfViews(count)),
              );
    } on DioError catch (err) {
      if (err?.response?.statusCode == 401) add(LogOut());
      else yield ErrorData();
    }
  }

  Stream<UserState> _mapUpdateUserToUserFetch(UpdateUser event) async* {
    try {
      yield LoadingUpdate();
      await _userGateway.updateUser(event.user);
      _isUpdate = true;
      add(UserFetch());
    } on DioError catch (err) {
      if (err.type == DioErrorType.other)
        yield ErrorData();
      else
        yield ErrorUpdate('error');
    }
  }

  Stream<UserState> _mapUpdatePasswordToUserFetch(UpdatePassword event) async* {
    try {
      yield LoadingUpdate();
      await _userGateway.updatePasswordUser(
          event.user, event.oldPassword, event.newPassword);
      _isUpdate = true;
      add(UserFetch());
    } on DioError catch (err) {
      _isUpdate = false;
      if (err?.response?.statusCode == 400) {
        yield ErrorUpdate(jsonDecode(err?.response?.data)['detail']);
      } else {
        yield ErrorUpdate('error');
      }
      add(UserFetch());
    }
  }

  Stream<UserState> _mapUserDeleteToExit(UserDelete event) async* {
    yield LoadingUpdate();
    await _storage.deleteAll();
    Hive.box('new').clear();
    Hive.box('popular').clear();
    await _userGateway.deleteUser(event.user);
    yield Exit();
  }

  Stream<UserState> _mapLogOutToExit(LogOut event) async* {
    yield LoadingUpdate();
    await _storage.deleteAll();
    Hive.box('new').clear();
    Hive.box('popular').clear();
    yield Exit();
  }
}
