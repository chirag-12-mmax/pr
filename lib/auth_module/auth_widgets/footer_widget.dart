import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shah_investment/auth_module/auth_titles.dart';
import 'package:shah_investment/auth_module/auth_widgets/rich_text_widget.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/pick_height_width.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/widgets/buttons/primary_button.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({
    super.key,
    required this.mainTitle,
    required this.subTitle,
    required this.prefixIcon,
    required this.buttonName,
    required this.buttonOnTap,
    required this.richTextOnTap,
  });
  final String mainTitle;
  final String subTitle;
  final String prefixIcon;
  final String buttonName;
  final dynamic buttonOnTap;
  final GestureRecognizer? richTextOnTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PickHeightAndWidth.height30,
        const Row(
          children: <Widget>[
            Expanded(
              child: Divider(
                color: PickColors.textFieldBorderColor,
              ),
            ),
            Text(
              AuthTitles.or,
              style: CommonTextStyle.noteTextStyle,
            ),
            Expanded(
              child: Divider(
                color: PickColors.textFieldBorderColor,
              ),
            ),
          ],
        ),
        PickHeightAndWidth.height30,
        CommonMaterialButton(
          verticalPadding: 24,
          borderRadius: 16,
          title: buttonName,
          style: CommonTextStyle.buttonTextStyle
              .copyWith(color: PickColors.blackColor),
          onPressed: buttonOnTap,
          prefixIcon: prefixIcon,
          borderColor: PickColors.textFieldBorderColor,
          color: Colors.transparent,
        ),
        PickHeightAndWidth.height30,
        RichTextWidget(
          mainTitle: mainTitle,
          subTitle: AuthTitles.createAnAccount,
          recognizer: richTextOnTap,
        )
      ],
    );
  }
}
