import 'package:flutter/material.dart';
import 'package:shah_investment/auth_module/auth_titles.dart';
import 'package:shah_investment/auth_module/auth_views/phone_number_sign_in.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/images_route.dart';
import 'package:shah_investment/constants/navigation_screen.dart';
import 'package:shah_investment/constants/size_config.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/widgets/back_ground_animation/back_ground_animation.dart';
import 'package:shah_investment/widgets/buttons/primary_button.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class SplashScreenIntroFirst extends StatefulWidget {
  const SplashScreenIntroFirst({super.key});

  @override
  State<SplashScreenIntroFirst> createState() => _SplashScreenIntroFirstState();
}

class _SplashScreenIntroFirstState extends State<SplashScreenIntroFirst> {
  int currentIndex = 0;

  bool _isFirstTextVisible = true;

  void _toggleTextVisibility() {
    setState(() {
      _isFirstTextVisible = !_isFirstTextVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    print(SizeConfig.screenHeight!.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: Stack(children: [
          const BackgroundAnimation(
            imagePaths: [
              PickImages.backGroundImageVariant1,
              PickImages.backGroundImageVariant2,
              PickImages.backGroundImageVariant3,
              PickImages.backGroundImageVariant4,
            ],
            currentIndex: 3,
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            top: SizeConfig.screenHeight! * 0.15,
            left: _isFirstTextVisible ? 15 : -SizeConfig.screenWidth!,
            right: 15,
            child: Text(
              SplashScreenTitles.mainTitlesFirstIntoScreen,
              style: CommonTextStyle.mainHeadingTextStyle.copyWith(
                fontSize: SizeConfig.screenHeight! > 735 ? 37 : 29,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            top: SizeConfig.screenHeight! * 0.15,
            left: _isFirstTextVisible ? SizeConfig.screenWidth : 15,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                SplashScreenTitles.mainTitlesSecondIntoScreen,
                style: CommonTextStyle.mainHeadingTextStyle.copyWith(
                  fontSize: SizeConfig.screenHeight! > 735 ? 37 : 29,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Positioned(
            top: SizeConfig.screenHeight! * 0.30,
            right: 15,
            left: 15,
            child: Text(SplashScreenTitles.noteFirstLineTitlesIntoScreen,
                style: CommonTextStyle.noteTextStyle
                    .copyWith(color: PickColors.textFieldTextColor)),
          ),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastEaseInToSlowEaseOut,
              top: _isFirstTextVisible
                  ? SizeConfig.screenHeight! * 0.35
                  : -SizeConfig.screenHeight! + SizeConfig.screenHeight! * 0.35,
              right: 0,
              left: _isFirstTextVisible ? 0 : -SizeConfig.screenWidth! * 3.5,
              child: Container(
                  height: SizeConfig.screenHeight! * 0.48,
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    PickImages.firstIntroImage,
                    fit: BoxFit.fitHeight,
                  ))),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastEaseInToSlowEaseOut,
            top: _isFirstTextVisible
                ? SizeConfig.screenHeight! + SizeConfig.screenHeight! * 0.35
                : SizeConfig.screenHeight! * 0.35,
            left: _isFirstTextVisible
                ? SizeConfig.screenWidth! * 3.5
                : SizeConfig.screenHeight! > 735
                    ? SizeConfig.screenWidth! * 0.21
                    : SizeConfig.screenWidth! * 0.34,
            child: Container(
              height: SizeConfig.screenHeight! * 0.48,
              alignment: Alignment.centerRight,
              child: Image.asset(
                PickImages.secondIntroImage,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            bottom: 93,
            right: 15,
            left: 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildIndicator(),
            ),
          ),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 15,
          left: 15,
          right: 15,
        ),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: PickColors.primaryColor,
          ),
          child: _isFirstTextVisible
              ? WidgetAnimator(
                  incomingEffect:
                      WidgetTransitionEffects.incomingSlideInFromLeft(
                          duration: const Duration(milliseconds: 500)),
                  child: CommonMaterialButton(
                    title: SplashScreenTitles.next,
                    style: CommonTextStyle.buttonTextStyle,
                    color: PickColors.transparentColor,
                    onPressed: () {
                      setState(() {
                        currentIndex = 1;
                      });

                      _toggleTextVisibility();
                    },
                    verticalPadding: SizeConfig.screenHeight! * 0.03,
                    borderRadius: 20,
                  ),
                )
              : WidgetAnimator(
                  incomingEffect:
                      WidgetTransitionEffects.incomingSlideInFromRight(
                          duration: const Duration(milliseconds: 500)),
                  child: Padding(
                    padding: const EdgeInsets.all(3.5),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: CommonMaterialButton(
                            title: "",
                            prefixIcon: PickImages.undoIntroSvg,
                            color: PickColors.primaryColor,
                            onPressed: () {
                              setState(() {
                                currentIndex = 0;
                              });
                              _toggleTextVisibility();
                            },
                            verticalPadding: SizeConfig.screenHeight! * 0.027,
                            borderRadius: 20,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: CommonMaterialButton(
                            title: SplashScreenTitles.getStarted,
                            style: CommonTextStyle.buttonTextStyle
                                .copyWith(color: PickColors.textFieldTextColor),
                            color: PickColors.whiteColor,
                            onPressed: () {
                              changePushReplacementScreen(
                                  context: context,
                                  widget: const PhoneNumberSignInScreen());
                            },
                            verticalPadding: SizeConfig.screenHeight! * 0.027,
                            borderRadius: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 3,
      width: isActive ? 30 : 6,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: isActive ? PickColors.primaryColor : PickColors.hintTextColor,
          borderRadius: BorderRadius.circular(5)),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 2; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }

    return indicators;
  }
}
