// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome!`
  String get welcomeTitle {
    return Intl.message(
      'Welcome!',
      name: 'welcomeTitle',
      desc: '',
      args: [],
    );
  }

  /// `WebAnt Gallery`
  String get galleryTitle {
    return Intl.message(
      'WebAnt Gallery',
      name: 'galleryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Create an account`
  String get buttonCreateAccount {
    return Intl.message(
      'Create an account',
      name: 'buttonCreateAccount',
      desc: '',
      args: [],
    );
  }

  /// `I already have an account`
  String get buttonAlreadyHaveAccount {
    return Intl.message(
      'I already have an account',
      name: 'buttonAlreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get buttonSignIn {
    return Intl.message(
      'Sign in',
      name: 'buttonSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get buttonSignUp {
    return Intl.message(
      'Sign up',
      name: 'buttonSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Please enter email`
  String get errorEmptyEmail {
    return Intl.message(
      'Please enter email',
      name: 'errorEmptyEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter username`
  String get errorEmptyUserName {
    return Intl.message(
      'Please enter username',
      name: 'errorEmptyUserName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter password`
  String get errorEmptyPassword {
    return Intl.message(
      'Please enter password',
      name: 'errorEmptyPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a phone number`
  String get errorEmptyPhone {
    return Intl.message(
      'Please enter a phone number',
      name: 'errorEmptyPhone',
      desc: '',
      args: [],
    );
  }

  /// `Phone number is too short`
  String get errorShortPhone {
    return Intl.message(
      'Phone number is too short',
      name: 'errorShortPhone',
      desc: '',
      args: [],
    );
  }

  /// `Please enter correct email`
  String get errorIncorrectEmail {
    return Intl.message(
      'Please enter correct email',
      name: 'errorIncorrectEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least eight characters`
  String get errorShortPassword {
    return Intl.message(
      'Password must contain at least eight characters',
      name: 'errorShortPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one uppercase letter`
  String get errorUppercaseLetter {
    return Intl.message(
      'Password must contain at least one uppercase letter',
      name: 'errorUppercaseLetter',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your password`
  String get errorEmptyConfirmPassword {
    return Intl.message(
      'Please confirm your password',
      name: 'errorEmptyConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Passwords don't match`
  String get errorPasswordDoNotMatch {
    return Intl.message(
      'Passwords don\'t match',
      name: 'errorPasswordDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get labelPassword {
    return Intl.message(
      'Password',
      name: 'labelPassword',
      desc: '',
      args: [],
    );
  }

  /// `Old password`
  String get labelOldPassword {
    return Intl.message(
      'Old password',
      name: 'labelOldPassword',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get labelNewPassword {
    return Intl.message(
      'New password',
      name: 'labelNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm your password`
  String get labelConfirmPassword {
    return Intl.message(
      'Confirm your password',
      name: 'labelConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get labelEmail {
    return Intl.message(
      'Email',
      name: 'labelEmail',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get labelPhone {
    return Intl.message(
      'Phone',
      name: 'labelPhone',
      desc: '',
      args: [],
    );
  }

  /// `Birthday`
  String get labelBirthday {
    return Intl.message(
      'Birthday',
      name: 'labelBirthday',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get labelUsername {
    return Intl.message(
      'Username',
      name: 'labelUsername',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get hintSearch {
    return Intl.message(
      'Search',
      name: 'hintSearch',
      desc: '',
      args: [],
    );
  }

  /// `Search by photo name`
  String get tabBarTitleSearch {
    return Intl.message(
      'Search by photo name',
      name: 'tabBarTitleSearch',
      desc: '',
      args: [],
    );
  }

  /// `You must be over 18`
  String get errorAgeDisclaimer {
    return Intl.message(
      'You must be over 18',
      name: 'errorAgeDisclaimer',
      desc: '',
      args: [],
    );
  }

  /// `Forgot login or password?`
  String get buttonForgotPassword {
    return Intl.message(
      'Forgot login or password?',
      name: 'buttonForgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get tabBarTitleNew {
    return Intl.message(
      'New',
      name: 'tabBarTitleNew',
      desc: '',
      args: [],
    );
  }

  /// `Popular`
  String get tabBarTitlePopular {
    return Intl.message(
      'Popular',
      name: 'tabBarTitlePopular',
      desc: '',
      args: [],
    );
  }

  /// `Personal data`
  String get titlePersonalData {
    return Intl.message(
      'Personal data',
      name: 'titlePersonalData',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get labelHome {
    return Intl.message(
      'Home',
      name: 'labelHome',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get labelCamera {
    return Intl.message(
      'Camera',
      name: 'labelCamera',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get labelGallery {
    return Intl.message(
      'Gallery',
      name: 'labelGallery',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get labelProfile {
    return Intl.message(
      'Profile',
      name: 'labelProfile',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get labelLoadingIndicator {
    return Intl.message(
      'Loading...',
      name: 'labelLoadingIndicator',
      desc: '',
      args: [],
    );
  }

  /// `No internet`
  String get errorNoInternet {
    return Intl.message(
      'No internet',
      name: 'errorNoInternet',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Edit photo`
  String get actionSheetEditPhoto {
    return Intl.message(
      'Edit photo',
      name: 'actionSheetEditPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Delete photo`
  String get actionSheetDeletePhoto {
    return Intl.message(
      'Delete photo',
      name: 'actionSheetDeletePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Photo has been deleted`
  String get msgDeletedPhoto {
    return Intl.message(
      'Photo has been deleted',
      name: 'msgDeletedPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Delete account`
  String get alertDialogDeleteAccount {
    return Intl.message(
      'Delete account',
      name: 'alertDialogDeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Would you like to delete your account?`
  String get confirmDeleteAccount {
    return Intl.message(
      'Would you like to delete your account?',
      name: 'confirmDeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Would you like to sign out?`
  String get confirmSignOut {
    return Intl.message(
      'Would you like to sign out?',
      name: 'confirmSignOut',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Sign out`
  String get alertDialogSignOut {
    return Intl.message(
      'Sign out',
      name: 'alertDialogSignOut',
      desc: '',
      args: [],
    );
  }

  /// `Sorry!`
  String get errorSorry {
    return Intl.message(
      'Sorry!',
      name: 'errorSorry',
      desc: '',
      args: [],
    );
  }

  /// `There is no internet connection.`
  String get errorLostInternetConnection {
    return Intl.message(
      'There is no internet connection.',
      name: 'errorLostInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Views: `
  String get countOfViews {
    return Intl.message(
      'Views: ',
      name: 'countOfViews',
      desc: '',
      args: [],
    );
  }

  /// `Loaded: `
  String get countOfLoaded {
    return Intl.message(
      'Loaded: ',
      name: 'countOfLoaded',
      desc: '',
      args: [],
    );
  }

  /// `User profile has been updated`
  String get msgProfileUpdated {
    return Intl.message(
      'User profile has been updated',
      name: 'msgProfileUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Upload photo`
  String get buttonUploadPhoto {
    return Intl.message(
      'Upload photo',
      name: 'buttonUploadPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Select a photo`
  String get buttonSelectPhoto {
    return Intl.message(
      'Select a photo',
      name: 'buttonSelectPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get buttonNext {
    return Intl.message(
      'Next',
      name: 'buttonNext',
      desc: '',
      args: [],
    );
  }

  /// `You can`
  String get textYouCan {
    return Intl.message(
      'You can',
      name: 'textYouCan',
      desc: '',
      args: [],
    );
  }

  /// `delete your account`
  String get textDeleteAccount {
    return Intl.message(
      'delete your account',
      name: 'textDeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Nothing to update`
  String get msgNothingToUpdate {
    return Intl.message(
      'Nothing to update',
      name: 'msgNothingToUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Invalid date`
  String get errorInvalidDate {
    return Intl.message(
      'Invalid date',
      name: 'errorInvalidDate',
      desc: '',
      args: [],
    );
  }

  /// `You are too old`
  String get errorDateTooOld {
    return Intl.message(
      'You are too old',
      name: 'errorDateTooOld',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `No image selected`
  String get errorNoImage {
    return Intl.message(
      'No image selected',
      name: 'errorNoImage',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get buttonSave {
    return Intl.message(
      'Save',
      name: 'buttonSave',
      desc: '',
      args: [],
    );
  }

  /// `Publication has been moderated`
  String get msgPhotoModerated {
    return Intl.message(
      'Publication has been moderated',
      name: 'msgPhotoModerated',
      desc: '',
      args: [],
    );
  }

  /// `Please input name`
  String get errorEmptyPhotoName {
    return Intl.message(
      'Please input name',
      name: 'errorEmptyPhotoName',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get labelDescription {
    return Intl.message(
      'Description',
      name: 'labelDescription',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get labelPhotoName {
    return Intl.message(
      'Name',
      name: 'labelPhotoName',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get buttonAddPhoto {
    return Intl.message(
      'Add',
      name: 'buttonAddPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get buttonEditPhoto {
    return Intl.message(
      'Edit',
      name: 'buttonEditPhoto',
      desc: '',
      args: [],
    );
  }

  /// `There is no pictures. \nPlease come back later.`
  String get errorLoadedPhoto {
    return Intl.message(
      'There is no pictures. \nPlease come back later.',
      name: 'errorLoadedPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Image not found`
  String get errorFoundImage {
    return Intl.message(
      'Image not found',
      name: 'errorFoundImage',
      desc: '',
      args: [],
    );
  }

  /// `Photo`
  String get titleCamera {
    return Intl.message(
      'Photo',
      name: 'titleCamera',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get bottomSheetCamera {
    return Intl.message(
      'Camera',
      name: 'bottomSheetCamera',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get bottomSheetGallery {
    return Intl.message(
      'Gallery',
      name: 'bottomSheetGallery',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}