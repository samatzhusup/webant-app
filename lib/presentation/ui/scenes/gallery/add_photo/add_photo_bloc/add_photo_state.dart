part of 'add_photo_bloc.dart';

@immutable
abstract class AddPhotoState {}

class AddPhotoInitial extends AddPhotoState {}

class ErrorPostPhoto extends AddPhotoState {
  final String err;

  ErrorPostPhoto(this.err);
}

class LoadingPostPhoto extends AddPhotoState {}

class CompletePost extends AddPhotoState {}

class DeletePhoto extends AddPhotoState {
  final int index;

  DeletePhoto({this.index});
}

class CountOfViews extends AddPhotoState {
  final count;

  CountOfViews(this.count);
}

