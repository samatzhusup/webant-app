import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webant/generated/l10n.dart';
import 'package:webant/presentation/resources/app_colors.dart';

class LoadingCircular extends StatelessWidget {
  const LoadingCircular({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              color: AppColors.mainColorAccent,
              strokeWidth: 2.0,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                S.of(context).labelLoadingIndicator,
                style: TextStyle(color: AppColors.mainColorAccent),
              ),
            ),
          ],
      ),
    );
  }
}
