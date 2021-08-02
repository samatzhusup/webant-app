part of 'gallery_bloc.dart';

@immutable
abstract class GalleryEvent {}

class GalleryFetch extends GalleryEvent {}

class GallerySearch extends GalleryEvent {}

class GalleryRefresh extends GalleryEvent {}

class GalleryLoading extends GalleryEvent {}
