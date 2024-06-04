import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/widgets/textfield_label_widget.dart';
// import 'package:pin_code_text_field/pin_code_text_field.dart';

// ignore: must_be_immutable
class CustomPinCodeView extends StatelessWidget {
  CustomPinCodeView(
      {super.key,
      this.textEditingController,
      this.pinLength = 4,
      this.hasError = false,
      this.hideCharacter = true,
      this.onTextChanged,
      this.onDone,
      this.pinBoxWidth,
      this.pinBoxHeight,
      this.wrapAlignment = WrapAlignment.center,
      this.textColor,
      this.labelText,
      this.pinBoxColor = Colors.white,
      this.isRequired = true,
      required this.borderColor,
      required this.autoFocus,
      this.horizontal = 4.0,
      this.fontSize,
      required this.newContext,
      required this.isPassword});
  final TextEditingController? textEditingController;
  final int pinLength;
  final bool hasError;
  final double? pinBoxWidth;
  final double? pinBoxHeight;
  final bool hideCharacter;
  Function(String)? onTextChanged;
  Function(String)? onDone;
  final WrapAlignment wrapAlignment;

  final Color? textColor;
  final Color borderColor;
  final double? fontSize;
  final String? labelText;
  final bool isRequired;
  final bool autoFocus;
  final Color pinBoxColor;
  final double horizontal;
  final bool isPassword;
  final BuildContext newContext;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (labelText != null)
            TextFieldLabelWidget(
              isRequired: isRequired,
              title: labelText ?? '-',
            ),
          if (labelText != null)
            const SizedBox(
              height: 10,
            ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 500,
              child: PinCodeTextField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                appContext: newContext,
                autoDisposeControllers: false,
                length: pinLength,
                animationCurve: Curves.bounceInOut,
                autoFocus: autoFocus,
                pastedTextStyle: TextStyle(
                  color: Colors.green.shade600,
                  fontWeight: FontWeight.bold,
                ),
                obscureText: isPassword,
                obscuringCharacter: '*',
                blinkWhenObscuring: true,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(15.00)),
                    fieldHeight: pinLength != 6 ? pinBoxHeight ?? 50 : 55,
                    fieldWidth: pinLength != 6 ? pinBoxWidth ?? 50 : 52,
                    selectedFillColor: Colors.white,
                    activeFillColor: Colors.white,
                    disabledColor: PickColors.primaryColor,
                    inactiveColor: borderColor,
                    errorBorderColor: Colors.red,
                    activeColor: PickColors.primaryColor,
                    inactiveFillColor: pinBoxColor,
                    selectedColor: PickColors.primaryColor),
                cursorColor: Colors.black,
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                onChanged: onTextChanged,
                onSubmitted: onDone,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.length < pinLength) {
                    return "OTP can't be blank or less than $pinLength digits";
                  } else {
                    return null;
                  }
                },
                controller: textEditingController,
                keyboardType: TextInputType.number,
                boxShadows: const [
                  BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.black12,
                    blurRadius: 10,
                  )
                ],
              ),
            ),
          ),
          // if (hasError)
          //   Text(
          //     "OTP can't be blank or less than $pinLength digits",
          //     style: const TextStyle(color: PickColors.redColor, fontSize: 12),
          //   ),
        ],
      ),
    );
  }
}
