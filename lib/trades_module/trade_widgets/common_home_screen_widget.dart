import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shah_investment/auth_module/auth_provider.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/date_formates.dart';
import 'package:shah_investment/constants/images_route.dart';
import 'package:shah_investment/constants/pick_height_width.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/logical_functions/get_greeting_msg.dart';
import 'package:shah_investment/trades_module/trade_titles.dart';
import 'package:shah_investment/widgets/buttons/round_chip.dart';
import 'package:shah_investment/widgets/network_image_builder.dart';

class CommonHomeScreenContainer extends StatefulWidget {
  final int isPreSubscription;
  const CommonHomeScreenContainer({super.key, required this.isPreSubscription});

  @override
  State<CommonHomeScreenContainer> createState() =>
      _CommonHomeScreenContainerState();
}

class _CommonHomeScreenContainerState extends State<CommonHomeScreenContainer> {
  DateTime currentDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext context, AuthProvider authProvider, snapshot) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE1E1FF), Color(0xFF9393FF)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    DateFormate.longDateFormate.format(currentDate),
                    style: CommonTextStyle.mediumHeadingStyle.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: RoundChipWidget(
                    chitTitle: TradeTitles.today,
                    chipColor: PickColors.textFieldTextColor,
                    chipTextColor: PickColors.whiteColor,
                    horizontalPadding: 20,
                    verticalPadding: 5,
                  ),
                )
              ],
            ),
            PickHeightAndWidth.height30,
            widget.isPreSubscription == 0
                ? Text(
                    "1M+ People ",
                    style: CommonTextStyle.mainHeadingTextStyle.copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                : Row(
                    children: [
                      BuildLogoProfileImageWidget(
                        imagePath:
                            authProvider.currentUserData?.profileImage ?? "-",
                        titleName: authProvider.currentUserData?.name ?? "-",
                        borderRadius: BorderRadius.circular(50),
                      ),
                      PickHeightAndWidth.width10,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getGreetingMessage(date: currentDate),
                              style:
                                  CommonTextStyle.mainHeadingTextStyle.copyWith(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              authProvider.currentUserData?.name ?? "-",
                              style:
                                  CommonTextStyle.mainHeadingTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: PickColors.whiteColor.withOpacity(0.3),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.pinkAccent)),
                          child: SvgPicture.asset(PickImages.crownIcon))
                    ],
                  ),
          ],
        ),
      );
    });
  }
}
