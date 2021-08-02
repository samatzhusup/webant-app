part of 'add_photo_bloc.dart';

@immutable
abstract class AddPhotoEvent {}

class PostPhoto extends AddPhotoEvent {
  final String name;
  final String description;
  final File file;
  final List<String> tags;

  PostPhoto({this.name, this.description, this.file, this.tags});
}

class DeletingPhoto extends AddPhotoEvent {
  final PhotoModel photo;

  DeletingPhoto(this.photo);
}

class EditingPhoto extends AddPhotoEvent {
  final PhotoModel photo;
  final String name;
  final String description;
  final List<String> tags;

  EditingPhoto({this.photo, this.name, this.description, this.tags});
}

class ViewsCounter extends AddPhotoEvent {
  final PhotoModel photo;

  ViewsCounter(this.photo);
}

class CountUpdated extends AddPhotoEvent {
  final count;

  CountUpdated(this.count);
}

class InitialEvent extends AddPhotoEvent {}

