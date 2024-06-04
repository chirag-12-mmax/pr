import 'package:flutter/material.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/date_formates.dart';
import 'package:shah_investment/constants/pick_height_width.dart';
import 'package:shah_investment/constants/size_config.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/referral_module/referral_models/referral_user_history_model.dart';
import 'package:shah_investment/widgets/buttons/round_chip.dart';
import 'package:shah_investment/widgets/network_image_builder.dart';

class CommonReferralHistoryListTileWidget extends StatefulWidget {
  const CommonReferralHistoryListTileWidget({
    super.key,
    required this.referralUserHistoryDataList,
  });
  final ReferralUserHistoryModel referralUserHistoryDataList;

  @override
  State<CommonReferralHistoryListTileWidget> createState() =>
      _CommonReferralHistoryListTileWidgetState();
}

class _CommonReferralHistoryListTileWidgetState
    extends State<CommonReferralHistoryListTileWidget> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            children: [
              BuildLogoProfileImageWidget(
                  isColors: true,
                  height: 54,
                  width: 54,
                  // height: SizeConfig.screenHeight! * 0.070,
                  // width: SizeConfig.screenWidth! * 0.14,
                  borderRadius: BorderRadius.circular(50),
                  imagePath:
                      widget.referralUserHistoryDataList.profileImage ?? "-",
                  titleName: widget.referralUserHistoryDataList.name ?? "-"),
              PickHeightAndWidth.width10,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.referralUserHistoryDataList.name ?? "- ",
                      style: CommonTextStyle.noteTextStyle
                          .copyWith(color: PickColors.blackColor),
                    ),
                    PickHeightAndWidth.height2,
                    Text(
                        DateTime.tryParse(widget.referralUserHistoryDataList
                                        .createdAt ??
                                    "-") !=
                                null
                            ? DateFormate.tipsDateFormate.format(DateTime.parse(
                                widget.referralUserHistoryDataList.createdAt ??
                                    "-"))
                            : "-",
                        style: CommonTextStyle.smallTextStyle
                            .copyWith(color: PickColors.hintTextColor)),
                  ],
                ),
              ),
              const RoundChipWidget(
                chitTitle: "Got 5 Days",
                horizontalPadding: 12,
                chipColor: PickColors.greenBorderColor,
                chipTextColor: PickColors.whiteColor,
              ),
            ],
          ),
        ),
        const Divider(
          color: PickColors.textFieldBorderColor,
        ),
      ],
    );
  }
}
