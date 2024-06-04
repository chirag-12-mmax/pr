import 'package:flutter/material.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/text_style.dart';

class RoundChipWidget extends StatelessWidget {
  const RoundChipWidget({
    super.key,
    required this.chitTitle,
    this.chipIcon,
    this.chipColor = PickColors.textFieldDisableColor,
    this.chipBorderColor = Colors.transparent,
    this.horizontalPadding = 5,
    this.verticalPadding = 3,
    this.chipTextColor,
    this.chipIconColor,
  });
  final String chitTitle;
  final IconData? chipIcon;
  final Color chipColor;
  final Color chipBorderColor;
  final double horizontalPadding;
  final double verticalPadding;
  final Color? chipTextColor;
  final Color? chipIconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: verticalPadding,
          left: horizontalPadding,
          right: chipIcon != null ? 12 : horizontalPadding,
          bottom: verticalPadding),
      decoration: BoxDecoration(
          border: Border.all(color: chipBorderColor, width: 1),
          color: chipColor,
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (chipIcon != null)
            Icon(
              chipIcon,
              size: 20,
              color: chipIconColor,
            ),
          Text(
            chitTitle,
            style: CommonTextStyle.chipTextStyle.copyWith(
              color: chipTextColor ?? CommonTextStyle.chipTextStyle.color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
