import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shah_investment/app_policy_condition/privacy_policy.dart';
import 'package:shah_investment/app_policy_condition/refund_return_policy.dart';
import 'package:shah_investment/app_policy_condition/terms_and_conditions.dart';
import 'package:shah_investment/auth_module/auth_provider.dart';
import 'package:shah_investment/auth_module/auth_views/phone_number_sign_in.dart';
import 'package:shah_investment/auth_module/auth_views/profile_screen.dart';
import 'package:shah_investment/auth_module/auth_views/setting_screen.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/global_list.dart';
import 'package:shah_investment/constants/images_route.dart';
import 'package:shah_investment/constants/navigation_screen.dart';
import 'package:shah_investment/constants/pick_height_width.dart';
import 'package:shah_investment/constants/share_preference.dart';
import 'package:shah_investment/constants/size_config.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/general_helper.dart';
import 'package:shah_investment/referral_module/referral_views/referral_history_screen.dart';
import 'package:shah_investment/subscription_module/subscription_views/subscription_history_screen.dart';
import 'package:shah_investment/trades_module/trade_provider.dart';
import 'package:shah_investment/trades_module/trade_titles.dart';
import 'package:shah_investment/trades_module/trade_views/notification_screen.dart';
import 'package:shah_investment/widgets/dialogs/common_confirmation_dialog_box.dart';
import 'package:shah_investment/widgets/network_image_builder.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerWidget extends StatefulWidget {
  // bool isShow = true;
  const DrawerWidget({
    super.key,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: SizeConfig.screenWidth! * 0.9,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: PickColors.whiteColor,
      child: Consumer3(builder: (BuildContext context, GeneralHelper helper,
          AuthProvider authProvider, TradeProvider tradeProvider, snapshot) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.00, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 50.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          BuildLogoProfileImageWidget(
                            isColors: true,
                            height: 70.00,
                            width: 70.00,
                            imagePath:
                                authProvider.currentUserData?.profileImage ??
                                    "-",
                            titleName:
                                authProvider.currentUserData?.name ?? "-",
                            borderRadius: BorderRadius.circular(50),
                          ),
                          PickHeightAndWidth.width10,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  authProvider.currentUserData?.name ?? "-",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: CommonTextStyle.chipTextStyle.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                PickHeightAndWidth.height5,
                                Text(
                                  "${authProvider.currentUserData?.countryCode ?? ""} ${(authProvider.currentUserData?.mobileNo ?? "-").toString()}",
                                  style: CommonTextStyle.noteTextStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                changeScreen(
                                  context: context,
                                  widget: const ProfileScreen(
                                    isEdit: true,
                                  ),
                                );
                              },
                              child: SvgPicture.asset(PickImages.editIcon))
                        ],
                      ),
                      PickHeightAndWidth.height10,
                      const Divider(
                        thickness: 2,
                        color: PickColors.textFieldBorderColor,
                      ),
                      // PickHeightAndWidth.height10,
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: GlobalList.drawerList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              if (GlobalList.drawerList[index]["id"] == 1) {
                                backToScreen(context: context);
                                tradeProvider.changeBottomBarIndex(
                                    selectedIndex: 1);
                              } else if (GlobalList.drawerList[index]["id"] ==
                                  2) {
                                backToScreen(context: context);
                                changeScreen(
                                    context: context,
                                    widget: const ReferralHistoryScreen());
                              } else if (GlobalList.drawerList[index]["id"] ==
                                  3) {
                                backToScreen(context: context);
                                changeScreen(
                                    context: context,
                                    widget: const SubscriptionHistoryScreen());
                              } else if (GlobalList.drawerList[index]["id"] ==
                                  4) {
                                backToScreen(context: context);
                                tradeProvider.changeBottomBarIndex(
                                    selectedIndex: 2);
                              } else if (GlobalList.drawerList[index]["id"] ==
                                  5) {
                                backToScreen(context: context);
                                changeScreen(
                                    context: context,
                                    widget: const NotiFicationScreen());
                              } else if (GlobalList.drawerList[index]["id"] ==
                                  6) {
                                backToScreen(context: context);
                                changeScreen(
                                    context: context,
                                    widget: const SettingScreen());
                              } else if (GlobalList.drawerList[index]["id"] ==
                                  7) {
                                backToScreen(context: context);
                                changeScreen(
                                    context: context,
                                    widget: const PrivacyPolicy());
                              } else if (GlobalList.drawerList[index]["id"] ==
                                  8) {
                                backToScreen(context: context);
                                changeScreen(
                                    context: context,
                                    widget: const TermsAndConditions());
                              } else if (GlobalList.drawerList[index]["id"] ==
                                  9) {
                                backToScreen(context: context);
                                changeScreen(
                                    context: context,
                                    widget: const RefundReturnPolicy());
                              } else if (GlobalList.drawerList[index]["id"] ==
                                  10) {
                                await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CommonConfirmationDialogBox(
                                      title: helper.translateTextTitle(
                                              titleText: "Confirmation") ??
                                          "-",
                                      buttonTitle: helper.translateTextTitle(
                                              titleText: "Log Out") ??
                                          "-",
                                      subTitle: helper.translateTextTitle(
                                          titleText:
                                              "Are you sure you want to Logout ?"),
                                      onPressButton: () async {
                                        await Shared_Preferences.clearAllPref();
                                        tradeProvider.changeBottomBarIndex(
                                            selectedIndex: 1);
                                        changeScreenWithClearStack(
                                            context: context,
                                            widget:
                                                const PhoneNumberSignInScreen());
                                      },
                                      isCancel: true,
                                    );
                                  },
                                );
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                      GlobalList.drawerList[index]["icon"]),
                                  PickHeightAndWidth.width10,
                                  Text(
                                    GlobalList.drawerList[index]["title"],
                                    style:
                                        CommonTextStyle.noteTextStyle.copyWith(
                                      color: PickColors.textFieldTextColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  PickHeightAndWidth.height30,
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SvgPicture.asset(PickImages.frameImage),
                PickHeightAndWidth.height10,
                Text(
                  TradeTitles.letsFullFillDreams,
                  style: CommonTextStyle.textFieldTextStyle.copyWith(
                    fontWeight: FontWeight.w700,
                    // fontSize: 18,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    const url = 'https://shahsinvestment.com/';
                    // ignore: deprecated_member_use
                    if (await canLaunch(url)) {
                      // ignore: deprecated_member_use
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Text(
                    TradeTitles.shahInvestment,
                    style: CommonTextStyle.textFieldTextStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        color: PickColors.primaryColor),
                  ),
                ),
                PickHeightAndWidth.height10,
                const Divider(
                  color: PickColors.textFieldBorderColor,
                ),
                PickHeightAndWidth.height10,
                Text(
                  TradeTitles.version,
                  style: CommonTextStyle.chipTextStyle.copyWith(
                    color: PickColors.hintTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                PickHeightAndWidth.height25,
              ],
            ),
          ),
        );
      }),
    );
  }
}
