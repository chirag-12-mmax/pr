// ignore_for_file: use_build_context_synchronously
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shah_investment/app_policy_condition/privacy_policy.dart';
import 'package:shah_investment/app_policy_condition/terms_and_conditions.dart';
import 'package:shah_investment/auth_module/auth_provider.dart';
import 'package:shah_investment/auth_module/auth_titles.dart';
import 'package:shah_investment/auth_module/auth_views/phone_number_sign_in.dart';
import 'package:shah_investment/auth_module/auth_views/welcome_animation_screen.dart';
import 'package:shah_investment/auth_module/auth_widgets/header_widget.dart';
import 'package:shah_investment/auth_module/auth_widgets/rich_text_widget.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/images_route.dart';
import 'package:shah_investment/constants/navigation_screen.dart';
import 'package:shah_investment/constants/pick_height_width.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/constants/validations_keys.dart';
import 'package:shah_investment/general_helper.dart';
import 'package:shah_investment/widgets/buttons/primary_button.dart';
import 'package:shah_investment/widgets/form_controls/text_field_control.dart';
import 'package:shah_investment/widgets/image_picker.dart';
import 'package:shah_investment/widgets/loaders/show_overlay_loader.dart';
import 'package:shah_investment/widgets/show_toast.dart';

class ProfileScreen extends StatefulWidget {
  final bool isEdit;
  const ProfileScreen({super.key, this.isEdit = false});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _updateProfileKey = GlobalKey<FormBuilderState>();
  bool checkBoxValue = false;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, AuthProvider authProvider, snapshot) {
      return Scaffold(
        backgroundColor: PickColors.whiteColor,
        appBar: widget.isEdit == true
            ? AppBar(
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
              )
            : null,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              child: FormBuilder(
                initialValue: widget.isEdit
                    ? {
                        "profileImage": [
                          authProvider.currentUserData!.profileImage ?? ""
                        ],
                        "name": authProvider.currentUserData!.name ?? "",
                        "email": authProvider.currentUserData!.email ?? "",
                      }
                    : {},
                key: _updateProfileKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    !widget.isEdit
                        ? HeaderWidget(
                            mainTitle: AuthTitles.update,
                            subTitle: AuthTitles.profile,
                            description: AuthTitles.signUpBio,
                            skipButtonOnTap: () {},
                          )
                        : HeaderWidget(
                            showDescription: false,
                            mainTitle: AuthTitles.update,
                            subTitle: AuthTitles.profile,
                            skipButtonOnTap: () {},
                          ),
                    PickHeightAndWidth.height15,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Expanded(
                          child: ImagePickerControl(
                            isCandidatePhotoLabel: false,
                            isRequired: true,
                            isEnabled: true,
                            fieldName: "profileImage",
                            isProfile: true,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(AuthTitles.upLoadProfile,
                                style: CommonTextStyle.textFieldTextStyle
                                    .copyWith(color: PickColors.hintTextColor)),
                          ),
                        ),
                      ],
                    ),
                    PickHeightAndWidth.height15,
                    CommonFormBuilderTextField(
                      verticalPadding: 0,
                      fieldKey: 'name',
                      hint: AuthTitles.name,
                      isRequired: true,
                      validationKey: ValidationKeys.name,
                      prefix: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: SvgPicture.asset(
                          PickImages.referralIcon,
                        ),
                      ),
                    ),
                    PickHeightAndWidth.height5,
                    CommonFormBuilderTextField(
                      customValidation: (value) {
                        if ((value ?? "").toString() != "") {
                          RegExp regex = RegExp(
                            r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                          );

                          if (value != null && !regex.hasMatch(value)) {
                            return 'Please Enter Valid Email';
                          }

                          return null;
                        } else {
                          return "Email Can't be Empty";
                        }
                      },
                      fieldKey: 'email',
                      hint: AuthTitles.email,
                      isRequired: true,
                      validationKey: ValidationKeys.emailKey,
                      prefix: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: SvgPicture.asset(
                          PickImages.mailIcon,
                        ),
                      ),
                    ),
                    PickHeightAndWidth.height10,
                    !widget.isEdit
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                  value: checkBoxValue,
                                  checkColor: PickColors.whiteColor,
                                  activeColor: PickColors.primaryColor,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  onChanged: (changedValue) {
                                    setState(() {
                                      checkBoxValue = changedValue!;
                                    });
                                  }),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    text: "By signing up, you agree to our ",
                                    style:
                                        CommonTextStyle.noteTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                    children: [
                                      TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            changeScreen(
                                                context: context,
                                                widget:
                                                    const TermsAndConditions());
                                          },
                                        text: "Terms of service",
                                        style: CommonTextStyle.noteTextStyle
                                            .copyWith(
                                                color: PickColors.primaryColor),
                                      ),
                                      TextSpan(
                                        text: " and ",
                                        style: CommonTextStyle.noteTextStyle
                                            .copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      // const TextSpan(
                                      //     text: ", ",
                                      //     style: CommonTextStyle.noteTextStyle),
                                      TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            changeScreen(
                                                context: context,
                                                widget: const PrivacyPolicy());
                                          },
                                        text: "Privacy Policy",
                                        style: CommonTextStyle.noteTextStyle
                                            .copyWith(
                                                color: PickColors.primaryColor),
                                      ),

                                      // TextSpan(
                                      //   recognizer: TapGestureRecognizer()
                                      //     ..onTap = () {
                                      //       changeScreen(
                                      //           context: context,
                                      //           widget:
                                      //               const RefundReturnPolicy());
                                      //     },
                                      //   text: "Refund Return Policy",
                                      //   style: CommonTextStyle.noteTextStyle
                                      //       .copyWith(
                                      //           color: PickColors.primaryColor),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    PickHeightAndWidth.height25,
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
                  title: AuthTitles.updateProfile,
                  onPressed: () async {
                    _updateProfileKey.currentState!.save();
                    final generalHelperProvider =
                        Provider.of<GeneralHelper>(context, listen: false);

                    final authProvider =
                        Provider.of<AuthProvider>(context, listen: false);
                    String? upLoadImageUrl;

                    if (!widget.isEdit) {
                      if (_updateProfileKey.currentState!.validate()) {
                        if (checkBoxValue) {
                          showOverlayLoader(context);

                          upLoadImageUrl =
                              await generalHelperProvider.imageUploadService(
                                  fieName: _updateProfileKey.currentState!
                                      .value['profileImage'].last.name,
                                  fileByteData: await _updateProfileKey
                                      .currentState!.value['profileImage'].last
                                      .readAsBytes(),
                                  context: context);

                          if (upLoadImageUrl != null && upLoadImageUrl != "") {
                            if (await authProvider.profileUpdateApiService(
                                context: context,
                                dataParameter: {
                                  "name": _updateProfileKey
                                          .currentState!.value['name'] ??
                                      "",
                                  "email": _updateProfileKey
                                          .currentState!.value['email'] ??
                                      "",
                                  "profileImage": upLoadImageUrl,
                                  "termsAgree": checkBoxValue ? 1 : 0
                                })) {
                              hideOverlayLoader();
                              changeScreen(
                                context: context,
                                widget: const WelcomeScreen(),
                              );
                            } else {
                              hideOverlayLoader();
                            }
                          } else {
                            showToast(
                                message: "Image cant't be empty",
                                isPositive: false,
                                context: context);
                            hideOverlayLoader();
                          }
                        } else {
                          showToast(
                              message:
                                  "Please select Terms of Service or Privacy Policy",
                              isPositive: false,
                              context: context);
                          hideOverlayLoader();
                        }
                      }
                    } else {
                      if (_updateProfileKey.currentState!.validate()) {
                        if (authProvider.currentUserData!.profileImage !=
                                null &&
                            authProvider.currentUserData!.profileImage != "") {
                          upLoadImageUrl =
                              authProvider.currentUserData!.profileImage;
                        } else {
                          upLoadImageUrl =
                              await generalHelperProvider.imageUploadService(
                                  fieName: _updateProfileKey.currentState!
                                      .value['profileImage'].last.name,
                                  fileByteData: await _updateProfileKey
                                      .currentState!.value['profileImage'].last
                                      .readAsBytes(),
                                  context: context);
                        }

                        if (upLoadImageUrl != null && upLoadImageUrl != "") {
                          if (await authProvider.profileUpdateApiService(
                              context: context,
                              dataParameter: {
                                "name": _updateProfileKey
                                        .currentState!.value['name'] ??
                                    "",
                                "email": _updateProfileKey
                                        .currentState!.value['email'] ??
                                    "",
                                "profileImage": upLoadImageUrl,
                                "termsAgree":
                                    authProvider.currentUserData!.termsAgree ??
                                        0,
                              })) {
                            hideOverlayLoader();
                          } else {
                            hideOverlayLoader();
                          }
                        } else {
                          showToast(
                              message: "Please select profile image",
                              isPositive: false,
                              context: context);
                          hideOverlayLoader();
                        }
                      }
                    }
                  }),
              !widget.isEdit ? PickHeightAndWidth.height20 : Container(),
              !widget.isEdit
                  ? Align(
                      alignment: Alignment.center,
                      child: RichTextWidget(
                        mainTitle: AuthTitles.alreadyHaveAnAccount,
                        subTitle: AuthTitles.signIn,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            changeScreen(
                              context: context,
                              widget: const PhoneNumberSignInScreen(),
                            );
                          },
                      ),
                    )
                  : Container(),
              PickHeightAndWidth.height15,
            ],
          ),
        ),
      );
    });
  }
}
