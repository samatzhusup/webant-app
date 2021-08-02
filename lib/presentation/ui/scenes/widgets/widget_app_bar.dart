import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webant/generated/l10n.dart';
import 'package:webant/presentation/resources/app_colors.dart';

class AppBarSign extends StatelessWidget implements PreferredSizeWidget {
  const AppBarSign({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              S.of(context).cancel,
              style: TextStyle(color: AppColors.mainColor),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.colorWhite,
      elevation: 1,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
