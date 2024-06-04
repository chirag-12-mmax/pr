// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shah_investment/auth_module/auth_provider.dart';
import 'package:shah_investment/auth_module/auth_titles.dart';
import 'package:shah_investment/auth_module/auth_views/otp_screen.dart';
import 'package:shah_investment/auth_module/auth_widgets/country_code_textfield.dart';
import 'package:shah_investment/auth_module/auth_widgets/header_widget.dart';
import 'package:shah_investment/auth_module/auth_widgets/rich_text_widget.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/images_route.dart';
import 'package:shah_investment/constants/navigation_screen.dart';
import 'package:shah_investment/constants/pick_height_width.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/constants/validations_keys.dart';
import 'package:shah_investment/widgets/buttons/primary_button.dart';
import 'package:shah_investment/widgets/form_controls/text_field_control.dart';
import 'package:shah_investment/widgets/loaders/show_overlay_loader.dart';
import 'package:shah_investment/widgets/show_toast.dart';

class PhoneNumberSignInScreen extends StatefulWidget {
  const PhoneNumberSignInScreen({super.key});

  @override
  State<PhoneNumberSignInScreen> createState() =>
      _PhoneNumberSignInScreenState();
}

class _PhoneNumberSignInScreenState extends State<PhoneNumberSignInScreen> {
  bool isNewUser = false;

  final GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController referralController = TextEditingController();
  String? countryCode;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, AuthProvider authProvider, snapshot) {
      return Scaffold(
        backgroundColor: PickColors.whiteColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isNewUser
                        ? HeaderWidget(
                            mainTitle: AuthTitles.hello,
                            subTitle: AuthTitles.there,
                            description: AuthTitles.signInBio,
                            // color: PickColors.textFieldTextColor,
                            skipButtonOnTap: () {},
                          )
                        : HeaderWidget(
                            mainTitle: AuthTitles.welcome,
                            subTitle: AuthTitles.back,
                            description: AuthTitles.signInBio,
                            color: PickColors.textFieldTextColor,
                            skipButtonOnTap: () {},
                          ),
                    PickHeightAndWidth.height50,
                    const Text(
                      AuthTitles.phoneNumber,
                      style: CommonTextStyle.noteTextStyle,
                    ),
                    PickHeightAndWidth.height10,
                    CustomCountryCodeTextField(
                      dropdownTextStyle: CommonTextStyle.textFieldTextStyle
                          .copyWith(color: PickColors.blackColor),
                      flagsButtonPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      controller: mobileNumberController,
                      dropdownIconPosition: IconPosition.trailing,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        hintText: AuthTitles.enterPhoneNumber,
                        counterText: '',
                        hintStyle: CommonTextStyle.textFieldTextStyle
                            .copyWith(color: PickColors.hintTextColor),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(color: PickColors.primaryColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: PickColors.textFieldBorderColor),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: PickColors.textFieldBorderColor),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.00),
                          ),
                        ),
                      ),
                      initialCountryCode: 'IN',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if ((value?.number ?? "") == "") {
                          return "Phone Number can't be empty";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (phone) {
                        setState(() {
                          countryCode = phone.countryCode;
                        });
                      },
                    ),
                    PickHeightAndWidth.height5,
                    if (isNewUser)
                      CommonFormBuilderTextField(
                        textController: referralController,
                        fieldKey: 'referral',
                        hint: AuthTitles.referralCode,
                        isRequired: false,
                        fillColor: PickColors.transparentColor,
                        validationKey: ValidationKeys.referral,
                        prefix: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: SvgPicture.asset(
                            PickImages.mailIcon,
                          ),
                        ),
                      ),
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
                title: AuthTitles.authenticate,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (mobileNumberController.text.isNotEmpty) {
                      showOverlayLoader(context);
                      print(countryCode.toString());
                      if (!isNewUser) {
                        if (await authProvider.sendOtpApiService(
                            context: context,
                            dataParameter: {
                              "mobileNo": mobileNumberController.text,
                              "FTPToken": authProvider.fcmToken ?? "",
                              "countryCode": countryCode ?? "+91"
                            })) {
                          hideOverlayLoader();

                          changeScreen(
                            context: context,
                            widget: OtpScreen(
                              mobileNumber: mobileNumberController.text,
                              countryCode: countryCode ?? "+91",
                            ),
                          );
                        } else {
                          hideOverlayLoader();
                        }
                      } else {
                        if (await authProvider
                            .signUpApiService(context: context, dataParameter: {
                          "mobileNo": mobileNumberController.text,
                          "FTPToken": authProvider.fcmToken ?? "",
                          "countryCode": countryCode ?? "+91",
                          if (referralController.text != "")
                            "userReferralCode": referralController.text
                        })) {
                          hideOverlayLoader();

                          changeScreen(
                            context: context,
                            widget: OtpScreen(
                              mobileNumber: mobileNumberController.text,
                              countryCode: countryCode ?? "+91",
                            ),
                          );
                        } else {
                          hideOverlayLoader();
                        }
                      }
                    } else {
                      showToast(
                          message: "Phone Number Can't be empty",
                          isPositive: false,
                          context: context);
                    }
                  }
                },
              ),
              PickHeightAndWidth.height25,
              isNewUser
                  ? Align(
                      alignment: Alignment.center,
                      child: RichTextWidget(
                        mainTitle: AuthTitles.alreadyHaveAnAccount,
                        subTitle: AuthTitles.signIn,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            setState(() {
                              isNewUser = !isNewUser;
                            });
                          },
                      ),
                    )
                  : Align(
                      alignment: Alignment.center,
                      child: RichTextWidget(
                        mainTitle: AuthTitles.doNotHaveAnAccount,
                        subTitle: AuthTitles.createAnAccount,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            setState(() {
                              isNewUser = !isNewUser;
                            });
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
