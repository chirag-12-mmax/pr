import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/pick_height_width.dart';
import 'package:shah_investment/constants/text_style.dart';

// ignore: must_be_immutable
class HeaderWidget extends StatelessWidget {
  HeaderWidget({
    super.key,
    required this.mainTitle,
    required this.subTitle,
    required this.skipButtonOnTap,
    this.color,
    this.description,
    this.showDescription = true,
  });

  String mainTitle;
  String subTitle;
  dynamic skipButtonOnTap;
  String? description;
  bool showDescription;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PickHeightAndWidth.height20,
        Text(
          mainTitle,
          style: CommonTextStyle.mainHeadingTextStyle,
        ),
        Text(
          subTitle,
          style: CommonTextStyle.mainHeadingTextStyle
              .copyWith(color: color ?? PickColors.primaryColor),
        ),
        showDescription ? PickHeightAndWidth.height15 : Container(),
        showDescription
            ? Text(
                description ?? "",
                style: CommonTextStyle.noteTextStyle.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              )
            : Container(),
      ],
    );
  }
}
