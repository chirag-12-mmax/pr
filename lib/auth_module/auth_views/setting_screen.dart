// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shah_investment/auth_module/auth_provider.dart';
import 'package:shah_investment/auth_module/auth_titles.dart';
import 'package:shah_investment/auth_module/auth_views/phone_number_sign_in.dart';
import 'package:shah_investment/auth_module/auth_widgets/common_setting_raw_widget.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/images_route.dart';
import 'package:shah_investment/constants/navigation_screen.dart';
import 'package:shah_investment/constants/share_preference.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/general_helper.dart';
import 'package:shah_investment/payment_module/phone_pay_interigate.dart';
import 'package:shah_investment/referral_module/referral_provider.dart';
import 'package:shah_investment/trades_module/trade_provider.dart';
import 'package:shah_investment/trades_module/trade_titles.dart';
import 'package:shah_investment/trades_module/trade_views/delete_account_screen.dart';
import 'package:shah_investment/widgets/buttons/primary_button.dart';
import 'package:shah_investment/widgets/dialogs/common_confirmation_dialog_box.dart';
import 'package:shah_investment/widgets/loaders/show_overlay_loader.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool? _switchValue;

  @override
  void initState() {
    // TODO: implement initState
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _switchValue = authProvider.currentUserData?.autoCut != 0 ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3(builder: (BuildContext context, GeneralHelper helper,
        AuthProvider authProvider, TradeProvider tradeProvider, snapshot) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: PickColors.whiteColor,
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              backToScreen(context: context);
            },
            child: const Icon(
              Icons.arrow_back_sharp,
            ),
          ),
          title: Text(
            AuthTitles.setting,
            style: CommonTextStyle.noteTextStyle.copyWith(
              color: PickColors.blackColor,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                CommonSettingRawWidget(
                  prefixIcon: PickImages.deleteAccountIcon,
                  title: TradeTitles.deleteAccount,
                  onTap: () async {
                    changeScreen(context: context, widget: const MerchantApp()
                        // const DeleteAccountScreen(),
                        );
                  },
                  arrowForwardIcon: () async {
                    changeScreen(
                      context: context,
                      widget: const DeleteAccountScreen(),
                    );
                  },
                ),
                CommonSettingRawWidget(
                  prefixIcon: PickImages.paymentHistoryIcon,
                  title: "Payment setting",
                  isSubtitle: true,
                  subtitle: "Subscription Payment Automatically",
                  widget: Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                      value: _switchValue!,
                      onChanged: (value) async {
                        final referralProvider = Provider.of<ReferralProvider>(
                            context,
                            listen: false);
                        showOverlayLoader(context);
                        if (value) {
                          if (await referralProvider.autoCutPaymentApiService(
                              dataParameter: {"autocut": 1},
                              context: context)) {
                            final authProvider = Provider.of<AuthProvider>(
                                context,
                                listen: false);
                            setState(() {
                              _switchValue = value;
                            });
                            await authProvider.getSingleUserDataService(
                                context: context);
                            hideOverlayLoader();
                          } else {
                            hideOverlayLoader();
                          }
                        } else {
                          if (await referralProvider.autoCutPaymentApiService(
                              dataParameter: {"autocut": 0},
                              context: context)) {
                            hideOverlayLoader();
                            final authProvider = Provider.of<AuthProvider>(
                                context,
                                listen: false);

                            setState(() {
                              _switchValue = value;
                            });
                            await authProvider.getSingleUserDataService(
                                context: context);
                          } else {
                            hideOverlayLoader();
                          }
                        }
                      },
                    ),
                  ),
                  onTap: () async {},
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 15.0, bottom: 15, right: 15),
          child: CommonMaterialButton(
            title: TradeTitles.logout,
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return CommonConfirmationDialogBox(
                    title:
                        helper.translateTextTitle(titleText: "Confirmation") ??
                            "-",
                    buttonTitle:
                        helper.translateTextTitle(titleText: "Log Out") ?? "-",
                    subTitle: helper.translateTextTitle(
                        titleText: "Are you sure you want to Logout ?"),
                    onPressButton: () async {
                      await Shared_Preferences.clearAllPref();

                      tradeProvider.changeBottomBarIndex(selectedIndex: 1);

                      changeScreenWithClearStack(
                          context: context,
                          widget: const PhoneNumberSignInScreen());
                    },
                    isCancel: true,
                  );
                },
              );
            },
            color: PickColors.blackColor,
            prefixIcon: PickImages.logoutIcon,
            prefixIconColor: PickColors.whiteColor,
            borderRadius: 30,
            verticalPadding: 16,
          ),
        ),
      );
    });
  }
}
