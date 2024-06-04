import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/images_route.dart';
import 'package:shah_investment/trades_module/trade_titles.dart';
import 'package:shah_investment/widgets/tab_bar/navigation_bar.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({
    super.key,
    required this.bottomNavIndex,
    required this.onTapNav,
  });

  final int bottomNavIndex;
  final Function(int) onTapNav;

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: PickColors.transparentColor,
      buttonBackgroundColor: PickColors.bottomNavigationBarSelectedIconColor,
      color: PickColors.bottomNavigationBarBackGroundColor,
      height: 75,
      animationDuration: const Duration(milliseconds: 300),
      index: widget.bottomNavIndex,
      onTap: widget.onTapNav,
     
      items: <CurvedNavigationBarItem>[
        CurvedNavigationBarItem(
            label: TradeTitles.referral,
            icon: SvgPicture.asset(
              PickImages.profileIcon,
              color: widget.bottomNavIndex == 0
                  ? Colors.black
                  : PickColors.hintTextColor,
              height: widget.bottomNavIndex == 0 ? 25 : 20,
            )),
        CurvedNavigationBarItem(
            label: TradeTitles.home,
            icon: SvgPicture.asset(
              PickImages.homeIcon,
              color: widget.bottomNavIndex == 1
                  ? Colors.black
                  : PickColors.hintTextColor,
              height: widget.bottomNavIndex == 1 ? 25 : 20,
            )),
        CurvedNavigationBarItem(
          label: TradeTitles.feed,
          icon: SvgPicture.asset(
            PickImages.messageIcon,
            color: widget.bottomNavIndex == 2
                ? Colors.black
                : PickColors.hintTextColor,
            height: widget.bottomNavIndex == 2 ? 25 : 20,
          ),
        ),
      ],
    );
  }
}
