import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/date_formates.dart';
import 'package:shah_investment/constants/pick_height_width.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/trades_module/trade_models/tip_model.dart';
import 'package:shah_investment/trades_module/trade_titles.dart';
import 'package:shah_investment/widgets/buttons/round_chip.dart';
import 'package:shah_investment/widgets/prize_detail_container.dart';

class HomePageCardDetails extends StatefulWidget {
  final TipsModel tipData;
  final int isPreSubscription;
  const HomePageCardDetails({
    super.key,
    required this.tipData,
    required this.isPreSubscription,
  });

  @override
  State<HomePageCardDetails> createState() => _HomePageCardDetailsState();
}

class _HomePageCardDetailsState extends State<HomePageCardDetails> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: PickColors.textFieldDisableColor)),
        child: Column(
          children: [
            widget.isPreSubscription == 0
                ? Container()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RoundChipWidget(
                        chitTitle: widget.tipData.status ?? "-",
                        chipTextColor: PickColors.textFieldTextColor,
                        chipColor: PickColors.whiteColor,
                        horizontalPadding: 20,
                        chipBorderColor: PickColors.textFieldDisableColor,
                      ),
                      RoundChipWidget(
                        chitTitle: DateTime.tryParse(
                                    widget.tipData.updatedAt ?? "-") !=
                                null
                            ? DateFormate.tipsDateFormate.format(
                                DateTime.parse(widget.tipData.updatedAt ?? "-"))
                            : "-",
                        chipColor: PickColors.textFieldTextColor,
                        chipTextColor: PickColors.whiteColor,
                        horizontalPadding: 20,
                      )
                    ],
                  ),
            widget.isPreSubscription == 0
                ? Container()
                : PickHeightAndWidth.height15,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Text(
                        widget.tipData.name ?? "-",
                        style: CommonTextStyle.mainHeadingTextStyle.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      PickHeightAndWidth.width5,
                      const RoundChipWidget(
                        chitTitle: "CE",
                        chipColor: PickColors.extraLightGreenColor,
                        chipTextColor: PickColors.greenColor,
                        chipBorderColor: PickColors.greenBorderColor,
                        horizontalPadding: 9,
                        verticalPadding: 0.1,
                      ),
                    ],
                  ),
                ),
                widget.isPreSubscription == 0
                    ? Text(
                        DateTime.tryParse(widget.tipData.createdAt ?? "-") !=
                                null
                            ? DateFormate.newDateFormate.format(
                                DateTime.parse(widget.tipData.createdAt ?? "-"))
                            : "-",
                        style: CommonTextStyle.noteTextStyle
                            .copyWith(fontSize: 12),
                      )
                    : Container()
              ],
            ),
            PickHeightAndWidth.height10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PrizeContainerWidget(
                  title: TradeTitles.buyPrice,
                  subTitle: "₹${widget.tipData.buyPrice}",
                ),
                widget.isPreSubscription == 0
                    ? Container()
                    : PrizeContainerWidget(
                        title: TradeTitles.sLPrice,
                        subTitle: "₹${widget.tipData.stopLimit}",
                      ),
                PrizeContainerWidget(
                  title: TradeTitles.targetPrice,
                  subTitle: "₹${widget.tipData.targetPrice}",
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
