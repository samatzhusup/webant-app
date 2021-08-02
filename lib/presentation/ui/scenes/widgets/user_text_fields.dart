import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webant/domain/usecases/validation.dart';
import 'package:webant/presentation/resources/app_colors.dart';
import 'package:webant/presentation/resources/app_styles.dart';
import 'package:webant/presentation/ui/scenes/login/enter_page.dart';

import 'input_icons.dart';

class TextFormFields extends StatefulWidget {
  const TextFormFields(
      {Key key,
      this.controller,
      this.label,
      this.typeField,
      this.textInputType,
      this.textInputFormatter,
      this.scrollController,
      this.node})
      : super(key: key);
  final TextEditingController controller;
  final ScrollController scrollController;
  final String label;
  final typeTextField typeField;
  final TextInputType textInputType;
  final List<TextInputFormatter> textInputFormatter;
  final node;

  @override
  _TextFormFieldsState createState() => _TextFormFieldsState();
}

class _TextFormFieldsState extends State<TextFormFields> {
  Validation _validation = Validation();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.mainColorAccent,
      cursorHeight: 20,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      keyboardType: widget.textInputType,
      inputFormatters: widget.textInputFormatter,
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
        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
        suffixIcon: InputIcons(typeField: widget.typeField),
      ),
      validator: (value) => _validation.selectUserValidator(
          value: value, typeField: widget.typeField, context: context),
      textInputAction: TextInputAction.next,
      onEditingComplete: () => widget.node.nextFocus(),
    );
  }
}
