// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shah_investment/auth_module/auth_provider.dart';
import 'package:shah_investment/auth_module/auth_titles.dart';
import 'package:shah_investment/auth_module/auth_views/phone_number_sign_in.dart';
import 'package:shah_investment/auth_module/auth_views/profile_screen.dart';
import 'package:shah_investment/auth_module/auth_widgets/common_otp_field.dart';
import 'package:shah_investment/auth_module/auth_widgets/header_widget.dart';
import 'package:shah_investment/auth_module/auth_widgets/rich_text_widget.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/navigation_screen.dart';
import 'package:shah_investment/constants/pick_height_width.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/trades_module/trade_views/master_screen.dart';
import 'package:shah_investment/widgets/buttons/primary_button.dart';
import 'package:shah_investment/widgets/loaders/show_overlay_loader.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;
  final String countryCode;

  const OtpScreen(
      {super.key, required this.mobileNumber, required this.countryCode});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpCodeController = TextEditingController();
  bool hasError = false;
  String errorText = "OTP can't be blank or less then 6 digit";
  int secondsRemaining = 59;
  bool enableResend = false;
  Timer? timer;
  final GlobalKey<FormState> _otpKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
    otpTimer();
  }

  otpTimer() async {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining = secondsRemaining - 1;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  void resendCode() async {
    setState(() {
      secondsRemaining = 59;
      enableResend = false;
    });
  }

  @override
  dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, AuthProvider authProvider, snapshot) {
      return Scaffold(
        backgroundColor: PickColors.whiteColor,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _otpKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderWidget(
                      mainTitle: AuthTitles.authenticate,
                      subTitle: AuthTitles.yourAccount,
                      description: AuthTitles.otpDescription,
                      skipButtonOnTap: () {},
                    ),
                    PickHeightAndWidth.height10,
                    if (!enableResend)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Resend OTP in $secondsRemaining seconds',
                            style: CommonTextStyle.noteTextStyle.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    PickHeightAndWidth.height40,
                    CustomPinCodeView(
                      autoFocus: false,
                      newContext: context,
                      textEditingController: otpCodeController,
                      pinBoxColor: PickColors.whiteColor,
                      horizontal: 6.0,
                      pinBoxHeight: 50,
                      isRequired: false,
                      isPassword: true,
                      pinLength: 6,
                      pinBoxWidth: 60,
                      hasError: hasError,
                      labelText: AuthTitles.securityCodeOtp,
                      borderColor: PickColors.textFieldBorderColor,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (enableResend) {
                          resendCode();
                          if (await authProvider.sendOtpApiService(
                              context: context,
                              dataParameter: {
                                "mobileNo": widget.mobileNumber,
                                "FTPToken": authProvider.fcmToken ?? "",
                                "countryCode": "+91"
                              })) {
                            hideOverlayLoader();
                          } else {
                            hideOverlayLoader();
                          }
                        }
                      },
                      child: Align(
                          alignment: Alignment.topRight,
                          child: enableResend
                              ? Text(
                                  "Resend OTP",
                                  textAlign: TextAlign.right,
                                  style: CommonTextStyle.noteTextStyle
                                      .copyWith(color: PickColors.primaryColor),
                                )
                              : Text(
                                  "Resend OTP",
                                  textAlign: TextAlign.right,
                                  style: CommonTextStyle.noteTextStyle.copyWith(
                                      color: PickColors.textFieldBorderColor),
                                )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CommonMaterialButton(
                verticalPadding: 24,
                borderRadius: 16,
                title: AuthTitles.verifyAccount,
                onPressed: () async {
                  if (_otpKey.currentState!.validate()) {
                    //Check Validation
                    if (otpCodeController.text.length == 6) {
                      setState(() {
                        hasError = false;
                      });
                    } else {
                      setState(() {
                        hasError = true;
                      });
                    }

                    // if (!hasError) {
                    showOverlayLoader(context);
                    if (await authProvider.verifyOtpApiService(
                        context: context,
                        dataParameter: {
                          "mobileNo": widget.mobileNumber,
                          "OTP": otpCodeController.text
                        })) {
                      hideOverlayLoader();

                      if (authProvider.isActive != 0) {
                        changeScreenWithClearStack(
                          context: context,
                          widget: const MasterScreen(),
                        );
                      } else {
                        changeScreenWithClearStack(
                          context: context,
                          widget: const ProfileScreen(),
                        );
                      }
                    } else {
                      hideOverlayLoader();
                    }
                    // }
                  }
                },
              ),
              PickHeightAndWidth.height30,
              Align(
                alignment: Alignment.center,
                child: RichTextWidget(
                  mainTitle: AuthTitles.doNotHaveAnAccount,
                  subTitle: AuthTitles.createAnAccount,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      changeScreenWithClearStack(
                          context: context,
                          widget: const PhoneNumberSignInScreen());
                    },
                ),
              ),
              PickHeightAndWidth.height20,
            ],
          ),
        ),
      );
    });
  }
}
