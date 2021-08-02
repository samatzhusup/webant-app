import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webant/presentation/resources/app_colors.dart';

class BackWidget extends StatelessWidget {
  const BackWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
          color: AppColors.mainColor,
          iconSize: 17,
        );
      },
    );
  }
}
