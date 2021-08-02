import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:webant/domain/usecases/validation.dart';
import 'package:webant/generated/l10n.dart';
import 'package:webant/presentation/resources/app_colors.dart';
import 'package:webant/presentation/resources/app_strings.dart';
import 'package:webant/presentation/resources/app_styles.dart';
import 'package:webant/presentation/ui/scenes/gallery/main/gallery.dart';
import 'package:webant/presentation/ui/scenes/login/enter_page.dart';
import 'package:webant/presentation/ui/scenes/widgets/password_inputs.dart';
import 'package:webant/presentation/ui/scenes/widgets/user_text_fields.dart';
import 'package:webant/presentation/ui/scenes/widgets/widget_app_bar.dart';

import 'authorization_bloc/authorization_bloc.dart';
import 'sign_in_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController;
  TextEditingController _birthdayController;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _phoneController;
  TextEditingController _confirmPasswordController;
  bool _buttonColor;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _birthdayController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _phoneController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _buttonColor = true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthdayController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return BlocConsumer<AuthorizationBloc, AuthorizationState>(
      listener: (context, state) {
        if (state is ErrorAuthorization) {
          setState(() => _buttonColor = true);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.err),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.colorWhite,
          resizeToAvoidBottomInset: true,
          appBar: AppBarSign(),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 75),
                      child: Text(S.of(context).buttonSignUp, style: AppStyles.styleSign),
                    ),
                  ),
                  Padding(
                    //user name
                    padding: const EdgeInsets.only(top: 40),
                    child: TextFormFields(
                      controller: _nameController,
                      label: S.of(context).labelUsername,
                      typeField: typeTextField.USERNAME,
                      textInputType: TextInputType.name,
                      node: node,
                    ),
                  ),
                  Padding(
                    //birthday
                    padding: const EdgeInsets.only(top: 29),
                    child: TextFormFields(
                      controller: _birthdayController,
                      label: S.of(context).labelBirthday,
                      typeField: typeTextField.BIRTHDAY,
                      textInputType: TextInputType.number,
                      textInputFormatter: <TextInputFormatter>[
                        MaskTextInputFormatter(
                            mask: (AppStrings.dateMask),
                            filter: {"#": RegExp(r'[0-9]')})
                      ],
                      node: node,
                    ),
                  ),
                  Padding(
                    //email
                    padding: EdgeInsets.only(top: 29),
                    child: TextFormFields(
                      controller: _emailController,
                      label: S.of(context).labelEmail,
                      typeField: typeTextField.EMAIL,
                      textInputType: TextInputType.emailAddress,
                      node: node,
                    ),
                  ),
                  Padding(
                    //password
                    padding: EdgeInsets.only(top: 29),
                    child: PasswordInputs(
                      typeField: typePasswordField.NEW_PASSWORD,
                      controller: _passwordController,
                      label: S.of(context).labelPassword,
                      node: node,
                      validation: Validation(),
                    ),
                  ),
                  Padding(
                    //confirm password
                    padding: EdgeInsets.only(top: 29),
                    child: PasswordInputs(
                      typeField: typePasswordField.CONFIRM_PASSWORD,
                      controller: _confirmPasswordController,
                      label: S.of(context).labelConfirmPassword,
                      node: node,
                      confirmPassword: _passwordController,
                      callBack: addSignUpEvent,
                      validation: Validation(),
                    ),
                  ),
                  Center(
                    child: Padding(
                      //sign up
                      padding: EdgeInsets.only(top: 29),
                      child: SizedBox(
                        height: 36,
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shadowColor: AppColors.colorWhite,
                            splashFactory: NoSplash.splashFactory,
                            primary:
                                _buttonColor ? AppColors.mainColor : Colors.white,
                          ),
                          onPressed: () {
                            node.unfocus();
                            addSignUpEvent();
                          },
                          child: signUp(),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      //sign in
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        height: 36,
                        width: 150,
                        child: TextButton(
                          style:
                              ButtonStyle(splashFactory: NoSplash.splashFactory),
                          onPressed: signIn, //to SignInPage
                          child: Text(
                            S.of(context).buttonSignIn,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: AppColors.mainColor),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addSignUpEvent() {
    if (_formKey.currentState.validate()) {
      context.read<AuthorizationBloc>().add(
            SignUpEvent(
              name: _nameController.text,
              password: _passwordController.text,
              email: _emailController.text,
              birthday: _birthdayController.text.isNotEmpty
                  ? _birthdayController.text
                  : DateTime.now().toString(),
            ),
          );
    }
  }

  Widget signUp() {
    return BlocBuilder<AuthorizationBloc, AuthorizationState>(
        builder: (context, state) {
      if (state is LoadingAuthorization) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() => _buttonColor = false);
        });
        return CircularProgressIndicator(
          color: AppColors.mainColorAccent,
        );
      }
      if (state is AccessAuthorization) {
        context.read<AuthorizationBloc>().add(LoginFetch());
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Gallery(),
            ),
          );
        });
      }
      return Text(
        S.of(context).buttonSignUp,
        style: AppStyles.signInButtonMain,
      );
    });
  }

  void signIn() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SignInPage(),
      ),
    );
  }
}
