import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:webant/domain/models/photos_model/photo_model.dart';
import 'package:webant/domain/repositories/firestore_repository.dart';
import 'package:webant/domain/repositories/oauth_gateway.dart';
import 'package:webant/domain/repositories/user_gateway.dart';

part 'firestore_event.dart';
part 'firestore_state.dart';

class FirestoreBloc extends Bloc<FirestoreEvent, FirestoreState> {
  final FirestoreRepository _firestoreRepository;
  final UserGateway _userGateway;

  FirestoreBloc(this._userGateway,
      {OauthGateway oauthGateway, FirestoreRepository firestoreRepository})
      : _firestoreRepository = firestoreRepository,
        super(FirestoreInitial());

  @override
  Stream<FirestoreState> mapEventToState(
    FirestoreEvent event,
  ) async* {
    if (event is GetTags) {
      yield ShowTags([], '');
      String userName;
      if (event.photo.user != null) {
        userName = await _userGateway.getUserName(event.photo.user);
      }
      List<dynamic> tags = await _firestoreRepository.getTags(event.photo);
      yield ShowTags(tags, userName);
    }
  }
}
