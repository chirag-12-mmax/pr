import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/text_style.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';

// CommonFormBuilderTextField
class CommonFormBuilderTextField extends StatefulWidget {
  const CommonFormBuilderTextField(
      {super.key,
      required this.fieldKey,
      required this.hint,
      this.isDisable = false,
      this.readOnly = false,
      this.verticalPadding = 10,
      this.isObSecure = false,
      this.contentPaddingVertical = 15,
      this.customValidation,
      this.suffix,
      this.fillColor = PickColors.whiteColor,
      this.keyboardType = TextInputType.text,
      this.onChanged,
      this.maxLines,
      this.inputFormatters,
      required this.isRequired,
      this.maxCharLength,
      this.textController,
      this.textStyle = CommonTextStyle.textFieldTextStyle,
      this.borderColor = PickColors.textFieldBorderColor,
      this.borderRadius = 15,
      required this.validationKey,
      this.prefix,
      this.isDense = false});

  final String fieldKey;
  final String hint;
  final bool isDisable;
  final double? verticalPadding;
  final bool readOnly;
  final bool isObSecure;
  final TextInputType keyboardType;
  final int? maxLines;
  final int? maxCharLength;
  final String? Function(String?)? customValidation;
  final String validationKey;
  final Function(String?)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final dynamic prefix;
  final dynamic suffix;
  final TextStyle textStyle;
  final Color? fillColor;
  final Color? borderColor;
  final bool isRequired;
  final bool isDense;
  final TextEditingController? textController;
  final double? borderRadius;
  final double contentPaddingVertical;

  @override
  State<CommonFormBuilderTextField> createState() =>
      _CommonFormBuilderTextFieldState();
}

class _CommonFormBuilderTextFieldState
    extends State<CommonFormBuilderTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.verticalPadding!),
      child: IgnorePointer(
        ignoring: widget.isDisable,
        child: FormBuilderTextField(
          name: widget.fieldKey,
          controller: widget.textController,
          enabled: !widget.isDisable,
          readOnly: widget.readOnly,
          obscureText: widget.isObSecure,
          style: widget.isDisable
              ? widget.textStyle
                  .copyWith(color: widget.textStyle.color?.withOpacity(0.2))
              : widget.textStyle,
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLines ?? 1,
          maxLength: widget.maxCharLength,
          validator: widget.customValidation ??
              validateTextFieldByKey(
                  isRequired: widget.isRequired,
                  validationKey: widget.validationKey),
          textInputAction: TextInputAction.next,
          onChanged: widget.onChanged,
          inputFormatters: widget.inputFormatters,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            isDense: widget.isDense,
            filled: true,
            fillColor: widget.isDisable
                ? PickColors.textFieldDisableColor
                : widget.fillColor,
            suffixIconConstraints: const BoxConstraints(),
            prefixIconConstraints: const BoxConstraints(),
            // errorStyle: const TextStyle(
            //   fontSize: 0,
            //   height: 0.01,
            // ),
            counterText: '',
            hintText: (widget.hint),

            hintStyle:
                widget.textStyle.copyWith(color: PickColors.hintTextColor),
            // label: Row(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     Flexible(
            //       child: Text(
            //         (widget.hint),
            //         style: widget.textStyle
            //             .copyWith(color: PickColors.hintTextColor),
            //       ),
            //     ),
            //     if (widget.isRequired)
            //       Text(
            //         '*',
            //         style: widget.textStyle.copyWith(color: Colors.red),
            //       ),
            //   ],
            // ),

            prefixIcon: widget.prefix,
            contentPadding: EdgeInsets.symmetric(
                horizontal: 10, vertical: widget.contentPaddingVertical),
            suffixIcon: widget.suffix,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius!),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius!),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius!),
              borderSide: const BorderSide(color: PickColors.primaryColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius!),
              borderSide: BorderSide(color: widget.borderColor!),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius!),
              borderSide: BorderSide(color: widget.borderColor!),
            ),
          ),
        ),
      ),
    );
  }
}

String? Function(String?)? validateTextFieldByKey(
    {required bool isRequired, required String validationKey}) {
  return FormBuilderValidators.compose([
    if (isRequired)
      FormBuilderValidators.required(errorText: "$validationKey Can't be Empty")
  ]);
}
