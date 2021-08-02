import 'package:flutter/cupertino.dart';
import 'package:webant/generated/l10n.dart';
import 'package:webant/presentation/ui/scenes/login/enter_page.dart';

class UpdateValidation {
  String selectPasswordValidator(BuildContext context,
      String value, typePasswordField typeField, TextEditingController confirmPassword) {
    switch (typeField) {
      case typePasswordField.NEW_PASSWORD:
        if (value.isNotEmpty) {
          if (value.length < 8) {
            return S.of(context).errorShortPassword;
          } else if (!value.contains(RegExp('[A-Z]'))) {
            return S.of(context).errorUppercaseLetter;
          }
        }
        return null;
        break;
      case typePasswordField.CONFIRM_PASSWORD:
        if (confirmPassword.text.isNotEmpty) {
          if (value != confirmPassword.text) {
            return S.of(context).errorPasswordDoNotMatch;
          } else
            return null;
        }
        return null;
        break;
      case typePasswordField.OLD_PASSWORD:
        return null;
        break;
    }
    return null;
  }
}
