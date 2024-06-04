// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shah_investment/auth_module/auth_provider.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/images_route.dart';
import 'package:shah_investment/constants/navigation_screen.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/feed_module/feed_titles.dart';
import 'package:shah_investment/feed_module/feed_views/display_feed_screen.dart';
import 'package:shah_investment/feed_module/feed_views/new_feed_screen.dart';
import 'package:shah_investment/referral_module/referral_views/referral_screen.dart';
import 'package:shah_investment/trades_module/trade_provider.dart';
import 'package:shah_investment/trades_module/trade_titles.dart';
import 'package:shah_investment/trades_module/trade_views/drawer_screen.dart';
import 'package:shah_investment/trades_module/trade_views/home_screen.dart';
import 'package:shah_investment/trades_module/trade_views/notification_screen.dart';
import 'package:shah_investment/trades_module/trade_widgets/bottom_navigation_bar.dart';
import 'package:shah_investment/widgets/form_controls/text_field_control.dart';
import 'package:shah_investment/widgets/network_image_builder.dart';

class MasterScreen extends StatefulWidget {
  final int? selectedNavIndex;

  const MasterScreen({
    super.key,
    this.selectedNavIndex,
  });

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  bool isLoading = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    initializeData();
    super.initState();
  }

  Future<void> initializeData() async {
    setState(() {
      isLoading = true;
    });

    final tradeProvider = Provider.of<TradeProvider>(context, listen: false);

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await tradeProvider.getTabApiService(context: context);
    await authProvider.getSingleUserDataService(context: context);

    if ((authProvider.currentUserData?.isSubscribe ?? 0) == 0) {
      await tradeProvider.getPreviousTipsDataApiService(context: context);
    } else {
      await tradeProvider.getTipDataApiService(
          context: context,
          dataParameter: {"page": 1, "limit": 10, "status": 0});
      await tradeProvider.getTipDataApiService(
          context: context,
          dataParameter: {"page": 1, "limit": 10, "status": 1});
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2(builder: (BuildContext context, AuthProvider authProvider,
        TradeProvider tradeProvider, snapshot) {
      return Scaffold(
          backgroundColor: PickColors.whiteColor,
          drawerEnableOpenDragGesture: false,
          drawer: const DrawerWidget(),
          appBar: AppBar(
            backgroundColor: PickColors.whiteColor,
            leadingWidth: 88,
            titleSpacing: 0,
            leading: Builder(
              builder: (context) => InkWell(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      BuildLogoProfileImageWidget(
                        isColors: true,
                        imagePath:
                            authProvider.currentUserData?.profileImage ?? "-",
                        titleName: authProvider.currentUserData?.name ?? "-",
                        height: 30,
                        width: 30,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      const SizedBox(width: 7),
                      Expanded(child: SvgPicture.asset(PickImages.menuImage))
                    ],
                  ),
                ),
              ),
            ),
            title: tradeProvider.bottomNavIndex == 2
                ? CommonFormBuilderTextField(
                    isDense: true,
                    contentPaddingVertical: 8,
                    fieldKey: 'searchKey',
                    textController: searchController,
                    hint: FeedTitles.searchArticleOrOther,
                    textStyle: CommonTextStyle.chipTextStyle,
                    isRequired: false,
                    prefix: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SvgPicture.asset(
                        PickImages.searchIcon,
                      ),
                    ),
                    validationKey: '',
                    fillColor: PickColors.textFieldBorderColor,
                    borderRadius: 50.00,
                  )
                : Text(
                    tradeProvider.bottomNavIndex == 0
                        ? TradeTitles.referral
                        : TradeTitles.home,
                    style: CommonTextStyle.mainHeadingTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
            centerTitle: true,
            actions: [
              tradeProvider.bottomNavIndex == 2
                  ? Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {
                          changeScreen(
                            context: context,
                            widget: const NewFeedScreen(),
                          );
                        },
                        child: SvgPicture.asset(
                          PickImages.addContainerIcon,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                          right: 15.0, top: 7, bottom: 10),
                      child: InkWell(
                        onTap: () {
                          changeScreen(
                              context: context,
                              widget: const NotiFicationScreen());
                        },
                        child: SvgPicture.asset(PickImages.notificationIcon),
                      ),
                    )
            ],
          ),
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
            child: tradeProvider.bottomNavIndex == 0
                ? const ReferralScreen()
                : tradeProvider.bottomNavIndex == 1
                    ? isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : const HomePageScreen()
                    : DisplayFeedScreen(
                        searchController: searchController,
                      ),
          ),
          bottomNavigationBar: BottomNavigationBarWidget(
            bottomNavIndex: tradeProvider.bottomNavIndex,
            onTapNav: (selectedIndex) {
              tradeProvider.changeBottomBarIndex(selectedIndex: selectedIndex);
            },
          ));
    });
  }
}
