import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shah_investment/auth_module/auth_provider.dart';
import 'package:shah_investment/auth_module/auth_titles.dart';
import 'package:shah_investment/constants/navigation_screen.dart';
import 'package:shah_investment/constants/size_config.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/trades_module/trade_views/master_screen.dart';
import 'package:shah_investment/widgets/buttons/primary_button.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class BackgroundAnimation extends StatefulWidget {
  final List<String> imagePaths;
  final int currentIndex;
  final int? durationTime;
  final bool isTrue;

  const BackgroundAnimation(
      {super.key,
      required this.imagePaths,
      required this.currentIndex,
      this.isTrue = false,
      this.durationTime});

  @override
  State<BackgroundAnimation> createState() => _BackgroundAnimationState();
}

class _BackgroundAnimationState extends State<BackgroundAnimation> {
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 2000), (_) {
      if (_currentIndex == widget.currentIndex) {
        _currentIndex = -1;
      }
      setState(() {
        _currentIndex = _currentIndex + 1;
      });

      if (widget.isTrue && _currentIndex == 4) {
        _timer?.cancel();
      }
    });
  }

  List<dynamic> widgetList = [
    const AnimationScreen(
      noteShow: false,
      showButton: false,
      textShow: false,
      animationShow: false,
      textChange: false,
    ),
    const AnimationScreen(
      noteShow: false,
      showButton: false,
      textShow: false,
      animationShow: false,
      textChange: false,
    ),
    const AnimationScreen(
      noteShow: true,
      showButton: false,
      textShow: true,
      animationShow: true,
      textChange: false,
    ),
    const AnimationScreen(
      noteShow: true,
      showButton: false,
      textShow: true,
      animationShow: false,
      textChange: false,
    ),
    const AnimationScreen(
      noteShow: true,
      showButton: true,
      textShow: true,
      animationShow: false,
      textChange: true,
    )
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return AnimatedSwitcher(
      duration: Duration(
          milliseconds:
              widget.durationTime ?? 2000), // Adjust animation duration
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: widget.isTrue
          ? Container(
              key: ValueKey(_currentIndex),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.imagePaths[_currentIndex]),
                  fit: BoxFit.fill,
                ),
              ),
              child: widgetList[_currentIndex],
            )
          : Image.asset(
              widget.imagePaths[_currentIndex],
              width: double.infinity,
              key: ValueKey(_currentIndex),
              fit: BoxFit.fill, // Adjust image fit as needed
            ),
    );
  }
}

class AnimationScreen extends StatefulWidget {
  final bool textShow;
  final bool noteShow;
  final bool showButton;
  final bool animationShow;
  final bool textChange;
  const AnimationScreen({
    super.key,
    required this.textShow,
    required this.showButton,
    required this.noteShow,
    required this.animationShow,
    required this.textChange,
  });

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, AuthProvider authProvider, snapshot) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.textShow
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, left: 30),
                    child: widget.animationShow
                        ? WidgetAnimator(
                            incomingEffect: WidgetTransitionEffects
                                .incomingSlideInFromBottom(
                                    duration:
                                        const Duration(milliseconds: 1500)),
                            child: Text(
                              "${SplashScreenTitles.welcomeTitlesHello}${authProvider.currentUserData!.name!}!",
                              style:
                                  CommonTextStyle.mainHeadingTextStyle.copyWith(
                                fontSize: 35,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        : Text(
                            "${SplashScreenTitles.welcomeTitlesHello}${authProvider.currentUserData!.name!}!",
                            style:
                                CommonTextStyle.mainHeadingTextStyle.copyWith(
                              fontSize: 35,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                  ),
                )
              : Container(),
          widget.noteShow
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: widget.textChange
                            ? 0
                            : SizeConfig.screenHeight! * 0.12),
                    child: Column(
                      children: [
                        Text(
                          widget.textChange
                              ? SplashScreenTitles.welcomeToShah
                              : SplashScreenTitles.welcomeNote,
                          style: CommonTextStyle.mainHeadingTextStyle.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          widget.textChange
                              ? SplashScreenTitles.investment
                              : "",
                          style: CommonTextStyle.mainHeadingTextStyle.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
          widget.showButton
              ? Padding(
                  padding: EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: SizeConfig.screenHeight! * 0.06,
                      bottom: 15),
                  child: CommonMaterialButton(
                    title: SplashScreenTitles.getStarted,
                    style: CommonTextStyle.buttonTextStyle,
                    onPressed: () {
                      changeScreenWithClearStack(
                          context: context, widget: const MasterScreen());
                    },
                    verticalPadding: SizeConfig.screenHeight! * 0.03,
                    borderRadius: 20,
                  ),
                )
              : Container()
        ],
      );
    });
  }
}
