import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/text_style.dart';

class WithOutBorderCommonFormBuilderTextField extends StatelessWidget {
  const WithOutBorderCommonFormBuilderTextField({
    super.key,
    required this.hintTitle,
    required this.fieldKey,
  });

  final String hintTitle;
  final String fieldKey;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      cursorColor: PickColors.primaryColor,
      name: fieldKey,
      maxLines: 15,
      minLines: 2,
      decoration: InputDecoration(
        hintText: hintTitle,
        hintStyle: CommonTextStyle.noteTextStyle,
        focusColor: PickColors.primaryColor,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: PickColors.primaryColor,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: PickColors.textFieldBorderColor,
          ),
        ),
        contentPadding: const EdgeInsetsDirectional.symmetric(
          vertical: 40,
        ),
      ),
      keyboardType: TextInputType.multiline,
    );
  }
}
