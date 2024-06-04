import 'package:flutter/material.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/pick_height_width.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/trades_module/trade_models/subscription_model.dart';
import 'package:shah_investment/widgets/buttons/round_chip.dart';

class SubscriptionItemWidget extends StatelessWidget {
  const SubscriptionItemWidget({
    super.key,
    this.onTapWidget,
    required this.isSelected,
    required this.subscriptionData,
  });

  final dynamic onTapWidget;
  final bool isSelected;
  final SubscriptionModel subscriptionData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapWidget,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(5),
        decoration: ShapeDecoration(
          color: isSelected
              ? PickColors.activeContainerBackgroundColor
              : PickColors.whiteColor.withOpacity(0.20000000298023224),
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 1,
                color: isSelected
                    ? PickColors.activeContainerBorderColor
                    : PickColors.whiteColor.withOpacity(0.4000000059604645)),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: subscriptionData.discount != 0
            ? Column(
                children: [
                  RoundChipWidget(
                    chitTitle: "Save ${subscriptionData.discount} %",
                    chipTextColor: PickColors.textFieldTextColor,
                    chipColor: PickColors.whiteColor,
                  ),
                  Text(subscriptionData.months.toString(),
                      textAlign: TextAlign.center,
                      style: CommonTextStyle.mediumHeadingStyle),
                  Text('MONTHS',
                      textAlign: TextAlign.center,
                      style: CommonTextStyle.smallTextStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      )),
                  PickHeightAndWidth.height15,
                  Text(
                    'INR${subscriptionData.amount.toString()}/${subscriptionData.months.toString()}month',
                    style: CommonTextStyle.smallTextStyle.copyWith(
                      color: PickColors.hintTextColor,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: PickColors.hintTextColor,
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'INR ${subscriptionData.discountAmount}',
                          style: CommonTextStyle.noteTextStyle.copyWith(
                            color: PickColors.textFieldTextColor,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(
                          text: '/${subscriptionData.months.toString()} Month',
                          style: CommonTextStyle.smallTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  children: [
                    Text(subscriptionData.months.toString(),
                        textAlign: TextAlign.center,
                        style: CommonTextStyle.mediumHeadingStyle),
                    Text('MONTHS',
                        textAlign: TextAlign.center,
                        style: CommonTextStyle.smallTextStyle.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                        )),
                    PickHeightAndWidth.height15,
                    Text(
                      'INR${subscriptionData.amount.toString()}/${subscriptionData.months.toString()}month',
                      style: CommonTextStyle.smallTextStyle.copyWith(
                        color: PickColors.hintTextColor,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: PickColors.hintTextColor,
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'INR ${subscriptionData.discountAmount}',
                            style: CommonTextStyle.noteTextStyle.copyWith(
                              color: PickColors.textFieldTextColor,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextSpan(
                            text:
                                '/${subscriptionData.months.toString()} Month',
                            style: CommonTextStyle.smallTextStyle.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
