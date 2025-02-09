import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/images_route.dart';
import 'package:shah_investment/constants/navigation_screen.dart';
import 'package:shah_investment/constants/pick_height_width.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/general_helper.dart';
import 'package:shah_investment/widgets/buttons/primary_button.dart';

class CommonConfirmationDialogBox extends StatefulWidget {
  final String? title;
  final bool isIcon;
  final bool isCancel;
  final String? subTitle;
  final String? buttonTitle;
  final String? cancelButtonTitle;
  final dynamic onPressButton;

  const CommonConfirmationDialogBox({
    super.key,
    this.title,
    this.subTitle,
    this.buttonTitle,
    this.cancelButtonTitle,
    this.isIcon = false,
    this.isCancel = false,
    this.onPressButton,
  });

  @override
  State<CommonConfirmationDialogBox> createState() =>
      _CommonConfirmationDialogBoxState();
}

class _CommonConfirmationDialogBoxState
    extends State<CommonConfirmationDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext context, GeneralHelper helper, snapshot) {
      return SimpleDialog(
        title: widget.title != null
            ? Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        widget.title ?? "-",
                        style: CommonTextStyle.mainHeadingTextStyle.copyWith(
                          color: PickColors.blackColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      backToScreen(context: context);
                    },
                    // child: SvgPicture.asset(
                    //   alignment: Alignment.centerRight,
                    //   PickImages.cancelIcon,
                    // ),
                    child: const Icon(Icons.cancel_rounded),
                  ),
                ],
              )
            : null,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                if (widget.isIcon) PickHeightAndWidth.height15,
                if (widget.isIcon)
                  SvgPicture.asset(
                    alignment: Alignment.centerRight,
                    PickImages.trueIcon,
                  ),
                PickHeightAndWidth.height15,
                Text(
                  widget.subTitle ?? "-",
                  textAlign: TextAlign.center,
                  style: CommonTextStyle.textFieldTextStyle,
                ),
                PickHeightAndWidth.height30,
                Row(
                  children: [
                    if (widget.isCancel)
                      Expanded(
                        child: CommonMaterialButton(
                          borderColor: PickColors.primaryColor,
                          color: PickColors.whiteColor,
                          style: CommonTextStyle.buttonTextStyle
                              .copyWith(color: PickColors.primaryColor),
                          title: widget.cancelButtonTitle ??
                              helper.translateTextTitle(titleText: "Cancel") ??
                              "-",
                          onPressed: () {
                            backToScreen(context: context);
                          },
                        ),
                      ),
                    if (widget.isCancel) PickHeightAndWidth.width10,
                    Expanded(
                      child: CommonMaterialButton(
                        title: widget.buttonTitle ?? "-",
                        onPressed: widget.onPressButton,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      );
    });
  }
}
