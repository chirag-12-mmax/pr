import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/navigation_screen.dart';
import 'package:shah_investment/constants/size_config.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/trades_module/trade_provider.dart';
import 'package:shah_investment/trades_module/trade_titles.dart';
import 'package:shah_investment/trades_module/trade_widgets/common_notification_listtile_widget.dart';

class NotiFicationScreen extends StatefulWidget {
  const NotiFicationScreen({super.key});

  @override
  State<NotiFicationScreen> createState() => _NotiFicationScreenState();
}

class _NotiFicationScreenState extends State<NotiFicationScreen> {
  bool isLoading = false;
  int currentPageIndex = 1;
  int numberOfDataPerPage = 10;
  final ValueNotifier<bool> isPageLoading = ValueNotifier<bool>(false);
  @override
  void initState() {
    super.initState();
    getNotiFicationHistoryData();
  }

  Future<void> getNotiFicationHistoryData(
      {bool isFromPageChange = false}) async {
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

    await tradeProvider.notificationApiService(
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
    return Consumer(builder: (context, TradeProvider tradeProvider, snapshot) {
      return Scaffold(
        backgroundColor: PickColors.whiteColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: PickColors.whiteColor,
          leading: InkWell(
            onTap: () {
              backToScreen(context: context);
            },
            child: const Icon(
              Icons.arrow_back_sharp,
            ),
          ),
          title: Text(
            TradeTitles.notification,
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
                    : tradeProvider.notificationDataList.isNotEmpty
                        ? Expanded(
                            child: LazyLoadScrollView(
                              onEndOfPage: () async {
                                if (tradeProvider.notificationDataList.length <
                                    tradeProvider.totalNotificationCount) {
                                  await getNotiFicationHistoryData(
                                      isFromPageChange: true);
                                }
                              },
                              child: ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                itemCount:
                                    tradeProvider.notificationDataList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return CommonNotificationListTileWidget(
                                    notificationModelDataList: tradeProvider
                                        .notificationDataList[index],
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
                                "No Notification Found",
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
