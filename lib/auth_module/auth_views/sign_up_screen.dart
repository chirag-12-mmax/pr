import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shah_investment/auth_module/auth_titles.dart';
import 'package:shah_investment/auth_module/auth_views/phone_number_sign_in.dart';
import 'package:shah_investment/auth_module/auth_widgets/footer_widget.dart';
import 'package:shah_investment/auth_module/auth_widgets/header_widget.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/images_route.dart';
import 'package:shah_investment/constants/navigation_screen.dart';
import 'package:shah_investment/constants/pick_height_width.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/constants/validations_keys.dart';
import 'package:shah_investment/widgets/buttons/primary_button.dart';
import 'package:shah_investment/widgets/form_controls/text_field_control.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isObscurePassword = false;
  bool _isObscureReTypePassword = false;

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: PickColors.whiteColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                HeaderWidget(
                  mainTitle: AuthTitles.hello,
                  subTitle: AuthTitles.there,
                  description: AuthTitles.signUpBio,
                  skipButtonOnTap: () {},
                ),
                PickHeightAndWidth.height15,
                CommonFormBuilderTextField(
                  fieldKey: 'emailKey',
                  hint: AuthTitles.email,
                  isRequired: true,
                  validationKey: ValidationKeys.emailKey,
                  prefix: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SvgPicture.asset(
                      PickImages.mailIcon,
                    ),
                  ),
                ),
                CommonFormBuilderTextField(
                  isObSecure: _isObscurePassword,
                  fieldKey: 'passWordKey',
                  hint: AuthTitles.password,
                  isRequired: true,
                  validationKey: ValidationKeys.passwordKey,
                  prefix: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SvgPicture.asset(
                      PickImages.lockIcon,
                    ),
                  ),
                  suffix: InkWell(
                    onTap: () {
                      setState(
                        () {
                          _isObscurePassword = !_isObscurePassword;
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        _isObscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                  ),
                ),
                CommonFormBuilderTextField(
                  isObSecure: _isObscureReTypePassword,
                  fieldKey: 'confirmPassword',
                  hint: AuthTitles.reTypeYourPassword,
                  isRequired: true,
                  validationKey: ValidationKeys.passwordKey,
                  prefix: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SvgPicture.asset(
                      PickImages.lockIcon,
                    ),
                  ),
                  suffix: InkWell(
                    onTap: () {
                      setState(
                        () {
                          _isObscureReTypePassword = !_isObscureReTypePassword;
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        _isObscureReTypePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                  ),
                ),
                PickHeightAndWidth.height5,
                RichText(
                  // maxLines: 2,
                  // textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "By signing up, you agree to our ",
                    style: CommonTextStyle.noteTextStyle,
                    children: [
                      TextSpan(
                        // recognizer: recognizer,
                        text: "Terms of service ",
                        style: CommonTextStyle.noteTextStyle
                            .copyWith(color: PickColors.primaryColor),
                      ),
                      const TextSpan(
                          // recognizer: recognizer,
                          text: "and ",
                          style: CommonTextStyle.noteTextStyle),
                      TextSpan(
                        // recognizer: recognizer,
                        text: "Privacy Policy",
                        style: CommonTextStyle.noteTextStyle
                            .copyWith(color: PickColors.primaryColor),
                      ),
                    ],
                  ),
                ),
                PickHeightAndWidth.height20,
                CommonMaterialButton(
                  verticalPadding: 24,
                  borderRadius: 16,
                  title: AuthTitles.signUp,
                  onPressed: () {},
                ),
                FooterWidget(
                  mainTitle: AuthTitles.alreadyHaveAnAccount,
                  subTitle: AuthTitles.signIn,
                  prefixIcon: PickImages.phoneIcon,
                  buttonName: AuthTitles.continueWithPhoneNumber,
                  buttonOnTap: () {
                    changeScreen(
                      context: context,
                      widget: const PhoneNumberSignInScreen(),
                    );
                  },
                  richTextOnTap: null,
                ),
                PickHeightAndWidth.height40,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
