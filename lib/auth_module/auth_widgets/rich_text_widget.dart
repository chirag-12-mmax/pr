import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/text_style.dart';

class RichTextWidget extends StatelessWidget {
  const RichTextWidget({
    super.key,
    this.mainTitle,
    this.subTitle,
    this.recognizer,
  });

  final String? mainTitle;
  final String? subTitle;
  final GestureRecognizer? recognizer;

  @override
  Widget build(BuildContext context) {
    return RichText(
      // maxLines: 2,
      textAlign: TextAlign.center,
      text: TextSpan(
        text: mainTitle,
        style: CommonTextStyle.noteTextStyle
            .copyWith(color: PickColors.textFieldTextColor),
        children: [
          TextSpan(
            recognizer: recognizer,
            text: subTitle,
            style: CommonTextStyle.noteTextStyle
                .copyWith(color: PickColors.primaryColor),
          ),
        ],
      ),
    );
  }
}
