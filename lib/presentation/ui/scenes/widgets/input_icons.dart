import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webant/presentation/gallery_icons_icons.dart';
import 'package:webant/presentation/resources/app_colors.dart';
import 'package:webant/presentation/ui/scenes/login/enter_page.dart';

class InputIcons extends StatelessWidget {
  const InputIcons({Key key, this.typeField, this.passwordVisible})
      : super(key: key);
  final typeTextField typeField;
  final bool passwordVisible;

  @override
  Widget build(BuildContext context) {
    switch (typeField) {
      case typeTextField.EMAIL:
        return Icon(
          GalleryIcons.email,
          color: AppColors.mainColorAccent,
          size: 16
        );
        break;
      case typeTextField.USERNAME:
        return Icon(
          GalleryIcons.user,
          color: AppColors.mainColorAccent,
        );
        break;
      case typeTextField.BIRTHDAY:
        return Icon(
          GalleryIcons.calendar,
          color: AppColors.mainColorAccent,
        );
    }
    return null;
  }
}