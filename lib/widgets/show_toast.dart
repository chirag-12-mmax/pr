import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:shah_investment/constants/colors.dart';

void showToast(
    {required String message,
    required bool? isPositive,
    required BuildContext context}) {
  BotToast.showCustomNotification(
    animationDuration: const Duration(milliseconds: 1000),
    wrapToastAnimation: (controller, cancel, child) => CustomOffsetAnimation(
        reverse: false, controller: controller, child: child),
    toastBuilder: (cancelFunc) {
      return Card(
        shadowColor:
            (isPositive ?? false) ? PickColors.greenColor : PickColors.redColor,
        borderOnForeground: true,
        elevation: 2,
        margin: EdgeInsets.only(left: 80),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                  color: (isPositive ?? false)
                      ? PickColors.greenColor
                      : PickColors.redColor,
                  width: 4),
              // bottom: BorderSide(color: PickColors.successColor, width: 3),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  (isPositive ?? false) ? Icons.check_circle : Icons.info,
                  color: (isPositive ?? false)
                      ? PickColors.greenColor
                      : PickColors.redColor,
                ),
              ),
              Expanded(
                  child: Text(
                message,
              )),
              InkWell(
                onTap: () {
                  BotToast.cleanAll();
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.cancel,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

// Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_LONG,
//       gravity: ToastGravity.SNACKBAR,
//       timeInSecForIosWeb: 1,
//       backgroundColor: PickColors.whiteColor,
//       textColor: isPositive! ? PickColors.greenColor : PickColors.redColor,
//       fontSize: 14.0);

class CustomOffsetAnimation extends StatefulWidget {
  final AnimationController controller;
  final Widget child;
  final bool reverse;

  const CustomOffsetAnimation(
      {Key? key,
      required this.controller,
      required this.child,
      this.reverse = false})
      : super(key: key);

  @override
  CustomOffsetAnimationState createState() => CustomOffsetAnimationState();
}

class CustomOffsetAnimationState extends State<CustomOffsetAnimation> {
  late Tween<Offset> tweenOffset;

  late Animation<double> animation;

  @override
  void initState() {
    tweenOffset = Tween<Offset>(
      begin: Offset(widget.reverse ? -0.8 : 0.8, 0.0),
      end: Offset.zero,
    );
    animation =
        CurvedAnimation(parent: widget.controller, curve: Curves.decelerate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (BuildContext context, Widget? child) {
        return FractionalTranslation(
            translation: tweenOffset.evaluate(animation),
            child: Opacity(
              opacity: animation.value,
              child: child,
            ));
      },
      child: widget.child,
    );
  }
}
