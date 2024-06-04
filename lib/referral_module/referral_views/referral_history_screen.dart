import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/navigation_screen.dart';
import 'package:shah_investment/constants/size_config.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/referral_module/referral_provider.dart';
import 'package:shah_investment/referral_module/referral_titles.dart';
import 'package:shah_investment/referral_module/referral_widgets/common_referral__history_listtile_widget.dart';

class ReferralHistoryScreen extends StatefulWidget {
  const ReferralHistoryScreen({super.key});

  @override
  State<ReferralHistoryScreen> createState() => _ReferralHistoryScreenState();
}

class _ReferralHistoryScreenState extends State<ReferralHistoryScreen> {
  bool isLoading = false;
  int currentPageIndex = 1;
  int numberOfDataPerPage = 10;
  int selectedTabIndex = 0;
  final ValueNotifier<bool> isPageLoading = ValueNotifier<bool>(false);

  // ReferralUserHistoryModel? referralUserHistoryModel;
  @override
  void initState() {
    super.initState();
    getReferralHistoryData();
  }

  Future<void> getReferralHistoryData({bool isFromPageChange = false}) async {
    final referralProvider =
        Provider.of<ReferralProvider>(context, listen: false);

    if (isFromPageChange) {
      currentPageIndex += 1;
      isPageLoading.value = true;
    } else {
      setState(() {
        currentPageIndex = 1;
        isLoading = true;
      });
    }

    await referralProvider.referralHistoryApiService(
      dataParameter: {
        "page": currentPageIndex,
        "limit": numberOfDataPerPage,
        "status": selectedTabIndex,
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
        builder: (context, ReferralProvider referralProvider, snapshot) {
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
            ReferralTitles.referralHistoryTitle,
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
                        child: const Center(child: CircularProgressIndicator()),
                      )
                    : referralProvider.referralUserHistoryDataList.isNotEmpty
                        ? Expanded(
                            child: LazyLoadScrollView(
                              onEndOfPage: () async {
                                if (referralProvider
                                        .referralUserHistoryDataList.length <
                                    referralProvider
                                        .totalReferralHistoryCount) {
                                  await getReferralHistoryData(
                                      isFromPageChange: true);
                                }
                              },
                              child: ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                itemCount: referralProvider
                                    .referralUserHistoryDataList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return CommonReferralHistoryListTileWidget(
                                    referralUserHistoryDataList:
                                        referralProvider
                                            .referralUserHistoryDataList[index],
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
                                "No Referral History Found",
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
    });
  }
}
