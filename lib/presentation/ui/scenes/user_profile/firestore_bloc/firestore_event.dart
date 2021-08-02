part of 'firestore_bloc.dart';

@immutable
abstract class FirestoreEvent {}
class GetTags extends FirestoreEvent{
  final PhotoModel photo;

  GetTags(this.photo);
}