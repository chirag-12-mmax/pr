import 'package:flutter/material.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/size_config.dart';
import 'package:shah_investment/constants/text_style.dart';

class SwitchTabWidget extends StatelessWidget {
  const SwitchTabWidget({
    super.key,
    required this.selectedTabIndex,
    required this.tabList,
    this.onTapSwitch,
  });

  final int selectedTabIndex;
  final List<String> tabList;
  final dynamic onTapSwitch;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(
          vertical: 10, horizontal: SizeConfig.screenWidth! * 0.19),
      decoration: BoxDecoration(
          color: PickColors.textFieldTextColor,
          borderRadius: BorderRadius.circular(60)),
      child: Row(
        children: List.generate(tabList.length, (index) {
          return Expanded(
            child: InkWell(
              onTap: () {
                onTapSwitch(index);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                decoration: BoxDecoration(
                  color: selectedTabIndex == index
                      ? PickColors.whiteColor
                      : CommonTextStyle.chipTextStyle.color,
                  borderRadius: BorderRadius.circular(
                    60,
                  ),
                ),
                child: Center(
                  child: Text(
                    tabList[index],
                    style: CommonTextStyle.chipTextStyle.copyWith(
                        color: selectedTabIndex != index
                            ? PickColors.whiteColor
                            : CommonTextStyle.chipTextStyle.color),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
