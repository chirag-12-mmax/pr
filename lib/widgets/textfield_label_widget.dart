import 'package:flutter/material.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/text_style.dart';

class TextFieldLabelWidget extends StatelessWidget {
  const TextFieldLabelWidget({
    super.key,
    required this.title,
    required this.isRequired,
    this.testStyle,
  });
  final String title;
  final bool isRequired;
  final TextStyle? testStyle;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: title,
        style: CommonTextStyle.noteTextStyle,
        children: isRequired
            ? [
                TextSpan(
                  text: "*",
                  style: CommonTextStyle.noteTextStyle.copyWith(
                    color: PickColors.redColor,
                  ),
                ),
              ]
            : [],
      ),
    );
  }
}
