import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webant/generated/l10n.dart';
import 'package:webant/presentation/resources/app_colors.dart';
import 'package:webant/presentation/ui/scenes/user_profile/user_bloc/user_bloc.dart';

showSignOutDialog(BuildContext context) {

  Widget cancelButton = ElevatedButton(
    child: Text(S.of(context).cancel),
    style: ElevatedButton.styleFrom(
      primary: AppColors.decorationColor,
    ),
    onPressed: () => Navigator.of(context).pop(),
  );
  Widget continueButton = ElevatedButton(
    child: Text(S.of(context).yes),
    style: ElevatedButton.styleFrom(
      primary: AppColors.mainColorAccent,
    ),
    onPressed: () {
      context.read<UserBloc>().add(LogOut());
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text(S.of(context).alertDialogSignOut),
    content: Text(S.of(context).confirmSignOut),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}