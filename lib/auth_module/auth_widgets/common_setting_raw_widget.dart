import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/images_route.dart';
import 'package:shah_investment/constants/pick_height_width.dart';
import 'package:shah_investment/constants/text_style.dart';

// ignore: must_be_immutable
class CommonSettingRawWidget extends StatefulWidget {
  CommonSettingRawWidget({
    super.key,
    required this.prefixIcon,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.isSubtitle = false,
    this.arrowForwardIcon,
    this.widget,
  });
  String prefixIcon;
  String title;
  Widget? widget;
  dynamic onTap;
  bool isSubtitle;
  String? subtitle;
  dynamic arrowForwardIcon;

  @override
  State<CommonSettingRawWidget> createState() => _CommonSettingRawWidgetState();
}

class _CommonSettingRawWidgetState extends State<CommonSettingRawWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          widget.prefixIcon,
          // ignore: deprecated_member_use
          color: PickColors.blackColor, height: 25,
        ),
        PickHeightAndWidth.width12,
        Expanded(
          child: InkWell(
            onTap: widget.onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: CommonTextStyle.noteTextStyle.copyWith(
                    color: PickColors.blackColor,
                  ),
                ),
                widget.isSubtitle
                    ? Text(
                        widget.subtitle ?? "",
                        style: CommonTextStyle.noteTextStyle.copyWith(
                            color: PickColors.blackColor, fontSize: 11),
                      )
                    : Container()
              ],
            ),
          ),
        ),
        widget.isSubtitle
            ? widget.widget!
            : InkWell(
                onTap: widget.arrowForwardIcon,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SvgPicture.asset(
                    height: 25,
                    PickImages.arrowForwardIcon,
                  ),
                ),
              ),
        PickHeightAndWidth.height50,
      ],
    );
  }
}
