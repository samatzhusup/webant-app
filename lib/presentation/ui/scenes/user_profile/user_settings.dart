import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:webant/domain/models/user/user_model.dart';
import 'package:webant/domain/usecases/date_formatter.dart';
import 'package:webant/domain/usecases/update_validation.dart';
import 'package:webant/generated/l10n.dart';
import 'package:webant/presentation/resources/app_colors.dart';
import 'package:webant/presentation/resources/app_strings.dart';
import 'package:webant/presentation/ui/scenes/login/enter_page.dart';
import 'package:webant/presentation/ui/scenes/user_profile/sign_out_dialog.dart';
import 'package:webant/presentation/ui/scenes/user_profile/user_bloc/user_bloc.dart';
import 'package:webant/presentation/ui/scenes/widgets/back_widget.dart';
import 'package:webant/presentation/ui/scenes/widgets/loading_circular.dart';
import 'package:webant/presentation/ui/scenes/widgets/password_inputs.dart';
import 'package:webant/presentation/ui/scenes/widgets/user_text_fields.dart';

import '../widgets/choose_photo_bottom_sheet.dart';
import 'delete_account_dialog.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({Key key}) : super(key: key);

  @override
  _UserSettingsState createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  final _formUserKey = GlobalKey<FormState>();
  final _formPasswordKey = GlobalKey<FormState>();
  File _image;
  final _picker = ImagePicker();
  TextEditingController _nameController;
  TextEditingController _birthdayController;
  TextEditingController _emailController;
  TextEditingController _oldPasswordController;
  TextEditingController _newPasswordController;
  TextEditingController _confirmPasswordController;
  UserModel _user;
  DateFormatter _dateFormatter;
  Completer<void> _reFresh;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _birthdayController = TextEditingController();
    _emailController = TextEditingController();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _dateFormatter = DateFormatter();
    _reFresh = Completer<void>();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthdayController.dispose();
    _emailController.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future getImage(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.colorWhite,
      appBar: AppBar(
        leadingWidth: 75,
        backgroundColor: AppColors.colorWhite,
        elevation: 1,
        leading: BackWidget(),
        actions: [
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is! ErrorData && state is! LoadingUpdate) {
                return TextButton(
                  onPressed: () => updateUser(),
                  child: Text(
                    S.of(context).buttonSave,
                    style: TextStyle(
                        color: AppColors.decorationColor,
                        fontWeight: FontWeight.w700),
                  ),
                );
              }
              return Text('');
            },
          ),
        ],
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is Exit) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => EnterPage()),
                (Route<dynamic> route) => false);
          }
          if (state is ErrorUpdate) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.err),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingUpdate) {
            return Center(
              child: LoadingCircular(),
            );
          }
          if (state is ErrorData) {
            return RefreshIndicator(
              color: AppColors.mainColorAccent,
              backgroundColor: AppColors.colorWhite,
              strokeWidth: 2.0,
              onRefresh: () async {
                context.read<UserBloc>().add(UserFetch());
                return _reFresh.future;
              },
              child: Container(
                height: double.maxFinite,
                width: double.infinity,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 200, 0, 8),
                          child: Image.asset(AppStrings.imageIntersect),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            S.of(context).errorSorry,
                            style: TextStyle(
                                fontSize: 25,
                                color: AppColors.mainColorAccent,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          S.of(context).errorLostInternetConnection,
                          style: TextStyle(color: AppColors.mainColorAccent),
                          textAlign: TextAlign.center,
                        ),
                        Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Container(
                            child: TextButton(
                              onPressed: () => showSignOutDialog(context),
                              style: ButtonStyle(
                                  splashFactory: NoSplash.splashFactory),
                              child: Text(
                                S.of(context).alertDialogSignOut,
                                style:
                                    TextStyle(color: AppColors.decorationColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          if (state is UserData) {
            _user = state.user;
            if (state.isUpdate) {
              toast(S.of(context).msgProfileUpdated);
            }
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 21),
                  child: Center(
                    child: GestureDetector(
                      onTap: () => showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) =>
                            ChoosePhotoBottomSheet(getImage),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.mainColorAccent,
                          ),
                        ),
                        child: Center(
                          child: CircleAvatar(
                            child: _image == null
                                ? Icon(Icons.camera_alt,
                                    size: 55, color: AppColors.mainColorAccent)
                                : CircleAvatar(
                                    backgroundImage: Image.file(_image).image,
                                    radius: 55,
                                    backgroundColor: AppColors.colorWhite,
                                  ),
                            radius: 50,
                            backgroundColor: AppColors.colorWhite,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: TextButton(
                    style: ButtonStyle(splashFactory: NoSplash.splashFactory),
                    onPressed: () => showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) =>
                          ChoosePhotoBottomSheet(getImage),
                    ),
                    child: Text(
                      S.of(context).buttonUploadPhoto,
                      style: TextStyle(
                        color: AppColors.mainColorAccent,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      S.of(context).titlePersonalData,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                Form(
                  key: _formUserKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        //name
                        padding: EdgeInsets.only(top: 10.0),
                        child: TextFormFields(
                          controller: _nameController..text = _user.username,
                          label: S.of(context).labelUsername,
                          typeField: typeTextField.USERNAME,
                          textInputType: TextInputType.name,
                          node: node,
                        ),
                      ),
                      Padding(
                        //birthday
                        padding: EdgeInsets.only(top: 29.0),
                        child: TextFormFields(
                          controller: _birthdayController
                            ..text = _dateFormatter.fromDate(_user.birthday),
                          label: S.of(context).labelBirthday,
                          typeField: typeTextField.BIRTHDAY,
                          textInputType: TextInputType.number,
                          node: node,
                          textInputFormatter: <TextInputFormatter>[
                            MaskTextInputFormatter(
                                mask: (AppStrings.dateMask),
                                filter: {"#": RegExp(r'[0-9]')})
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 39.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            S.of(context).labelEmail,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                      Padding(
                        //email
                        padding: EdgeInsets.only(top: 10.0),
                        child: TextFormFields(
                          controller: _emailController..text = _user.email,
                          label: S.of(context).labelEmail,
                          typeField: typeTextField.EMAIL,
                          textInputType: TextInputType.emailAddress,
                          node: node,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 39.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            S.of(context).labelPassword,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: _formPasswordKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: PasswordInputs(
                          typeField: typePasswordField.OLD_PASSWORD,
                          controller: _oldPasswordController,
                          label: S.of(context).labelOldPassword,
                          node: node,
                          validation: UpdateValidation(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 29.0),
                        child: PasswordInputs(
                          typeField: typePasswordField.NEW_PASSWORD,
                          controller: _newPasswordController,
                          label: S.of(context).labelNewPassword,
                          node: node,
                          validation: UpdateValidation(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 29.0),
                        child: PasswordInputs(
                          typeField: typePasswordField.CONFIRM_PASSWORD,
                          controller: _confirmPasswordController,
                          label: S.of(context).labelConfirmPassword,
                          confirmPassword: _newPasswordController,
                          node: node,
                          validation: UpdateValidation(),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.0, left: 6.0),
                  child: Row(
                    children: <Widget>[
                      Text(S.of(context).textYouCan),
                      TextButton(
                        onPressed: () =>
                            showDeleteAccountDialog(context, _user),
                        style:
                            ButtonStyle(splashFactory: NoSplash.splashFactory),
                        child: Text(
                          S.of(context).textDeleteAccount,
                          style: TextStyle(color: AppColors.decorationColor),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () => showSignOutDialog(context),
                    style: ButtonStyle(splashFactory: NoSplash.splashFactory),
                    child: Text(
                      S.of(context).alertDialogSignOut,
                      style: TextStyle(color: AppColors.decorationColor),
                    ),
                  ),
                ),
              ],
            );
          }
          return Text('no state');
        },
      ),
    );
  }

  Future<bool> toast(String msg) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.mainColorAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void updateUser() {
    bool nothingToUpdate = false;
    if (_emailController.text != _user.email ||
        _nameController.text != _user.username ||
        _birthdayController.text != _dateFormatter.fromDate(_user.birthday)) {
      if (_formUserKey.currentState.validate()) {
        _user = _user.copyWith(
            email: _emailController.text,
            username: _nameController.text,
            birthday: _birthdayController.text);
        context.read<UserBloc>().add(UpdateUser(user: _user));
      }
    } else {
      nothingToUpdate = true;
    }
    if (_oldPasswordController.text.isNotEmpty &&
        _newPasswordController.text.isNotEmpty) {
      nothingToUpdate = false;
      if (_formPasswordKey.currentState.validate()) {
        context.read<UserBloc>().add(UpdatePassword(
            _user, _oldPasswordController.text, _newPasswordController.text));
      }
    } else if (nothingToUpdate) {
      toast(S.of(context).msgNothingToUpdate);
    }
  }
}
