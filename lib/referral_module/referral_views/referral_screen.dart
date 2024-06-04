// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:share_plus/share_plus.dart';

import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shah_investment/auth_module/auth_provider.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/images_route.dart';
import 'package:shah_investment/constants/navigation_screen.dart';
import 'package:shah_investment/constants/pick_height_width.dart';
import 'package:shah_investment/constants/size_config.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/referral_module/referral_provider.dart';
import 'package:shah_investment/referral_module/referral_titles.dart';
import 'package:shah_investment/referral_module/referral_views/referral_history_screen.dart';
import 'package:shah_investment/referral_module/referral_widgets/referral_screen_reward_common.dart';
import 'package:shah_investment/trades_module/trade_views/drawer_screen.dart';
import 'package:shah_investment/widgets/show_toast.dart';
import 'package:social_share/social_share.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({super.key});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  int selectedTabIndex = 0;
  int bottomNavIndex = 0;
  int currentPageIndex = 1;
  int numberOfDataPerPage = 10;

  final ValueNotifier<bool> isPageLoading = ValueNotifier<bool>(false);

  @override
  void initState() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.currentUserData!.benefitsDays.toString();
    final referralProvider =
        Provider.of<ReferralProvider>(context, listen: false);
    referralProvider.getAddressAndReferralDayDataApiService(context: context);
    getReferralHistoryData();

    super.initState();
  }

  Future<void> getReferralHistoryData({bool isFromPageChange = false}) async {
    final referralProvider =
        Provider.of<ReferralProvider>(context, listen: false);

    if (isFromPageChange) {
      currentPageIndex += 1;
      isPageLoading.value = true;
    } else {
      setState(() {
        currentPageIndex = 1;
      });
    }

    await referralProvider.referralHistoryApiService(
      dataParameter: {
        "page": currentPageIndex,
        "limit": numberOfDataPerPage,
        "status": selectedTabIndex,
      },
      context: context,
      isFromLoad: isFromPageChange,
    );

    if (isFromPageChange) {
      isPageLoading.value = false;
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Consumer2(builder: (BuildContext context,
          AuthProvider authProvider,
          ReferralProvider referralProvider,
          snapshot) {
        return Scaffold(
          backgroundColor: PickColors.whiteColor,
          drawerEnableOpenDragGesture: false,
          drawer: const DrawerWidget(),
          body: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        ReferralTitles.together,
                        style: CommonTextStyle.mainHeadingTextStyle.copyWith(
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        ReferralTitles.weAreGoingFurther,
                        style: CommonTextStyle.mainHeadingTextStyle.copyWith(
                          color: PickColors.primaryColor,
                          fontSize: 24,
                        ),
                      ),
                      PickHeightAndWidth.height10,
                      Text(
                          "Refer to your friend and get ${referralProvider.referralDay} days extra on your premium subscription",
                          textAlign: TextAlign.center,
                          style: CommonTextStyle.noteTextStyle)
                    ],
                  ),
                  PickHeightAndWidth.height30,
                  Center(
                    child: Text(
                      ReferralTitles.shareLinkOnSocialMedia,
                      style: CommonTextStyle.noteTextStyle.copyWith(
                        letterSpacing: 1.20,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  PickHeightAndWidth.height10,
                  // SizedBox(
                  //   height: SizeConfig.screenHeight! * 0.075,
                  //   width: double.infinity,
                  //   child: ListView.builder(
                  //     itemCount: GlobalList.socialMediaIconList.length,
                  //     shrinkWrap: true,
                  //     scrollDirection: Axis.horizontal,
                  //     itemBuilder: (context, index) {
                  //       return Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 2),
                  //         child: GestureDetector(
                  //           onTap: () {
                  //             if (GlobalList.socialMediaIconList[index]["id"] ==
                  //                 1) {
                  //               SocialShare.shareWhatsapp(
                  //                 authProvider.currentUserData?.referralCode ??
                  //                     "-",
                  //               );
                  //             } else if (GlobalList.socialMediaIconList[index]
                  //                     ["id"] ==
                  //                 2) {
                  //               SocialShare.shareOptions(authProvider
                  //                       .currentUserData?.referralCode ??
                  //                   "-");
                  //             } else if (GlobalList.socialMediaIconList[index]
                  //                     ["id"] ==
                  //                 3) {
                  //               SocialShare.shareOptions(authProvider
                  //                       .currentUserData?.referralCode ??
                  //                   "-");
                  //             } else if (GlobalList.socialMediaIconList[index]
                  //                     ["id"] ==
                  //                 4) {
                  //               SocialShare.shareTelegram(authProvider
                  //                       .currentUserData?.referralCode ??
                  //                   "-");
                  //             } else {
                  //               SocialShare.shareOptions(authProvider
                  //                       .currentUserData?.referralCode ??
                  //                   "-");
                  //             }
                  //           },
                  //           child: Container(
                  //               padding: EdgeInsets.symmetric(
                  //                   horizontal:
                  //                       SizeConfig.screenHeight! * 0.03),
                  //               decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(15),
                  //                   color: PickColors.lightGreyColor),
                  //               child: SvgPicture.asset(GlobalList
                  //                   .socialMediaIconList[index]["title"])),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                            onTap: () {
                              shareReferralLink(context);
                              // SocialShare.shareOptions(
                              //     authProvider.currentUserData?.referralCode ??
                              //         "-");
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              decoration: BoxDecoration(
                                color: PickColors.primaryColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    PickImages.invitePersonIcon,
                                  ),
                                  PickHeightAndWidth.width10,
                                  Expanded(
                                    child: Text(
                                      ReferralTitles.inviteFriend,
                                      style: CommonTextStyle.buttonTextStyle
                                          .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  // ignore: deprecated_member_use
                                  SvgPicture.asset(
                                    PickImages.nextIcon,
                                    color: PickColors.whiteColor,
                                  ),
                                ],
                              ),
                            )),
                      ),
                      PickHeightAndWidth.width5,
                      GestureDetector(
                        onTap: () async {
                          await Clipboard.setData(ClipboardData(
                              text:
                                  authProvider.currentUserData?.referralCode ??
                                      "-"));
                          showToast(
                              message: "Copied Successfully!",
                              isPositive: true,
                              context: context);
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: PickColors.lightGreyColor),
                            child: SvgPicture.asset(PickImages.linkImage)),
                      ),
                    ],
                  ),
                  PickHeightAndWidth.height25,
                  Text(
                    ReferralTitles.referralCode,
                    style: CommonTextStyle.noteTextStyle.copyWith(
                      fontSize: 13,
                    ),
                  ),
                  PickHeightAndWidth.height10,
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: PickColors.textFieldBorderColor),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(children: [
                      Expanded(
                        child: Text(
                          authProvider.currentUserData?.referralCode ?? "-",
                          style: CommonTextStyle.noteTextStyle.copyWith(
                            color: PickColors.primaryColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await Clipboard.setData(ClipboardData(
                              text:
                                  authProvider.currentUserData?.referralCode ??
                                      "-"));
                          showToast(
                              message: "Copied Successfully!",
                              isPositive: true,
                              context: context);
                        },
                        child: SvgPicture.asset(PickImages.copyIcon),
                      )
                    ]),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight! / 12,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CommonReferralScreenContainer(
                          mainIcon: PickImages.rewardIcon,
                          // mainText: authProvider.currentUserData!.benefitsDays
                          //         .toString() +
                          //     " " +
                          //     ReferralTitles.fifteenDay,
                          mainText:
                              "${authProvider.currentUserData!.benefitsDays ?? 0} ${ReferralTitles.fifteenDay}",
                          subText: ReferralTitles.reward,
                          mainTextTextStyle:
                              CommonTextStyle.mainHeadingTextStyle.copyWith(
                                  color: PickColors.primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800),
                        ),
                      ),
                      PickHeightAndWidth.width10,
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            changeScreen(
                                context: context,
                                widget: const ReferralHistoryScreen());
                          },
                          child: CommonReferralScreenContainer(
                            mainIcon: PickImages.addPersonIcon,
                            // mainText: ((authProvider
                            //             .currentUserData?.referralUser?.length) ??
                            //         "-")
                            // .toString(),
                            mainText: referralProvider.totalReferralHistoryCount
                                .toString(),
                            subText: ReferralTitles.friendsInvited,
                            mainTextTextStyle:
                                CommonTextStyle.mainHeadingTextStyle.copyWith(
                                    fontSize: 18, fontWeight: FontWeight.w800),
                          ),
                        ),
                      )
                    ],
                  ),
                  PickHeightAndWidth.height20,
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Future<File> _loadImage() async {
    final byteData = await rootBundle.load(PickImages.applicationLogo);
    final file =
        File('${(await getTemporaryDirectory()).path}/referral_image.png');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file;
  }

  void shareReferralLink(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final RenderBox box = context.findRenderObject() as RenderBox;
    final file = await _loadImage();

    await Share.shareXFiles(
      [XFile(file.path)],
      text:
          'Join the app using my referral code ${authProvider.currentUserData?.referralCode}! Click here: ${authProvider.currentUserData?.referralCode}',
      subject: 'Invite to Our App',
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }
}
