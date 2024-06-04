import 'package:flutter/material.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/pick_height_width.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/widgets/buttons/round_chip.dart';

class SubscriptionTimerWidget extends StatelessWidget {
  const SubscriptionTimerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: ShapeDecoration(
        color: PickColors.whiteColor.withOpacity(0.4000000059604645),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: PickColors.whiteColor.withOpacity(0.4000000059604645),
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('3 DAYS TRIAL',
                        textAlign: TextAlign.center,
                        style: CommonTextStyle.smallTextStyle
                            .copyWith(color: PickColors.primaryColor)),
                    PickHeightAndWidth.height5,
                    Text('Daily Market calls with learning trial',
                        textAlign: TextAlign.center,
                        style: CommonTextStyle.noteTextStyle
                            .copyWith(color: PickColors.textFieldTextColor))
                  ],
                ),
              ),
              RoundChipWidget(
                chitTitle: "Active",
                verticalPadding: 1,
                horizontalPadding: 2,
                chipIcon: Icons.check_circle,
                chipColor: PickColors.whiteColor,
                chipIconColor: PickColors.greenColor,
              )
            ],
          ),
          PickHeightAndWidth.height10,
          Container(
            padding: EdgeInsets.all(10),
            decoration: ShapeDecoration(
              color: PickColors.containerBackColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Column(
              children: [
                Text('Time Left',
                    textAlign: TextAlign.center,
                    style: CommonTextStyle.smallTextStyle
                        .copyWith(color: PickColors.hintTextColor)),
                PickHeightAndWidth.height10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text('32',
                            textAlign: TextAlign.center,
                            style: CommonTextStyle.mediumHeadingStyle),
                        Text('HOURS',
                            textAlign: TextAlign.center,
                            style: CommonTextStyle.smallTextStyle
                                .copyWith(fontWeight: FontWeight.w400))
                      ],
                    ),
                    Text(':',
                        textAlign: TextAlign.center,
                        style: CommonTextStyle.smallTextStyle),
                    Column(
                      children: [
                        Text('59',
                            textAlign: TextAlign.center,
                            style: CommonTextStyle.mediumHeadingStyle),
                        Text('MINUTES',
                            textAlign: TextAlign.center,
                            style: CommonTextStyle.smallTextStyle
                                .copyWith(fontWeight: FontWeight.w400))
                      ],
                    ),
                    Text(':',
                        textAlign: TextAlign.center,
                        style: CommonTextStyle.smallTextStyle),
                    Column(
                      children: [
                        Text('25',
                            textAlign: TextAlign.center,
                            style: CommonTextStyle.mediumHeadingStyle),
                        Text('SECONDS',
                            textAlign: TextAlign.center,
                            style: CommonTextStyle.smallTextStyle
                                .copyWith(fontWeight: FontWeight.w400))
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
