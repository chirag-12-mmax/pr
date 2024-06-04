import 'package:flutter/material.dart';
import 'package:shah_investment/constants/text_style.dart';

class PrizeContainerWidget extends StatelessWidget {
  const PrizeContainerWidget({
    super.key,
    required this.title,
    required this.subTitle,
    this.bgColor = Colors.transparent,
  });
  final String title;
  final String subTitle;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      decoration:
          BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Text(
            title,
            style: CommonTextStyle.noteTextStyle.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            subTitle,
            style: CommonTextStyle.chipTextStyle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
