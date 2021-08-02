import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:webant/generated/l10n.dart';
import 'package:webant/presentation/resources/app_colors.dart';
import 'package:webant/presentation/ui/scenes/gallery/main/gallery.dart';
import 'package:webant/presentation/ui/scenes/widgets/loading_circular.dart';
import 'authorization_bloc/authorization_bloc.dart';
import 'enter_page.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        accentColor: AppColors.colorGreyAccent,
      ),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: 'WebAnt Gallery',
      home: BlocBuilder<AuthorizationBloc, AuthorizationState>(
        builder: (context, state) {
          if (state is LoginData) {
            if (state.isLoading) {
              return Scaffold(
                body: LoadingCircular(),
              );
            }
            if (state.isLogin) {
              return Gallery();
            }
            if (!state.isLogin) {
              return EnterPage();
            }
          }
          if (state is AuthorizationInitial) {
            return Scaffold(
              body: LoadingCircular(),
            );
          }
          return Container();
        },
      ),
    );
  }
}
