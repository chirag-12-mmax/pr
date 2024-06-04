import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/images_route.dart';
import 'package:shah_investment/constants/pick_height_width.dart';
import 'package:shah_investment/constants/size_config.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/feed_module/feed_titles.dart';
import 'package:shah_investment/widgets/buttons/primary_button.dart';
import 'package:shah_investment/widgets/buttons/round_chip.dart';

class PaymentCompletedScreen extends StatefulWidget {
  const PaymentCompletedScreen({super.key});

  @override
  State<PaymentCompletedScreen> createState() => _PaymentCompletedScreenState();
}

class _PaymentCompletedScreenState extends State<PaymentCompletedScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: PickColors.paymentCompletedBackGroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PickHeightAndWidth.height40,
              SvgPicture.asset(
                PickImages.paymentCompleteIcon,
              ),
              PickHeightAndWidth.height15,
              Text(
                FeedTitles.paymentCompleted,
                style: CommonTextStyle.mainHeadingTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              PickHeightAndWidth.height30,
              Container(
                height: SizeConfig.screenHeight! * 0.80,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      PickImages.rectangleImage,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        FeedTitles.monthSubscriptionCalls,
                        style: CommonTextStyle.noteTextStyle.copyWith(
                          color: PickColors.blackColor,
                        ),
                      ),
                      PickHeightAndWidth.height10,
                      Row(
                        children: [
                          SvgPicture.asset(PickImages.watchIcon),
                          PickHeightAndWidth.width10,
                          Text(
                            "17 Jun 2023, 6:30PM",
                            style: CommonTextStyle.noteTextStyle.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          PickHeightAndWidth.height40,
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            PickImages.locationIcon,
                          ),
                          PickHeightAndWidth.width10,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "New York, 215, Sage Alley,",
                                style: CommonTextStyle.noteTextStyle.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "Westernfud, MD, 380",
                                style: CommonTextStyle.noteTextStyle.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      PickHeightAndWidth.height15,
                      const Divider(
                        thickness: 2,
                        color: PickColors.textFieldBorderColor,
                      ),
                      PickHeightAndWidth.height15,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            FeedTitles.newActivePlan,
                            style: CommonTextStyle.chipTextStyle.copyWith(
                              color: PickColors.hintTextColor,
                            ),
                          ),
                          PickHeightAndWidth.height10,
                          Row(
                            children: [
                              const RoundChipWidget(
                                chitTitle: FeedTitles.marketCalls,
                              ),
                              PickHeightAndWidth.width12,
                              Text(
                                "3 Month",
                                style: CommonTextStyle.subHeadingTextStyle
                                    .copyWith(fontSize: 14),
                              ),
                              Expanded(
                                // Wrapping ₹99.00 with Expanded
                                child: Align(
                                  alignment: Alignment
                                      .centerRight, // Aligning text to the end
                                  child: Text(
                                    "₹99.00",
                                    style: CommonTextStyle.subHeadingTextStyle
                                        .copyWith(fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      PickHeightAndWidth.height15,
                      const Divider(
                        thickness: 2,
                        color: PickColors.textFieldBorderColor,
                      ),
                      PickHeightAndWidth.height15,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FeedTitles.newActivePlan,
                            style: CommonTextStyle.chipTextStyle.copyWith(
                              color: PickColors.hintTextColor,
                            ),
                          ),
                          PickHeightAndWidth.width12,
                          Text(
                            "₹297.00",
                            style: CommonTextStyle.subHeadingTextStyle
                                .copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                      PickHeightAndWidth.height60,
                      const Center(
                        child: RoundChipWidget(
                          chitTitle: FeedTitles.successfullyClaim,
                          chipTextColor: PickColors.whiteColor,
                          chipColor: PickColors.primaryColor,
                        ),
                      ),
                      PickHeightAndWidth.height5,
                      Row(
                        children: [
                          Expanded(
                            child: CommonMaterialButton(
                              verticalPadding: 5.00,
                              prefixIcon: PickImages.downloadIcon,
                              color: PickColors.whiteColor,
                              borderColor: PickColors.textFieldDisableColor,
                              borderRadius: 50.00,
                              title: FeedTitles.downloadInvoice,
                              style: CommonTextStyle.subHeadingTextStyle
                                  .copyWith(fontSize: 11),
                              onPressed: () {},
                            ),
                          ),
                          PickHeightAndWidth.width5,
                          Expanded(
                            child: CommonMaterialButton(
                              verticalPadding: 5.00,
                              prefixIcon: PickImages.transactionHistoryIcon,
                              color: PickColors.whiteColor,
                              borderColor: PickColors.textFieldDisableColor,
                              borderRadius: 50.00,
                              title: FeedTitles.transactionHistory,
                              style: CommonTextStyle.subHeadingTextStyle
                                  .copyWith(fontSize: 11),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      PickHeightAndWidth.height5,
                      CommonMaterialButton(
                        verticalPadding: 15,
                        title: FeedTitles.backToHome,
                        onPressed: () {
                          // changeScreen(
                          //   context: context,
                          //   widget: const DisplayFeedScreen(),
                          // );
                        },
                        color: PickColors.textFieldTextColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
