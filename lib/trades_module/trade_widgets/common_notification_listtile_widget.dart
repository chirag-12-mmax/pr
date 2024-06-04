import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/date_formates.dart';
import 'package:shah_investment/constants/images_route.dart';
import 'package:shah_investment/constants/pick_height_width.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/trades_module/trade_models/notification_model.dart';

class CommonNotificationListTileWidget extends StatefulWidget {
  const CommonNotificationListTileWidget({
    super.key,
    required this.notificationModelDataList,
  });

  final NotificationModel notificationModelDataList;

  @override
  State<CommonNotificationListTileWidget> createState() =>
      _CommonNotificationListTileWidgetState();
}

class _CommonNotificationListTileWidgetState
    extends State<CommonNotificationListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.00),
                decoration: BoxDecoration(
                  border: Border.all(color: PickColors.textFieldBorderColor),
                  borderRadius: BorderRadius.circular(100.00),
                ),
                child: SvgPicture.asset(
                  PickImages.subscriptionHistoryIcon,
                  height: 20,
                ),
              ),
              PickHeightAndWidth.width10,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (widget.notificationModelDataList.title ?? ""),
                      style: CommonTextStyle.noteTextStyle
                          .copyWith(color: PickColors.blackColor),
                    ),
                    PickHeightAndWidth.height2,
                    Text((widget.notificationModelDataList.subTitle ?? ""),
                        style: CommonTextStyle.smallTextStyle
                            .copyWith(color: PickColors.hintTextColor)),
                  ],
                ),
              ),
              Text(
                DateTime.tryParse(widget.notificationModelDataList.createdAt ??
                            "-") !=
                        null
                    ? DateFormate.tipsDateFormate.format(DateTime.parse(
                            widget.notificationModelDataList.createdAt ?? "-")
                        .toLocal())
                    : "-",
                // "${widget.notificationModelDataList.notificationTime ?? "-"}${" | "}${DateTime.tryParse(widget.notificationModelDataList.createdAt ?? "-") != null ? DateFormate.newDateFormate.format(DateTime.parse(widget.notificationModelDataList.createdAt ?? "-")) : "-"}",
                style: CommonTextStyle.smallTextStyle
                    .copyWith(color: PickColors.hintTextColor),
              ),
            ],
          ),
        ),
        // PickHeightAndWidth.height5,
        const Divider(
          color: PickColors.textFieldBorderColor,
        ),
      ],
    );
  }
}
