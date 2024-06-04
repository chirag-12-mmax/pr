// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/global_list.dart';
import 'package:shah_investment/constants/size_config.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/feed_module/feed_provider.dart';
import 'package:shah_investment/feed_module/feed_widgets/feed_back_list_item_widget.dart';
import 'package:shah_investment/widgets/tab_bar/common_tab_bar_widget.dart';

class DisplayFeedScreen extends StatefulWidget {
  const DisplayFeedScreen({
    super.key,
    required this.searchController,
  });
  final TextEditingController searchController;

  @override
  State<DisplayFeedScreen> createState() => _DisplayFeedScreenState();
}

class _DisplayFeedScreenState extends State<DisplayFeedScreen> {
  bool isLoading = false;
  int currentPageIndex = 1;
  int numberOfDataPerPage = 10;
  int selectedTabIndex = 0;
  final ValueNotifier<bool> isPageLoading = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    getFeedBackData();
    widget.searchController.addListener(() {
      getFeedBackData();
    });
  }

  Future<void> getFeedBackData({bool isFromPageChange = false}) async {
    final feedBackProvider =
        Provider.of<FeedBackProvider>(context, listen: false);
    if (isFromPageChange) {
      currentPageIndex += 1;
      isPageLoading.value = true;
    } else {
      setState(() {
        currentPageIndex = 1;
        // isLoading = true;
      });
    }

    await feedBackProvider.getFeedBackApiService(
      dataParameter: {
        "page": currentPageIndex,
        "limit": numberOfDataPerPage,
        "status": selectedTabIndex,
        if (widget.searchController.text.isNotEmpty)
          "search": widget.searchController.text
      },
      context: context,
      isFromLoad: isFromPageChange,
    );

    setState(() {
      if (isFromPageChange) {
        isPageLoading.value = false;
      } else {
        isLoading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, FeedBackProvider feedBackProvider, snapshot) {
      return Scaffold(
        backgroundColor: PickColors.whiteColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: isLoading
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.screenHeight! / 3),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: CommonTabBarWidget(
                            selectedTabIndex: selectedTabIndex,
                            tabList: GlobalList.tabList,
                            onTapSwitch: (index) {
                              setState(
                                () {
                                  selectedTabIndex = index;
                                  getFeedBackData();
                                },
                              );
                            },
                            chipPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                          ),
                        ),
                        feedBackProvider.currentUserFeedBackList.isNotEmpty
                            ? Expanded(
                                child: LazyLoadScrollView(
                                  onEndOfPage: () async {
                                    if (feedBackProvider
                                            .currentUserFeedBackList.length <
                                        feedBackProvider.totalFeedbackCount) {
                                      await getFeedBackData(
                                          isFromPageChange: true);
                                    }
                                  },
                                  child: ListView.builder(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    itemCount: feedBackProvider
                                        .currentUserFeedBackList.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return FeedBackListItemWidget(
                                        index: index,
                                        feedBackData: feedBackProvider
                                            .currentUserFeedBackList[index],
                                        onTapLike: () async {
                                          if (feedBackProvider
                                                  .currentUserFeedBackList[
                                                      index]
                                                  .like !=
                                              1) {
                                            if (await feedBackProvider
                                                .addLikeOnFeedBackApiService(
                                              dataParameter: {
                                                "feedbackId": feedBackProvider
                                                    .currentUserFeedBackList[
                                                        index]
                                                    .sId
                                                    .toString()
                                              },
                                              context: context,
                                            )) {
                                              setState(
                                                () {
                                                  feedBackProvider
                                                      .currentUserFeedBackList[
                                                          index]
                                                      .like = 1;
                                                  feedBackProvider
                                                      .currentUserFeedBackList[
                                                          index]
                                                      .likeCount = (feedBackProvider
                                                              .currentUserFeedBackList[
                                                                  index]
                                                              .likeCount ??
                                                          0) +
                                                      1;
                                                },
                                              );
                                            }
                                          } else {
                                            if (await feedBackProvider
                                                .removeLikeOnFeedBackApiService(
                                              dataParameter: {
                                                "feedbackId": feedBackProvider
                                                    .currentUserFeedBackList[
                                                        index]
                                                    .sId
                                                    .toString()
                                              },
                                              context: context,
                                            )) {
                                              setState(
                                                () {
                                                  if (feedBackProvider
                                                          .currentUserFeedBackList[
                                                              index]
                                                          .likeCount !=
                                                      0) {
                                                    feedBackProvider
                                                        .currentUserFeedBackList[
                                                            index]
                                                        .like = 0;
                                                    feedBackProvider
                                                        .currentUserFeedBackList[
                                                            index]
                                                        .likeCount = (feedBackProvider
                                                                .currentUserFeedBackList[
                                                                    index]
                                                                .likeCount ??
                                                            0) -
                                                        1;
                                                  }
                                                },
                                              );
                                            }
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: SizeConfig.screenHeight! / 3),
                                child: Center(
                                  child: Text(
                                    "No Feed Found",
                                    style:
                                        CommonTextStyle.chipTextStyle.copyWith(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                        ValueListenableBuilder(
                          valueListenable: isPageLoading,
                          builder: (BuildContext context, bool value,
                              Widget? child) {
                            return (isPageLoading.value)
                                ? const SizedBox(
                                    height: 50,
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  )
                                : Container();
                          },
                        )
                      ],
                    ),
            ),
          ),
        ),
      );
    });
  }
}
