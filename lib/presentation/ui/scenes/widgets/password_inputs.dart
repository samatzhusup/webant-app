import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webant/presentation/resources/app_colors.dart';
import 'package:webant/presentation/resources/app_styles.dart';
import 'package:webant/presentation/ui/scenes/login/enter_page.dart';

class PasswordInputs extends StatefulWidget {
  const PasswordInputs(
      {Key key,
      this.controller,
      this.label,
      this.typeField,
      this.callBack,
      this.node,
      this.validation,
      this.confirmPassword})
      : super(key: key);
  final TextEditingController controller;
  final String label;
  final typePasswordField typeField;
  final VoidCallback callBack;
  final node;
  final validation;
  final TextEditingController confirmPassword;

  @override
  _PasswordInputsState createState() => _PasswordInputsState();
}

class _PasswordInputsState extends State<PasswordInputs> {
  bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.mainColorAccent,
      cursorHeight: 20,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(6),
        focusedBorder: AppStyles.borderTextField
            .copyWith(borderSide: BorderSide(color: AppColors.decorationColor)),
        enabledBorder: AppStyles.borderTextField,
        focusedErrorBorder: AppStyles.borderTextField,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        labelText: widget.label,
        labelStyle: TextStyle(
          color: AppColors.mainColorAccent,
        ),
        suffixIcon: GestureDetector(
          onTap: () => setState(() => _passwordVisible = !_passwordVisible),
          child: Icon(
            _passwordVisible
                ? Icons.visibility
                : Icons.visibility_off, //hide password
            color: AppColors.mainColorAccent,
          ),
        ),
      ),
      obscureText: !_passwordVisible,
      obscuringCharacter: '*',
      validator: (value) => widget.validation.selectPasswordValidator(
          context, value, widget.typeField, widget.confirmPassword),
      textInputAction:
          widget.callBack != null ? TextInputAction.go : TextInputAction.next,
      onEditingComplete: () {
        if (widget.callBack != null) {
          widget.callBack();
          widget.node.unfocus();
        } else {
          widget.node.nextFocus();
        }
      },
    );
  }
}
