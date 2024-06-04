// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kiteparser/kite/kite_ticker.dart';
import 'package:provider/provider.dart';
import 'package:shah_investment/auth_module/auth_provider.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/images_route.dart';
import 'package:shah_investment/constants/navigation_screen.dart';
import 'package:shah_investment/constants/pick_height_width.dart';
import 'package:shah_investment/constants/size_config.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/trades_module/trade_models/tip_model.dart';
import 'package:shah_investment/trades_module/trade_provider.dart';
import 'package:shah_investment/trades_module/trade_titles.dart';
import 'package:shah_investment/trades_module/trade_views/drawer_screen.dart';
import 'package:shah_investment/trades_module/trade_views/plan_detail_screen.dart';
import 'package:shah_investment/trades_module/trade_views/subscription_detail.dart';
import 'package:shah_investment/trades_module/trade_widgets/common_home_screen_widget.dart';
import 'package:shah_investment/trades_module/trade_widgets/home_page_card_details.dart';
import 'package:shah_investment/widgets/tab_bar/common_tab_bar_widget.dart';
import 'package:web_socket_channel/io.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({
    super.key,
  });

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen>
    implements SocketConnectionListener, OnDataListener {
  final kiteTicker = KiteTicker();
  final List<int> instrumentTokens = [265, 256265, 408065, 260105];
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;
  double _scrollPosition = 0;
  bool _forward = true;
  int selectedTabIndex = 0;
  int bottomNavIndex = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getStockData();
    _startScrolling();
  }

  Future<void> getStockData() async {
    kiteTicker.setUpSocket(
        'kzypmku00hjrkh07', 'qUl6VuHyFhXmAEdGxMQCfeGU5AbjA1w5', this);
    kiteTicker.addDataListener('home', this);

    final tradeProvider = Provider.of<TradeProvider>(context, listen: false);

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if ((authProvider.currentUserData?.isSubscribe ?? 0) == 0) {
      await tradeProvider.getPreviousTipsDataApiService(context: context);
    } else {
      await tradeProvider.getTabApiService(context: context);
      await tradeProvider.getTipDataApiService(
          context: context,
          dataParameter: {"page": 1, "limit": 10, "status": 0});
    }
  }

  List<Tick> stockData = [];
  List<String> stockDataToken = [];

  void _startScrolling() {
    _timer = Timer.periodic(const Duration(milliseconds: 15), (timer) {
      double maxScrollExtent = _scrollController.position.maxScrollExtent;
      double pixelsPerMillisecond = 0.1;
      double millisecondsPerScroll = 4;
      double delta = pixelsPerMillisecond * millisecondsPerScroll;

      if (_forward) {
        if (_scrollPosition + delta >= maxScrollExtent) {
          _forward = false;
        }
      } else {
        if (_scrollPosition - delta <= 0) {
          _forward = true;
        }
      }
      if (!mounted) return;
      setState(() {
        if (_forward) {
          _scrollPosition += delta;
        } else {
          _scrollPosition -= delta;
        }
        _scrollController.jumpTo(_scrollPosition);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: PickColors.whiteColor,
        drawerEnableOpenDragGesture: false,
        drawer: const DrawerWidget(),
        body: Consumer2(builder: (BuildContext context,
            TradeProvider tradeProvider, AuthProvider authProvider, snapshot) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isLoading
                      ? Container()
                      : Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                              color: PickColors.textFieldBorderColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            child: Center(
                              child: StockPrices(
                                stockData: stockData,
                                // data:
                                //     "NIFTY ${stockData[stockData.indexWhere((element) => element.token.toString().contains("256265"))].lastTradedPrice.toString()} -24.8% | BANKNIFTY ${stockData[stockData.indexWhere((element) => element.token.toString().contains("260105"))].lastTradedPrice.toString()} +12.58% | SENSEX ${stockData[stockData.indexWhere((element) => element.token.toString().contains("265"))].lastTradedPrice.toString()} +12.58% | TATA POWER ${stockData[stockData.indexWhere((element) => element.token.toString().contains("408065"))].lastTradedPrice.toString()} +12.58%",
                              ),
                            ),
                          ),
                        ),
                  PickHeightAndWidth.height10,
                  CommonHomeScreenContainer(
                    isPreSubscription:
                        authProvider.currentUserData!.isSubscribe ?? 0,
                  ),
                  PickHeightAndWidth.height10,
                  InkWell(
                    onTap: () {
                      changeScreen(
                          context: context, widget: SubscriptionDetailScreen());
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: PickColors.textFieldBorderColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        children: [
                          SvgPicture.asset(PickImages.subscriptionIcon),
                          PickHeightAndWidth.width5,
                          Expanded(
                            child: Text(
                              TradeTitles.becomePremiumSubscriber,
                              style:
                                  CommonTextStyle.mainHeadingTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          SvgPicture.asset(PickImages.nextIcon),
                        ],
                      ),
                    ),
                  ),
                  PickHeightAndWidth.height15,
                  authProvider.currentUserData!.isSubscribe == 1
                      ? CommonTabBarWidget(
                          selectedTabIndex: selectedTabIndex,
                          chipPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 25),
                          tabList: tradeProvider.tabName,
                          // const [
                          //   TradeTitles.shortTermCalls,
                          //   TradeTitles.longTermCalls
                          // ],
                          onTapSwitch: (index) {
                            setState(() async {
                              selectedTabIndex = index;
                              await tradeProvider.getTipDataApiService(
                                  context: context,
                                  dataParameter: {
                                    "page": 1,
                                    "limit": 10,
                                    "status": selectedTabIndex
                                  });
                            });
                          },
                        )
                      : Text(
                          "Recent Achieved Targets",
                          style: CommonTextStyle.subHeadingTextStyle.copyWith(
                            fontSize: 15,
                          ),
                        ),
                  PickHeightAndWidth.height10,
                  authProvider.currentUserData!.isSubscribe == 1
                      ? tradeProvider.termTipsList.isNotEmpty
                          ? TipsListWidget(
                              isPreSubscription:
                                  authProvider.currentUserData!.isSubscribe ??
                                      0,
                              listOfTips: tradeProvider.termTipsList,
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.screenHeight! / 10),
                              child: Center(
                                child: Text(
                                  "Not Data Found",
                                  style: CommonTextStyle.chipTextStyle.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            )
                      : tradeProvider.recentArchivedTargets.isNotEmpty
                          ? TipsListWidget(
                              isPreSubscription:
                                  authProvider.currentUserData!.isSubscribe ??
                                      0,
                              listOfTips: tradeProvider.recentArchivedTargets)
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.screenHeight! / 10),
                              child: Center(
                                child: Text(
                                  "Not Data Found",
                                  style: CommonTextStyle.chipTextStyle.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                  PickHeightAndWidth.height10,
                  Text(
                    TradeTitles.exploreShahsBest,
                    style: CommonTextStyle.mainHeadingTextStyle.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  PickHeightAndWidth.height10,
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            changeScreen(
                              context: context,
                              widget: SubscriptionDetailScreen(
                                selectedTabIndex: 1,
                              ),
                            );
                          },
                          child: Container(
                            height: SizeConfig.screenHeight! * 0.23,
                            decoration: BoxDecoration(
                                color: PickColors.primaryColor,
                                image: const DecorationImage(
                                  image: AssetImage(PickImages.learningImage),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(TradeTitles.learning,
                                        style: CommonTextStyle.noteTextStyle
                                            .copyWith(
                                          color: PickColors.whiteColor,
                                        )),
                                    PickHeightAndWidth.width10,
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2),
                                      child: SvgPicture.asset(
                                          PickImages.moveForward),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      PickHeightAndWidth.width10,
                      Expanded(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                tradeProvider.changeBottomBarIndex(
                                    selectedIndex: 0);
                              },
                              child: Container(
                                height: SizeConfig.screenHeight! * 0.23 / 2,
                                decoration: BoxDecoration(
                                    color: PickColors.primaryColor,
                                    image: const DecorationImage(
                                      image:
                                          AssetImage(PickImages.referralImage),
                                      fit: BoxFit.fill,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        // PickHeightAndWidth.height20,
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(TradeTitles.referral,
                                              style: CommonTextStyle
                                                  .noteTextStyle
                                                  .copyWith(
                                                color: PickColors
                                                    .textFieldTextColor,
                                              )),
                                        ),
                                        PickHeightAndWidth.width10,
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2),
                                          child: SvgPicture.asset(
                                              color:
                                                  PickColors.textFieldTextColor,
                                              PickImages.moveForward),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            PickHeightAndWidth.height5,
                            InkWell(
                              onTap: () {
                                changeScreen(
                                  context: context,
                                  widget: SubscriptionDetailScreen(),
                                );
                              },
                              child: Container(
                                  height: SizeConfig.screenHeight! * 0.23 / 2,
                                  decoration: BoxDecoration(
                                      color: PickColors.primaryColor,
                                      image: const DecorationImage(
                                        image:
                                            AssetImage(PickImages.offersImage),
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(TradeTitles.offers,
                                                style: CommonTextStyle
                                                    .noteTextStyle
                                                    .copyWith(
                                                  color: PickColors
                                                      .textFieldTextColor,
                                                )),
                                          ),
                                          PickHeightAndWidth.width10,
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2),
                                            child: SvgPicture.asset(
                                                color: PickColors
                                                    .textFieldTextColor,
                                                PickImages.moveForward),
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  PickHeightAndWidth.height20,
                  Text(
                    TradeTitles.letsFullFillYourDreamsWith,
                    style: CommonTextStyle.mainHeadingTextStyle.copyWith(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    TradeTitles.shahInvestment,
                    style: CommonTextStyle.mainHeadingTextStyle.copyWith(
                      fontSize: 20,
                      color: PickColors.primaryColor,
                    ),
                  ),
                  PickHeightAndWidth.height50,
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  List<int> subscribeToken = [265, 256265, 408065, 260105];
  // 260105 = NIFTY BANK
  // 265 = SENSEX
  // 256265 = NIFTY 50
  // 408065 = tataPower
  @override
  void onConnected(IOWebSocketChannel client) {
    _timer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      client.sink.add(jsonEncode({
        "a": "subscribe",
        "v": [265, 256265, 408065, 260105]
      }));
    });
  }

  @override
  void onData(
    List<Tick> list,
  ) {
    // print("*****************full data***************");
    // print(list);
    // print("*****************full data***************");
    if (!mounted) return;
    setState(() {
      list.forEach((element) {
        // print(element.lastTradedPrice);

        stockData.clear();
        stockDataToken.add(element.token.toString());
        stockData.addAll(list);
      }); // Update state with new data
    });
  }

  @override
  void onError(String error) {
    print(error);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

class TipsListWidget extends StatelessWidget {
  final List<TipsModel> listOfTips;
  final int isPreSubscription;
  const TipsListWidget({
    super.key,
    required this.listOfTips,
    required this.isPreSubscription,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: listOfTips.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            if (isPreSubscription == 1) {
              changeScreen(
                  context: context,
                  widget: PlanDetailScreen(
                    tipsData: listOfTips[index],
                  ));
            } else {}
          },
          child: HomePageCardDetails(
            tipData: listOfTips[index],
            isPreSubscription: isPreSubscription,
          ),
        );
      },
    );
  }
}

class StockPrices extends StatefulWidget {
  final List<Tick> stockData;
  const StockPrices({
    Key? key,
    required this.stockData,
  }) : super(key: key);

  @override
  State<StockPrices> createState() => _StockPricesState();
}

class _StockPricesState extends State<StockPrices> {
  late Timer timer;
  String data = '';
  List<String> stocks = [];

  @override
  void initState() {
    super.initState();
    // Start a timer to update stock data every second
    timer = Timer.periodic(const Duration(milliseconds: 1), (Timer t) {
      updateData();
    });
  }

  @override
  void dispose() {
    // Dispose the timer when the widget is removed from the tree
    timer.cancel();
    super.dispose();
  }

  void updateData() {
    if (widget.stockData.isNotEmpty) {
      data =
          "NIFTY ${widget.stockData[widget.stockData.indexWhere((element) => element.token.toString().contains("256265"))].lastTradedPrice.toString()} ${calculatePercentageChange(currentPrice: widget.stockData[widget.stockData.indexWhere((element) => element.token.toString().contains("256265"))].lastTradedPrice.toString(), previousPrice: widget.stockData[widget.stockData.indexWhere((element) => element.token.toString().contains("256265"))].openPrice.toString())} | BANKNIFTY ${widget.stockData[widget.stockData.indexWhere((element) => element.token.toString().contains("260105"))].lastTradedPrice.toString()} ${calculatePercentageChange(currentPrice: widget.stockData[widget.stockData.indexWhere((element) => element.token.toString().contains("260105"))].lastTradedPrice.toString(), previousPrice: widget.stockData[widget.stockData.indexWhere((element) => element.token.toString().contains("260105"))].openPrice.toString())} | SENSEX ${widget.stockData[widget.stockData.indexWhere((element) => element.token.toString().startsWith("265"))].lastTradedPrice.toString()} ${calculatePercentageChange(currentPrice: widget.stockData[widget.stockData.indexWhere((element) => element.token.toString().startsWith("265"))].lastTradedPrice.toString(), previousPrice: widget.stockData[widget.stockData.indexWhere((element) => element.token.toString().startsWith("265"))].openPrice.toString())} | INFOSYS ${widget.stockData[widget.stockData.indexWhere((element) => element.token.toString().contains("408065"))].lastTradedPrice.toString()} ${calculatePercentageChange(currentPrice: widget.stockData[widget.stockData.indexWhere((element) => element.token.toString().contains("408065"))].lastTradedPrice.toString(), previousPrice: widget.stockData[widget.stockData.indexWhere((element) => element.token.toString().contains("408065"))].openPrice.toString())}";
      stocks = data.split(' | ');
    } else {
      data = TradeTitles.animatedString;
      stocks = data.split(' | ');
    }
  }

  String calculatePercentageChange(
      {required String currentPrice, required String previousPrice}) {
    double percentageChange = ((double.tryParse(currentPrice)!.toDouble() -
                double.tryParse(previousPrice)!.toDouble()) /
            double.tryParse(previousPrice)!.toDouble()) *
        100;
    return '${percentageChange.toStringAsFixed(2)}%';
  }

  @override
  Widget build(BuildContext context) {
    return data != ''
        ? Row(
            children: [
              for (String stock in stocks) StockItem(item: stock),
            ],
          )
        : Row(
            children: [
              Center(
                child: Text(
                  "                                                          No Data available                                                             ",
                  style: CommonTextStyle.mainHeadingTextStyle.copyWith(
                    fontSize: 11,
                    color: PickColors.redColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
          );
  }
}

class StockItem extends StatelessWidget {
  final String item;
  const StockItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    List<String> parts = item.split(' ');

    String title = parts[0];
    String price = parts[1];
    String change = parts[2];

    Color color =
        change.contains('-') ? PickColors.redColor : PickColors.greenColor;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      child: RichText(
        text: TextSpan(
          style: CommonTextStyle.mainHeadingTextStyle.copyWith(
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
          children: [
            TextSpan(text: '  $title  '),
            TextSpan(
              text: '$price ',
              style: CommonTextStyle.mainHeadingTextStyle.copyWith(
                fontSize: 11,
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(
              text: change,
              style: CommonTextStyle.mainHeadingTextStyle.copyWith(
                fontSize: 11,
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
            const TextSpan(text: '  |  '),
          ],
        ),
      ),
    );
  }
}
