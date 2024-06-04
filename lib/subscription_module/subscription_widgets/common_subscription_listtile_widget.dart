import 'package:flutter/material.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/date_formates.dart';
import 'package:shah_investment/constants/images_route.dart';
import 'package:shah_investment/constants/pick_height_width.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/subscription_module/subscription_models/payment_history_model.dart';
import 'package:shah_investment/widgets/buttons/round_chip.dart';

class CommonSubscriptionListTileWidget extends StatefulWidget {
  const CommonSubscriptionListTileWidget({
    super.key,
    required this.paymentHistoryModelDataList,
  });

  final PaymentHistoryModel paymentHistoryModelDataList;

  @override
  State<CommonSubscriptionListTileWidget> createState() =>
      _CommonSubscriptionListTileWidgetState();
}

class _CommonSubscriptionListTileWidgetState
    extends State<CommonSubscriptionListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              Image.asset(PickImages.subscriptionHistoryIcon),
              PickHeightAndWidth.width10,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (widget.paymentHistoryModelDataList.price ?? "")
                          .toString(),
                      style: CommonTextStyle.noteTextStyle
                          .copyWith(color: PickColors.blackColor),
                    ),
                    PickHeightAndWidth.height2,
                    Text(
                      DateTime.tryParse(widget
                                      .paymentHistoryModelDataList.createdAt ??
                                  "-") !=
                              null
                          ? DateFormate.tipsDateFormate.format(DateTime.parse(
                              widget.paymentHistoryModelDataList.createdAt ??
                                  "-"))
                          : "-",
                      style: CommonTextStyle.smallTextStyle
                          .copyWith(color: PickColors.hintTextColor),
                    ),
                  ],
                ),
              ),
              RoundChipWidget(
                chitTitle: widget.paymentHistoryModelDataList.paymentStatus == 0
                    ? "Market Calls"
                    : "Learning",
                horizontalPadding: 12,
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
