// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:shah_investment/auth_module/auth_provider.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/images_route.dart';
import 'package:shah_investment/constants/navigation_screen.dart';
import 'package:shah_investment/constants/pick_height_width.dart';
import 'package:shah_investment/constants/size_config.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/referral_module/referral_provider.dart';
import 'package:shah_investment/trades_module/trade_models/subscription_model.dart';
import 'package:shah_investment/trades_module/trade_provider.dart';
import 'package:shah_investment/trades_module/trade_views/master_screen.dart';
import 'package:shah_investment/trades_module/trade_widgets/subscription_item.dart';
import 'package:shah_investment/trades_module/trade_widgets/switch_widget.dart';
import 'package:shah_investment/widgets/buttons/primary_button.dart';
import 'package:shah_investment/widgets/loaders/show_overlay_loader.dart';
import 'package:shah_investment/widgets/show_toast.dart';

class SubscriptionDetailScreen extends StatefulWidget {
  int selectedTabIndex;
  SubscriptionDetailScreen({super.key, this.selectedTabIndex = 0});

  @override
  State<SubscriptionDetailScreen> createState() =>
      _SubscriptionDetailScreenState();
}

class _SubscriptionDetailScreenState extends State<SubscriptionDetailScreen> {
  List<String> tabList = ["Market Calls", "Learning"];
  SubscriptionModel? selectedSubscription;

  bool isLoading = false;

  int currentPageIndex = 1;
  int numberOfDataPerPage = 10;

  final ValueNotifier<bool> isPageLoading = ValueNotifier<bool>(false);

  @override
  void initState() {
    getInitializeData();
    final referralProvider =
        Provider.of<ReferralProvider>(context, listen: false);
    referralProvider.getAddressAndReferralDayDataApiService(context: context);
    super.initState();
  }

