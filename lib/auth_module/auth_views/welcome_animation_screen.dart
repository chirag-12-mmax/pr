import 'package:flutter/material.dart';
import 'package:shah_investment/constants/images_route.dart';
import 'package:shah_investment/widgets/back_ground_animation/back_ground_animation.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({
    super.key,
  });

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Stack(children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: BackgroundAnimation(
                imagePaths: [
                  PickImages.welcomeBackgroundFirst,
                  PickImages.welcomeBackgroundSecond,
                  PickImages.welcomeBackgroundThird,
                  PickImages.welcomeBackgroundFirst,
                  PickImages.welcomeBackgroundFifth
                ],
                durationTime: 1000,
                currentIndex: 4,
                isTrue: true,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
