part of 'search_photo_bloc.dart';

@immutable
abstract class SearchPhotoState {}

class SearchPhotoInitial extends SearchPhotoState {}

class Loading extends SearchPhotoState {}

class NotFound extends SearchPhotoState {}

class Search extends SearchPhotoState {
  final List<PhotoModel> photos;
  final bool isLastPage;

  Search(this.photos, this.isLastPage);
}

class InternetError extends SearchPhotoState {}
