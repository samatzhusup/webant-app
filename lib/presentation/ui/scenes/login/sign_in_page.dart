import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:webant/domain/usecases/validation.dart';
import 'package:webant/generated/l10n.dart';
import 'package:webant/presentation/resources/app_colors.dart';
import 'package:webant/presentation/resources/app_styles.dart';
import 'package:webant/presentation/ui/scenes/gallery/main/gallery.dart';
import 'package:webant/presentation/ui/scenes/login/enter_page.dart';
import 'package:webant/presentation/ui/scenes/widgets/password_inputs.dart';
import 'package:webant/presentation/ui/scenes/widgets/user_text_fields.dart';
import 'package:webant/presentation/ui/scenes/widgets/widget_app_bar.dart';

import 'authorization_bloc/authorization_bloc.dart';
import 'sign_up_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  final double _heightFields = 36.0;
  final double _widthButton = 150.0;
  TextEditingController _nameController;
  TextEditingController _passwordController;
  bool _buttonColor = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
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
          appBar: AppBarSign(),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Text(S.of(context).buttonSignIn, style: AppStyles.styleSign),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: TextFormFields(
                      controller: _nameController,
                      label: S.of(context).labelUsername,
                      typeField: typeTextField.USERNAME,
                      textInputType: TextInputType.name,
                      node: node,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 29),
                    child: PasswordInputs(
                      typeField: typePasswordField.OLD_PASSWORD,
                      controller: _passwordController,
                      label: S.of(context).labelPassword,
                      node: node,
                      callBack: addLoginEvent,
                      validation: Validation(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: TextButton(
                        child: Text(
                          S.of(context).buttonForgotPassword,
                          style: TextStyle(color: AppColors.mainColorAccent),
                        ),
                        onPressed: () {},
                        style: ButtonStyle(splashFactory: NoSplash.splashFactory),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      //sign in
                      padding: EdgeInsets.only(top: 50),
                      child: SizedBox(
                        height: _heightFields,
                        width: _widthButton,
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
                            addLoginEvent();
                          },
                          child: signIn(),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      //sign up
                      padding: EdgeInsets.only(top: 10),
                      child: SizedBox(
                        height: _heightFields,
                        width: _widthButton,
                        child: TextButton(
                          style:
                              ButtonStyle(splashFactory: NoSplash.splashFactory),
                          onPressed: signup, //to SignUpPage
                          child: Text(
                            S.of(context).buttonSignUp,
                            style: AppStyles.signUpButtonSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addLoginEvent() {
    if (_formKey.currentState.validate()) {
      context
          .read<AuthorizationBloc>()
          .add(SignInEvent(_nameController.text, _passwordController.text));
    }
  }

  Widget signIn() {
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
        S.of(context).buttonSignIn,
        style: AppStyles.signInButtonMain,
      );
    });
  }

  void signup() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SignUpPage(),
      ),
    );
  }
}
