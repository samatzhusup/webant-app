import 'package:flutter/cupertino.dart';
import 'package:webant/generated/l10n.dart';
import 'package:webant/presentation/ui/scenes/login/enter_page.dart';

import 'date_formatter.dart';

class Validation {
  DateFormatter dateFormatter = DateFormatter();
  String confirmPassword;

  String selectUserValidator(
      {BuildContext context,
      String value,
      typeTextField typeField,
      String confirmPassword}) {
    switch (typeField) {
      case typeTextField.USERNAME:
        if (value == null || value.isEmpty) {
          return S.of(context).errorEmptyUserName;
        }
        return null;
        break;
      case typeTextField.EMAIL:
        if (value == null || value.isEmpty) {
          return S.of(context).errorEmptyEmail;
        } else if (!value.contains('@') ||
            value.length < 3 ||
            !value.contains('.')) {
          return S.of(context).errorIncorrectEmail;
        }
        return null;
        break;
      case typeTextField.BIRTHDAY:
        try {
          if (value == null || value.isNotEmpty && value.length <= 10) {
            DateTime birthday = dateFormatter.toDate(value);
            DateTime today = DateTime.now();
            int yearDiff = today.year - birthday.year;
            DateTime adultDate = DateTime(
              birthday.year + 18,
              birthday.month,
              birthday.day,
            );
            if (adultDate.isAfter(today)) {
              return S.of(context).errorAgeDisclaimer;
            } else if (yearDiff > 100) {
              return S.of(context).errorDateTooOld;
            }
          }
        } catch (e) {
          return S.of(context).errorInvalidDate;
        }
        return null;
        break;
    }
    return S.of(context).error;
  }

  String selectPasswordValidator(BuildContext context, String value,
      typePasswordField typeField, TextEditingController confirmPassword) {
    switch (typeField) {
      case typePasswordField.OLD_PASSWORD:
        if (value == null || value.isEmpty) {
          return S.of(context).errorEmptyPassword;
        }
        return null;
        break;
      case typePasswordField.NEW_PASSWORD:
        if (value == null || value.isEmpty) {
          return S.of(context).errorEmptyPassword;
        } else if (value.length < 8) {
          return S.of(context).errorShortPassword;
        } else if (!value.contains(RegExp('[A-Z]'))) {
          return S.of(context).errorUppercaseLetter;
        }
        return null;
        break;
      case typePasswordField.CONFIRM_PASSWORD:
        if (value == null || value.isEmpty) {
          return S.of(context).errorEmptyPassword;
        } else if (value != confirmPassword.text) {
          return S.of(context).errorPasswordDoNotMatch;
        }
        return null;
        break;
    }
    return null;
  }
}