  Future<void> getInitializeData({bool isFromPageChange = false}) async {
    final tradeProvider = Provider.of<TradeProvider>(context, listen: false);
    if (isFromPageChange) {
      currentPageIndex += 1;
      isPageLoading.value = true;
    } else {
      setState(() {
        currentPageIndex = 1;
        isLoading = true;
      });
    }

    await tradeProvider.getSubscriptionDataApiService(
      dataParameter: {
        "page": currentPageIndex,
        "limit": numberOfDataPerPage,
        "status": widget.selectedTabIndex == 0 ? 1 : 0,
      },
      context: context,
      isFromLoad: isFromPageChange,
    );

    if (isFromPageChange) {
      isPageLoading.value = false;
    } else {
      setState(() {
        selectedSubscription = (tradeProvider.subscriptionDataList).isNotEmpty
            ? tradeProvider.subscriptionDataList.first
            : null;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer3(
      builder: (BuildContext context,
          TradeProvider tradeProvider,
          AuthProvider authProvider,
          ReferralProvider referralProvider,
          snapshot) {
        return Scaffold(
          body: Container(
            height: SizeConfig.screenHeight,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(PickImages.gradientBack),
                fit: BoxFit.fill,
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                backToScreen(context: context);
                              },
                              child: const Align(
                                  alignment: Alignment.topLeft,
                                  child: Icon(Icons.arrow_back_sharp)),
                            ),
                            SwitchTabWidget(
                              selectedTabIndex: widget.selectedTabIndex,
                              tabList: tabList,
                              onTapSwitch: (index) {
                                setState(() {
                                  widget.selectedTabIndex = index;
                                });
                                getInitializeData();
                              },
                            ),
                            PickHeightAndWidth.height5,
                            const Text(
                              "Get Premium Access",
                              style: CommonTextStyle.mediumHeadingStyle,
                            ),
                            Text(
                              "Enjoy everyday 3 market calls and unlimited stock market learning subscription.",
                              textAlign: TextAlign.center,
                              style: CommonTextStyle.noteTextStyle.copyWith(
                                  color: PickColors.textFieldTextColor),
                            ),
                            // PickHeightAndWidth.height20,
                            // const SubscriptionTimerWidget(),
                            PickHeightAndWidth.height5,
                            isLoading
                                ? const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 50),
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  )
                                : tradeProvider.subscriptionDataList.isNotEmpty
                                    ? LazyLoadScrollView(
                                        scrollDirection: Axis.horizontal,
                                        isLoading: true,
                                        onEndOfPage: () async {
                                          if (tradeProvider
                                                  .subscriptionDataList.length <
                                              tradeProvider
                                                  .totalSubscriptionCount) {
                                            await getInitializeData(
                                                isFromPageChange: true);
                                          }
                                        },
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              Row(
                                                children: List.generate(
                                                  tradeProvider
                                                      .subscriptionDataList
                                                      .length,
                                                  (index) =>
                                                      SubscriptionItemWidget(
                                                    subscriptionData: tradeProvider
                                                            .subscriptionDataList[
                                                        index],
                                                    isSelected: selectedSubscription
                                                            ?.sId
                                                            .toString() ==
                                                        tradeProvider
                                                            .subscriptionDataList[
                                                                index]
                                                            .sId
                                                            .toString(),
                                                    onTapWidget: () {
                                                      setState(
                                                        () {
                                                          selectedSubscription =
                                                              tradeProvider
                                                                      .subscriptionDataList[
                                                                  index];
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                              ValueListenableBuilder(
                                                valueListenable: isPageLoading,
                                                builder: (BuildContext context,
                                                    bool value, Widget? child) {
                                                  return (isPageLoading.value)
                                                      ? const SizedBox(
                                                          height: 50,
                                                          child: Center(
                                                              child:
                                                                  CircularProgressIndicator()),
                                                        )
                                                      : Container();
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                SizeConfig.screenHeight! / 12),
                                        child: Center(
                                          child: Text(
                                            "No Plan Found",
                                            style: CommonTextStyle.chipTextStyle
                                                .copyWith(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                            SizedBox(
                              height: SizeConfig.screenHeight! / 4.5,
                            ),
                            widget.selectedTabIndex == 0
                                ? Container()
                                : Text(referralProvider.address ?? "",
                                    textAlign: TextAlign.center,
                                    style: CommonTextStyle.noteTextStyle
                                        .copyWith(
                                            color:
                                                PickColors.textFieldTextColor)),
                            Text('Start your First Plan now',
                                textAlign: TextAlign.center,
                                style: CommonTextStyle.noteTextStyle.copyWith(
                                    color: PickColors.textFieldTextColor)),
                            const Text('Automatic Renewal, Cancel Anytime',
                                textAlign: TextAlign.center,
                                style: CommonTextStyle.smallTextStyle),
                            // PickHeightAndWidth.height20,

                            PickHeightAndWidth.height10,
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: CommonMaterialButton(
                                color: PickColors.textFieldTextColor,
                                title: "Unlock Now",
                                verticalPadding: 24,
                                borderRadius: 16,
                                onPressed: () async {
                                  if (selectedSubscription != null) {
                                    showOverlayLoader(context);
                                    if (await tradeProvider
                                        .buySubscriptionPlanApiService(
                                            dataParameter: {
                                          "id": selectedSubscription?.sId ?? "",
                                          "autoCut": 1
                                        },
                                            context: context)) {
                                      setState(() {
                                        authProvider
                                            .currentUserData?.isSubscribe = 1;
                                      });
                                      hideOverlayLoader();
                                      changeScreen(
                                        context: context,
                                        widget: const MasterScreen(),
                                      );
                                    } else {
                                      hideOverlayLoader();
                                    }
                                  } else {
                                    showToast(
                                        message: "Please Select Any One Plan",
                                        isPositive: false,
                                        context: context);
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Why Premium?',
                                      textAlign: TextAlign.center,
                                      style: CommonTextStyle.noteTextStyle
                                          .copyWith(
                                        color: PickColors.primaryColor,
                                        fontWeight: FontWeight.w800,
                                      )),
                                  const Icon(
                                    Icons.arrow_forward,
                                    color: PickColors.primaryColor,
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
