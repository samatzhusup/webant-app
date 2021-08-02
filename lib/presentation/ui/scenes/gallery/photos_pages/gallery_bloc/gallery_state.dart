part of 'gallery_bloc.dart';

@immutable
abstract class GalleryState {}

// ignore: must_be_immutable
class GalleryInitial extends GalleryState {}

class GalleryData extends GalleryState {
  final bool isLoading;
  final bool isLastPage;
  final Box photosBox;

  GalleryData({this.isLoading, this.isLastPage, this.photosBox});
}

class GalleryLoaded extends GalleryState {}

class GalleryError extends GalleryState {}

class GalleryInternetLost extends GalleryState {}

