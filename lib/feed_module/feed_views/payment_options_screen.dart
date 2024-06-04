import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/images_route.dart';
import 'package:shah_investment/constants/navigation_screen.dart';
import 'package:shah_investment/constants/pick_height_width.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/feed_module/feed_views/payment_completed_screen.dart';

class PaymentOptionsScreen extends StatefulWidget {
  const PaymentOptionsScreen({super.key});

  @override
  State<PaymentOptionsScreen> createState() => _PaymentOptionsScreenState();
}

class _PaymentOptionsScreenState extends State<PaymentOptionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PickColors.whiteColor,
      appBar: AppBar(
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
        title: Text(
          "Make Payment",
          style: CommonTextStyle.noteTextStyle.copyWith(
            color: PickColors.blackColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Choose Payment \nOption",
                  style: CommonTextStyle.mediumHeadingStyle,
                ),
                PickHeightAndWidth.height20,
                Text(
                  "UPI Options",
                  style: CommonTextStyle.subHeadingTextStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
                PickHeightAndWidth.height15,
                ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: upiOptionsList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return UpiOptionsCommonContainer(
                      icon: upiOptionsList[index]["icon"],
                      paymentName: upiOptionsList[index]["title"],
                    );
                  },
                ),
                PickHeightAndWidth.height10,
                Text(
                  "Net Banking",
                  style: CommonTextStyle.subHeadingTextStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
                PickHeightAndWidth.height5,
                ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: netBankingList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return UpiOptionsCommonContainer(
                      onTap: () {
                        changeScreen(
                            context: context,
                            widget: const PaymentCompletedScreen());
                      },
                      icon: netBankingList[index]["icon"],
                      paymentName: netBankingList[index]["title"],
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

class UpiOptionsCommonContainer extends StatelessWidget {
  const UpiOptionsCommonContainer({
    super.key,
    required this.icon,
    required this.paymentName,
    this.onTap,
  });

  final String icon;
  final String paymentName;
  final dynamic onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 65,
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.all(6),
        decoration: ShapeDecoration(
          color: PickColors.lightGreyColor,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFE8E8E8)),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: SvgPicture.asset(icon),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(paymentName,
                      style: CommonTextStyle.subHeadingTextStyle
                          .copyWith(fontSize: 14)),
                  // PickHeightAndWidth.height10,
                  // Text(
                  //   'STATE BANK OF INDIA - XXXXXX265',
                  //   textAlign: TextAlign.center,
                  //   style: CommonTextStyle.noteTextStyle.copyWith(fontSize: 10),
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// UPI Options List :-----------------
List upiOptionsList = [
  {
    "id": 1,
    "icon": PickImages.googlePayIcon,
    "title": "Google Pay",
  },
  {
    "id": 2,
    "icon": PickImages.phonePayIcon,
    "title": "PhonePe",
  },
  {
    "id": 3,
    "icon": PickImages.paytmIcon,
    "title": "Paytm",
  },
  {
    "id": 4,
    "icon": PickImages.bhimUpiIcon,
    "title": "BHIM UPI",
  },
];

//Net Banking List :--------
List netBankingList = [
  {
    "id": 1,
    "icon": PickImages.sbiIcon,
    "title": "State Bank of India",
  },
  {
    "id": 2,
    "icon": PickImages.kotakMahindraIcon,
    "title": "Kotak Mahindra Bank",
  },
];
