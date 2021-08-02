part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class Exit extends UserState {}

class LoadingUpdate extends UserState {}

class UserData extends UserState {
  final UserModel user;
  final int countOfPhotos;
  final bool isUpdate;
  final int countOfViews;

  UserData({this.user, this.countOfPhotos, this.isUpdate, this.countOfViews});

  UserData copyWith({UserModel user, int countOfPhotos, bool isUpdate, int countOfViews}) {
    return UserData(
      user: user ?? this.user,
      countOfPhotos: countOfPhotos ?? this.countOfPhotos,
      isUpdate: isUpdate ?? this.isUpdate,
      countOfViews: countOfViews ?? this.countOfViews,
    );
  }
}

class ErrorUpdate extends UserState {
  final String err;

  ErrorUpdate(this.err);
}

class UserUpdate extends UserState {}

class ErrorData extends UserState {}
