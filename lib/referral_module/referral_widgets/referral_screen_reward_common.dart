import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/pick_height_width.dart';
import 'package:shah_investment/constants/text_style.dart';

class CommonReferralScreenContainer extends StatefulWidget {
  dynamic mainIcon;
  dynamic mainText;
  dynamic subText;
  TextStyle? mainTextTextStyle;

  CommonReferralScreenContainer(
      {super.key,
      required this.mainIcon,
      required this.mainText,
      required this.subText,
      this.mainTextTextStyle});

  @override
  State<CommonReferralScreenContainer> createState() =>
      _CommonReferralScreenContainerState();
}

class _CommonReferralScreenContainerState
    extends State<CommonReferralScreenContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          border: Border.all(color: PickColors.searchFieldBgColor),
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(widget.mainIcon),
            PickHeightAndWidth.height20,
            Text(
              widget.mainText,
              style: widget.mainTextTextStyle,
            ),
            Text(
              widget.subText,
              style: CommonTextStyle.noteTextStyle.copyWith(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
