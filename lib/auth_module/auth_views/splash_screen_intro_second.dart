// import 'package:flutter/material.dart';
// import 'package:shah_investment/auth_module/auth_titles.dart';
// import 'package:shah_investment/auth_module/auth_views/phone_number_sign_in.dart';
// import 'package:shah_investment/constants/colors.dart';
// import 'package:shah_investment/constants/images_route.dart';
// import 'package:shah_investment/constants/navigation_screen.dart';
// import 'package:shah_investment/constants/pick_height_width.dart';
// import 'package:shah_investment/constants/size_config.dart';
// import 'package:shah_investment/constants/text_style.dart';

// import 'package:shah_investment/widgets/back_ground_animation/back_ground_animation.dart';
// import 'package:shah_investment/widgets/buttons/primary_button.dart';
// import 'package:widget_and_text_animator/widget_and_text_animator.dart';

// class SplashScreenIntroSecond extends StatefulWidget {
//   const SplashScreenIntroSecond({super.key});

//   @override
//   State<SplashScreenIntroSecond> createState() =>
//       _SplashScreenIntroSecondState();
// }

// class _SplashScreenIntroSecondState extends State<SplashScreenIntroSecond> {
//   int currentIndex = 0;

// //   @override

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Stack(children: [
//           const SizedBox(
//             height: double.infinity,
//             width: double.infinity,
//             child: BackgroundAnimation(
//               imagePaths: [
//                 PickImages.backGroundImageVariant1,
//                 PickImages.backGroundImageVariant2,
//                 PickImages.backGroundImageVariant3,
//                 PickImages.backGroundImageVariant4,
//               ],
//               currentIndex: 3,
//             ),
//           ),
//           Column(
//             children: [
//               Expanded(
//                   child: Padding(
//                 padding: EdgeInsets.only(top: SizeConfig.screenHeight! * 0.1),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       WidgetAnimator(
//                         incomingEffect:
//                             WidgetTransitionEffects.incomingSlideInFromRight(
//                                 duration: const Duration(milliseconds: 2000)),
//                         child: Text(
//                           SplashScreenTitles.mainTitlesSecondIntoScreen,
//                           style: CommonTextStyle.mainHeadingTextStyle.copyWith(
//                             fontSize: 35,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ),
//                       PickHeightAndWidth.height15,
//                       Text(
//                         SplashScreenTitles.noteFirstLineTitlesIntoScreen,
//                         style: CommonTextStyle.noteTextStyle.copyWith(
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               )),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Container(
//                     height: SizeConfig.screenHeight! * 0.42,
//                     child: Image.asset(
//                       PickImages.secondIntroImage,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ],
//               ),
//               PickHeightAndWidth.height25,
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: _buildIndicator(),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(20)),
//                     color: PickColors.primaryColor,
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           flex: 1,
//                           child: CommonMaterialButton(
//                             title: "",
//                             prefixIcon: PickImages.undoIntroSvg,
//                             color: PickColors.primaryColor,
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             verticalPadding: SizeConfig.screenHeight! * 0.03,
//                             borderRadius: 20,
//                           ),
//                         ),
//                         Expanded(
//                           flex: 3,
//                           child: CommonMaterialButton(
//                             title: SplashScreenTitles.getStarted,
//                             style: CommonTextStyle.buttonTextStyle
//                                 .copyWith(color: PickColors.textFieldTextColor),
//                             color: PickColors.whiteColor,
//                             onPressed: () {
//                               changePushReplacementScreen(
//                                   context: context,
//                                   widget: const PhoneNumberSignInScreen());
//                             },
//                             verticalPadding: SizeConfig.screenHeight! * 0.03,
//                             borderRadius: 20,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           )
//         ]),
//       ),
//     );
//   }

//   Widget _indicator(bool isActive) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       height: 3,
//       width: isActive ? 30 : 6,
//       margin: const EdgeInsets.only(right: 5),
//       decoration: BoxDecoration(
//           color: isActive ? PickColors.primaryColor : PickColors.hintTextColor,
//           borderRadius: BorderRadius.circular(5)),
//     );
//   }

//   List<Widget> _buildIndicator() {
//     List<Widget> indicators = [];
//     for (int i = 0; i < 2; i++) {
//       if (currentIndex == i) {
//         indicators.add(_indicator(true));
//       } else {
//         indicators.add(_indicator(false));
//       }
//     }

//     return indicators;
//   }
// }
