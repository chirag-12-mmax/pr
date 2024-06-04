import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/navigation_screen.dart';
import 'package:shah_investment/constants/size_config.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/subscription_module/subscription_provider.dart';
import 'package:shah_investment/subscription_module/subscription_titles.dart';
import 'package:shah_investment/subscription_module/subscription_widgets/common_subscription_listtile_widget.dart';

class SubscriptionHistoryScreen extends StatefulWidget {
  const SubscriptionHistoryScreen({super.key});

  @override
  State<SubscriptionHistoryScreen> createState() =>
      _SubscriptionHistoryScreenState();
}

class _SubscriptionHistoryScreenState extends State<SubscriptionHistoryScreen> {
  int currentPageIndex = 1;
  bool isLoading = false;
  int numberOfDataPerPage = 10;

  final ValueNotifier<bool> isPageLoading = ValueNotifier<bool>(false);
  @override
  void initState() {
    super.initState();
    getPaymentHistoryData();
  }

  Future<void> getPaymentHistoryData({bool isFromPageChange = false}) async {
    final subscriptionProvider =
        Provider.of<SubscriptionProvider>(context, listen: false);

    if (isFromPageChange) {
      currentPageIndex += 1;
      isPageLoading.value = true;
    } else {
      setState(() {
        currentPageIndex = 1;
        isLoading = true;
      });
    }

    await subscriptionProvider.getPaymentHistoryApiService(
      dataParameter: {
        "page": currentPageIndex,
        "limit": numberOfDataPerPage,
      },
      context: context,
      isFromLoad: isFromPageChange,
    );

    if (isFromPageChange) {
      isPageLoading.value = false;
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, SubscriptionProvider subscriptionProvider,
          snapshot) {
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
              SubscriptionTitles.subscriptionHistoryTitle,
              style: CommonTextStyle.noteTextStyle.copyWith(
                color: PickColors.blackColor,
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isLoading
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.screenHeight! / 3),
                          child:
                              const Center(child: CircularProgressIndicator()),
                        )
                      : subscriptionProvider.paymentHistoryDataList.isNotEmpty
                          ? Expanded(
                              child: LazyLoadScrollView(
                                onEndOfPage: () async {
                                  if (subscriptionProvider
                                          .paymentHistoryDataList.length <
                                      subscriptionProvider
                                          .totalPaymentHistoryCount) {
                                    await getPaymentHistoryData(
                                        isFromPageChange: true);
                                  }
                                },
                                child: ListView.builder(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  itemCount: subscriptionProvider
                                      .paymentHistoryDataList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {},
                                      child: CommonSubscriptionListTileWidget(
                                        paymentHistoryModelDataList:
                                            subscriptionProvider
                                                .paymentHistoryDataList[index],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.screenHeight! / 3.0),
                              child: Center(
                                child: Text(
                                  "No History History Found",
                                  style: CommonTextStyle.chipTextStyle.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                  ValueListenableBuilder(
                    valueListenable: isPageLoading,
                    builder: (BuildContext context, bool value, Widget? child) {
                      return (isPageLoading.value)
                          ? const SizedBox(
                              height: 50,
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : Container();
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
