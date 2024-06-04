// // ignore_for_file: use_build_context_synchronously

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
// import 'package:shah_investment/constants/colors.dart';
// import 'package:shah_investment/constants/common_titles.dart';
// import 'package:shah_investment/constants/images_route.dart';
// import 'package:shah_investment/constants/navigation_screen.dart';
// import 'package:shah_investment/constants/pick_height_width.dart';
// import 'package:shah_investment/constants/text_style.dart';
// import 'package:shah_investment/widgets/buttons/primary_button.dart';
// import 'package:shah_investment/widgets/rich_text_widget.dart';
// import 'package:sms_autofill/sms_autofill.dart';

// // ignore: constant_identifier_names
// // enum DialogKey { QUICK_PIN, WEB_OTP }

// class RequestOtpDialogBox extends StatefulWidget {
//   final String? applicationId;
//   final String? subscriptionId;
//   final dynamic onSubmitOTP;
//   final int otpLength;
//   final dynamic? onResendOTP;
//   // final DialogKey dialogKey;
//   const RequestOtpDialogBox({
//     super.key,
//     required this.applicationId,
//     required this.subscriptionId,
//     required this.onSubmitOTP,
//     this.onResendOTP,
//     this.otpLength = 5,

//     // required this.dialogKey
//   });

//   @override
//   State<RequestOtpDialogBox> createState() => _RequestOtpDialogBoxState();
// }

// class _RequestOtpDialogBoxState extends State<RequestOtpDialogBox> {
//   int start = 180;
//   late Timer timer;

//   String code = "";

//   bool hasError = false;
//   String errorText = "Please Enter Otp";

//   TextEditingController requestOtpCodeController = TextEditingController();

//   @override
//   void dispose() {
//     timer.cancel();

//     super.dispose();
//   }

//   @override
//   void initState() {
//     startTimer();
//     super.initState();
//   }

//   Future<void> getAutoSms() async {
//     await SmsAutoFill().listenForCode();
//   }

//   startTimer() {
//     const oneSec = Duration(seconds: 1);
//     timer = Timer.periodic(
//       oneSec,
//       (Timer timer) {
//         if (start == 0) {
//           setState(() {
//             timer.cancel();
//           });
//         } else {
//           setState(() {
//             start--;
//           });
//         }
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SimpleDialog(
//       title: GestureDetector(
//         onTap: () {
//           backToScreen(context: context);
//         },
//         child: SvgPicture.asset(
//           alignment: Alignment.centerRight,
//           PickImages.cancelIcon,
//         ),
//       ),
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Column(
//             children: [
//               if (start != 0)
//                 const RichTextWidget(
//                     // fontWeight: FontWeight.normal,
//                     // mainTitleColor: PickColors.primaryColor,
//                     // subTitleColor: PickColors.blackColor,
//                     // mainTitle: "$start ",
//                     // subTitle:
//                     //     helper.currentLanguage!.secsRemainingToRegenerateOTP ??
//                     //         "-",
//                     ),
//               PickHeightAndWidth.height20,
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   // PinFieldAutoFill(
//                   //   codeLength: 5,
//                   //   decoration: BoxLooseDecoration(
//                   //     errorText: hasError ? errorText : "",
//                   //     errorTextStyle: CommonTextStyle()
//                   //         .noteHeadingTextStyle
//                   //         .copyWith(color: PickColors.primaryColor),
//                   //     strokeColorBuilder: const FixedColorBuilder(
//                   //       PickColors.bgColor,
//                   //     ),
//                   //     bgColorBuilder: const FixedColorBuilder(
//                   //       PickColors.bgColor,
//                   //     ),
//                   //   ),
//                   //   currentCode: code,
//                   //   onCodeSubmitted: (code) {},
//                   //   onCodeChanged: (code) {
//                   //     if (code!.length == 5) {
//                   //       FocusScope.of(context).requestFocus(FocusNode());
//                   //     }
//                   //   },
//                   // ),
//                   // FittedBox(
//                   //   child: getOtpCodeField(
//                   //     helper: helper,
//                   //     hasError: hasError,
//                   //     pinBoxLength: widget.otpLength,
//                   //     controller: requestOtpCodeController,
//                   //     pinBoxColor: PickColors.blackColor,
//                   //   ),
//                   // ),
//                   if (hasError && start != 0)
//                     Text(
//                       errorText,
//                       style: CommonTextStyle.buttonTextStyle,
//                     ),
//                   if (start == 0)
//                     const InkWell(
//                         // onTap: () async {
//                         //   final authProvider =
//                         //       Provider.of<AuthProvider>(context, listen: false);

//                         //   if (widget.applicationId != null &&
//                         //       widget.subscriptionId != null) {
//                         //     if (await authProvider.generateOtpApiFunction(
//                         //         applicationId: widget.applicationId!,
//                         //         context: context,
//                         //         subscriptionId: widget.subscriptionId!,
//                         //         helper: helper)) {
//                         //       setState(() {
//                         //         start = 180;
//                         //         startTimer();
//                         //       });
//                         //     }
//                         //   } else {
//                         //     await widget.onResendOTP();
//                         //     setState(() {
//                         //       start = 180;
//                         //       startTimer();
//                         //     });
//                         //   }
//                         // },
//                         // child: Center(
//                         //   child: Text(
//                         //     helper.currentLanguage!.resendOTP ?? "-",
//                         //     style:
//                         //         CommonTextStyle().noteHeadingTextStyle.copyWith(
//                         //               color: PickColors.darkBlueColor,
//                         //               decoration: TextDecoration.underline,
//                         //             ),
//                         //   ),
//                         // ),
//                         ),
//                 ],
//               ),
//               PickHeightAndWidth.height20,
//               Row(
//                 children: [
//                   Expanded(
//                     child: CommonMaterialButton(
//                       borderColor: PickColors.primaryColor,
//                       color: PickColors.whiteColor,
//                       title: Titles.yes,
//                       style: CommonTextStyle.buttonTextStyle,
//                       onPressed: () {
//                         backToScreen(context: context);
//                       },
//                     ),
//                   ),
//                   PickHeightAndWidth.width10,
//                   Expanded(
//                     child: CommonMaterialButton(
//                       title: "Verify",
//                       onPressed: () async {
//                         if (requestOtpCodeController.text.length <
//                             widget.otpLength) {
//                           setState(() {
//                             hasError = true;
//                           });
//                         } else {
//                           setState(() {
//                             hasError = false;
//                           });
//                         }
//                         if (!hasError) {
//                           widget.onSubmitOTP(requestOtpCodeController.text);
//                         }
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
