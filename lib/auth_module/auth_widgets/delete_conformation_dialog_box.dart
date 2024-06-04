// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shah_investment/auth_module/auth_provider.dart';
import 'package:shah_investment/auth_module/auth_views/phone_number_sign_in.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/navigation_screen.dart';
import 'package:shah_investment/constants/pick_height_width.dart';
import 'package:shah_investment/constants/share_preference.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/trades_module/trade_titles.dart';
import 'package:shah_investment/widgets/buttons/primary_button.dart';
import 'package:shah_investment/widgets/loaders/show_overlay_loader.dart';

Future<void> confirmDelete(
    {required BuildContext context,
    required String reason,
    required String description}) async {
  await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.00),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    child: const Icon(
                      Icons.close,
                    ),
                    onTap: () {
                      backToScreen(context: context);
                    },
                  ),
                ),
                PickHeightAndWidth.height25,
                Text(
                  'Delete Account',
                  textAlign: TextAlign.center,
                  style: CommonTextStyle.textFieldTextStyle.copyWith(
                      color: PickColors.blackColor,
                      fontWeight: FontWeight.w900),
                ),
                PickHeightAndWidth.height35,
                CommonMaterialButton(
                  title: "Delete Account Temporary",
                  onPressed: () async {
                    final authProvider =
                        Provider.of<AuthProvider>(context, listen: false);
                    showOverlayLoader(context);
                    if (await authProvider.softAndHardDeleteApiService(
                        description: description,
                        reason: reason,
                        isHardDelete: false,
                        context: context)) {
                      await Shared_Preferences.clearAllPref();
                      hideOverlayLoader();
                      changePushReplacementScreen(
                          context: context,
                          widget: const PhoneNumberSignInScreen());
                    } else {
                      hideOverlayLoader();
                    }
                  },
                  color: PickColors.redColor,
                  // borderRadius: 30,
                  verticalPadding: 16,
                ),
                PickHeightAndWidth.height20,
                Text(
                  "- ${TradeTitles.deleteAccountDescription}",
                  // '- Loose your Encrypted Secure Blockchain ZiD wallet identity,#unRestorable spacial offer',
                  textAlign: TextAlign.start,
                  style: CommonTextStyle.noteTextStyle.copyWith(
                    color: PickColors.blackColor,
                  ),
                ),
                PickHeightAndWidth.height30,
                // CommonMaterialButton(
                //   title: "Delete Account Permanently",
                //   onPressed: () async {
                //     final authProvider =
                //         Provider.of<AuthProvider>(context, listen: false);
                //     showOverlayLoader(context);
                //     if (await authProvider.softAndHardDeleteApiService(
                //         description: description,
                //         reason: reason,
                //         isHardDelete: true,
                //         context: context)) {
                //       await Shared_Preferences.clearAllPref();
                //       hideOverlayLoader();
                //       changePushReplacementScreen(
                //           context: context,
                //           widget: const PhoneNumberSignInScreen());
                //     } else {
                //       hideOverlayLoader();
                //     }
                //   },
                //   color: PickColors.redColor,
                //   // borderRadius: 30,
                //   verticalPadding: 16,
                // ),
                // PickHeightAndWidth.height20,
                // Text(
                //   "- ${TradeTitles.deleteAccountDescription}",
                //   textAlign: TextAlign.start,
                //   style: CommonTextStyle.noteTextStyle.copyWith(
                //     color: PickColors.blackColor,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
