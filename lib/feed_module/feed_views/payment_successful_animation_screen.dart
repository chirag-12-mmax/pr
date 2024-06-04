import 'package:flutter/material.dart';
import 'package:shah_investment/constants/images_route.dart';
import 'package:shah_investment/widgets/back_ground_animation/back_ground_animation.dart';

class PaymentSuccessfulAnimationScreen extends StatefulWidget {
  const PaymentSuccessfulAnimationScreen({super.key});

  @override
  State<PaymentSuccessfulAnimationScreen> createState() =>
      _PaymentSuccessfulAnimationScreenState();
}

class _PaymentSuccessfulAnimationScreenState
    extends State<PaymentSuccessfulAnimationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(children: [
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
            child: Image.network(height: 230, width: 230, PickImages.gif),
          ),
        ]),
      ),
    );
  }
}
