import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:webant/data/repositories/http_oauth_gateway.dart';
import 'package:webant/data/repositories/http_user_gateway.dart';
import 'package:webant/presentation/ui/scenes/gallery/add_photo/add_photo_bloc/add_photo_bloc.dart';
import 'package:webant/presentation/ui/scenes/login/authorization_bloc/authorization_bloc.dart';
import 'package:webant/presentation/ui/scenes/login/welcome_screen.dart';
import 'package:webant/presentation/ui/scenes/user_profile/firestore_bloc/firestore_bloc.dart';
import 'package:webant/presentation/ui/scenes/user_profile/user_bloc/user_bloc.dart';
import 'data/repositories/firesrore_repository.dart';
import 'data/repositories/http_post_photo.dart';
import 'domain/models/photos_model/image_model.dart';
import 'domain/models/photos_model/photo_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  UserBloc userBloc =
      UserBloc(HttpOauthGateway(), HttpUserGateway(), FirebaseFirestoreRepository());
  var path = Directory.systemTemp.path;
  Hive
    ..init(path)
    ..registerAdapter(ImageModelAdapter())
    ..registerAdapter(PhotoModelAdapter());
  await Hive.openBox('new');
  await Hive.openBox('popular');
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runZonedGuarded(() {
    runApp(MultiBlocProvider(providers: [
      BlocProvider(
          create: (BuildContext context) =>
              AuthorizationBloc(HttpOauthGateway(), HttpUserGateway(), userBloc)
                ..add(LoginFetch())),
      BlocProvider(
          create: (BuildContext context) => AddPhotoBloc(HttpPostPhoto(),
              firestoreRepository: FirebaseFirestoreRepository())),
      BlocProvider(create: (BuildContext context) => userBloc),
      BlocProvider(
        create: (context) => FirestoreBloc(
            HttpUserGateway(),
            firestoreRepository: FirebaseFirestoreRepository()),
      ),
    ], child: WelcomeScreen()));
  }, (error, stackTrace) {});
}
