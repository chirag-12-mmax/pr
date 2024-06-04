// import 'package:flutter/material.dart';
// import 'package:shah_investment/constants/colors.dart';
// import 'package:shah_investment/constants/size_config.dart';
// import 'package:shah_investment/constants/text_style.dart';

// class CommonTabBarWidget extends StatelessWidget {
//   const CommonTabBarWidget({
//     super.key,
//     required this.selectedTabIndex,
//     required this.tabList,
//     this.onTapSwitch,
//     required this.chipPadding,
//   });

//   final int selectedTabIndex;
//   final List<String> tabList;
//   final dynamic onTapSwitch;
//   final EdgeInsetsGeometry chipPadding;

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Row(
//       children: List.generate(tabList.length, (index) {
//         return Expanded(
//           child: GestureDetector(
//             onTap: () {
//               onTapSwitch(index);
//             },
//             child: Container(
//               padding: chipPadding,
//               decoration: BoxDecoration(
//                   color: selectedTabIndex == index
//                       ? CommonTextStyle.chipTextStyle.color
//                       : PickColors.transparentColor,
//                   borderRadius: BorderRadius.circular(60)),
//               child: Center(
//                 child: Text(
//                   tabList[index],
//                   style: CommonTextStyle.chipTextStyle.copyWith(
//                       color: selectedTabIndex != index
//                           ? CommonTextStyle.chipTextStyle.color
//                           : PickColors.whiteColor),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/size_config.dart';
import 'package:shah_investment/constants/text_style.dart';

class CommonTabBarWidget extends StatelessWidget {
  const CommonTabBarWidget({
    super.key,
    required this.selectedTabIndex,
    required this.tabList,
    this.onTapSwitch,
    required this.chipPadding,
  });

  final int selectedTabIndex;
  final List<String> tabList;
  final dynamic onTapSwitch;
  final EdgeInsetsGeometry chipPadding;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(tabList.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(right: 1),
            child: GestureDetector(
              onTap: () {
                onTapSwitch(index);
              },
              child: Container(
              
                padding: chipPadding,
                decoration: BoxDecoration(
                  color: selectedTabIndex == index
                      ? CommonTextStyle.chipTextStyle.color
                      : PickColors.transparentColor,
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Center(
                  child: Text(
                    tabList[index],
                    style: CommonTextStyle.chipTextStyle.copyWith(
                      fontSize: 13,
                      color: selectedTabIndex != index
                          ? CommonTextStyle.chipTextStyle.color
                          : PickColors.whiteColor,
                    ),
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
