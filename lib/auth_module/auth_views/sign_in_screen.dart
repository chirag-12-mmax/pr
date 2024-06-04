import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shah_investment/auth_module/auth_titles.dart';
import 'package:shah_investment/auth_module/auth_views/sign_up_screen.dart';
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

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isObscurePasswordSignIn = false;
  bool isChecked = false;
  bool _isObscurePassword = false;
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
                  mainTitle: AuthTitles.welcome,
                  subTitle: AuthTitles.back,
                  description: AuthTitles.signInBio,
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
                //   CommonFormBuilderTextField(
                //   isObSecure: _isObscurePassword!,
                //   fieldKey: "fd",
                //   hint: "enter Password",
                //   isRequired: true,
                //   validationKey: "password",
                //   suffix: InkWell(
                //     onTap: (){
                //        setState(() {
                //           _isObscurePassword = !_isObscurePassword!;
                //         });
                //     },
                //     child: Icon(
                //         _isObscurePassword! ? Icons.visibility_off : Icons.visibility,
                //         color: PickColors.hintTextColor,
                //       ),),

                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                            value: isChecked,
                            checkColor: PickColors.whiteColor,
                            activeColor: PickColors.primaryColor,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onChanged: (changedValue) {
                              setState(() {
                                isChecked = changedValue!;
                              });
                            }),
                        const Text(
                          AuthTitles.rememberMe,
                          style: CommonTextStyle.noteTextStyle,
                        ),
                      ],
                    ),
                    Text(
                      AuthTitles.forgotPassword,
                      style: CommonTextStyle.noteTextStyle
                          .copyWith(color: PickColors.primaryColor),
                    )
                  ],
                ),
                PickHeightAndWidth.height30,
                CommonMaterialButton(
                  verticalPadding: 24,
                  borderRadius: 16,
                  title: AuthTitles.signIn,
                  onPressed: () {},
                ),
                FooterWidget(
                  mainTitle: AuthTitles.doNotHaveAnAccount,
                  subTitle: AuthTitles.createAnAccount,
                  prefixIcon: PickImages.phoneIcon,
                  buttonName: AuthTitles.continueWithPhoneNumber,
                  buttonOnTap: () {},
                  richTextOnTap: TapGestureRecognizer()
                    ..onTap = () async {
                      changeScreen(
                        context: context,
                        widget: const SignUpScreen(),
                      );
                    },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
