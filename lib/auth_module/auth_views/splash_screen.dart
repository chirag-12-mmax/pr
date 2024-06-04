import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shah_investment/auth_module/auth_provider.dart';
import 'package:shah_investment/auth_module/auth_views/splash_screen_intro_first.dart';
import 'package:shah_investment/constants/images_route.dart';
import 'package:shah_investment/constants/navigation_screen.dart';
import 'package:shah_investment/trades_module/trade_views/master_screen.dart';
import 'package:shah_investment/widgets/back_ground_animation/back_ground_animation.dart';




class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    initializeData();
    super.initState();
  }

  Future<void> initializeData() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    Timer(
      const Duration(seconds: 3),
      () => authProvider.currentUserData != null &&
              authProvider.currentUserData?.isActive == 1
          ? changeScreenWithClearStack(
              context: context, widget: const MasterScreen())
          : changeScreenWithClearStack(
              context: context,
              widget: const SplashScreenIntroFirst(),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        const SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: BackgroundAnimation(
            imagePaths: [
              PickImages.backGroundImageVariant1,
              PickImages.backGroundImageVariant2,
              PickImages.backGroundImageVariant3,
              PickImages.backGroundImageVariant4,
            ],
            currentIndex: 3,
          ),
        ),
        Center(
            child: SvgPicture.asset(
          PickImages.applicationLogo,
        )),
      ]),
    );
  }
}
