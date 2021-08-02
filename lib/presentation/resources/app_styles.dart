import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webant/presentation/resources/app_colors.dart';

class AppStyles {
  static ButtonStyle styleButtonAlreadyHaveAccount = ElevatedButton.styleFrom(
      primary: AppColors.colorWhite,
      side: BorderSide(color: AppColors.mainColor));

  static ButtonStyle styleButtonCreateAccount =
      ElevatedButton.styleFrom(primary: AppColors.mainColor);


  static const TextStyle styleSign = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    shadows: [Shadow(color: Colors.black, offset: Offset(0, -7))],
    color: Colors.transparent,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.decorationColor,
    decorationThickness: 2,
  );

  static OutlineInputBorder borderTextField = OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.mainColorAccent, width: 1.0),
  );

  static OutlineInputBorder borderTextFieldError = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 1.0),
  );
  static const Icon iconMail = Icon(
    Icons.mail_outline,
    color: AppColors.mainColorAccent,
  );

  static List<TextInputFormatter> noSpace = <TextInputFormatter>[
    FilteringTextInputFormatter.deny(RegExp("[ ]")),
  ];
  static List<TextInputFormatter> noNumbers = <TextInputFormatter>[
    FilteringTextInputFormatter.deny(RegExp(r'1-3')),
  ];

  static const TextStyle signInButtonMain = TextStyle(
      color: AppColors.colorWhite, fontSize: 17, fontWeight: FontWeight.w700);

  static const TextStyle signUpButtonSecondary = TextStyle(
      fontSize: 17, fontWeight: FontWeight.w400, color: AppColors.mainColor);
}
