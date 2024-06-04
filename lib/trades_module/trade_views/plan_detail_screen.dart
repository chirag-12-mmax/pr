import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/navigation_screen.dart';
import 'package:shah_investment/constants/pick_height_width.dart';
import 'package:shah_investment/constants/size_config.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/trades_module/trade_models/tip_model.dart';
import 'package:shah_investment/trades_module/trade_provider.dart';
import 'package:shah_investment/trades_module/trade_titles.dart';
import 'package:shah_investment/widgets/buttons/primary_button.dart';
import 'package:shah_investment/widgets/buttons/round_chip.dart';
import 'package:shah_investment/widgets/prize_detail_container.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PlanDetailScreen extends StatefulWidget {
  const PlanDetailScreen({super.key, required this.tipsData});
  final TipsModel tipsData;

  @override
  State<PlanDetailScreen> createState() => _PlanDetailScreenState();
}

class _PlanDetailScreenState extends State<PlanDetailScreen> {
  bool isPositive = true;
  int selectedIndex = 0;
  bool isLoading = false;

  late List<ChartData> data;
  Path customPath = Path()
    ..moveTo(0, 100)
    ..arcToPoint(const Offset(200, 100), radius: const Radius.circular(100));

  @override
  void initState() {
    data = [];
    getTipsData();
    super.initState();
  }

  Future<void> getTipsData() async {
    setState(() {
      isLoading = true;
    });

    final tradeProvider = Provider.of<TradeProvider>(context, listen: false);
    await tradeProvider.getSingleTipDataApiService(
        context: context, tipsID: widget.tipsData.sId ?? "");

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isPositive
          ? PickColors.extraLightGreenColor
          : PickColors.extraLightRedColor,
      body: SafeArea(
        child: Consumer(builder:
            (BuildContext context, TradeProvider tradeProvider, snapshot) {
          return SingleChildScrollView(
            child: !isLoading
                ? Column(
                    children: [
                      Container(
                        height: SizeConfig.screenHeight! * 0.31,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    backToScreen(context: context);
                                  },
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: RoundChipWidget(
                                        chitTitle: "Back",
                                        chipIcon: Icons.arrow_left,
                                        chipColor: isPositive
                                            ? PickColors.lightGreenColor
                                            : PickColors.lightRedColor,
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Stock Name",
                                      style: CommonTextStyle.noteTextStyle
                                          .copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              tradeProvider.tipsDetail!
                                                      .findTips!.name ??
                                                  "-",
                                              style: CommonTextStyle
                                                  .subHeadingTextStyle
                                                  .copyWith(
                                                fontSize: 18,
                                              ),
                                            ),
                                            PickHeightAndWidth.width10,
                                            RoundChipWidget(
                                              chitTitle: "CE",
                                              horizontalPadding: 10,
                                              chipBorderColor: isPositive
                                                  ? PickColors.greenBorderColor
                                                  : PickColors.redBorderColor,
                                              verticalPadding: 0.1,
                                              chipTextColor: isPositive
                                                  ? PickColors.greenColor
                                                  : PickColors.redColor,
                                              chipColor: isPositive
                                                  ? PickColors.lightGreenColor
                                                  : PickColors.lightRedColor,
                                            ),
                                          ],
                                        ),
                                        RoundChipWidget(
                                          chitTitle: tradeProvider.tipsDetail!
                                                  .findTips!.status ??
                                              "-",
                                          horizontalPadding: 10,
                                          chipBorderColor:
                                              PickColors.textFieldTextColor,
                                          verticalPadding: 3,
                                          chipColor: Colors.transparent,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Last Trade Price",
                                      style: CommonTextStyle.noteTextStyle
                                          .copyWith(
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      "₹${tradeProvider.tipsDetail!.findTips!.lastPrice ?? "-"}",
                                      style: CommonTextStyle
                                          .mainHeadingTextStyle
                                          .copyWith(
                                        fontSize: 50,
                                      ),
                                    )
                                  ],
                                ),
                              ]),
                        ),
                      ),
                      SizedBox(
                        // height: SizeConfig.screenHeight! * 0.60,
                        height: SizeConfig.screenHeight! / 1.4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: const BoxDecoration(
                            color: PickColors.whiteColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Center(
                                  child: Stack(
                                    children: [
                                      SfCircularChart(
                                        margin: EdgeInsets.zero,
                                        series: <CircularSeries>[
                                          DoughnutSeries<ChartData, String>(
                                              innerRadius: '75%',
                                              explode: true,
                                              explodeAll: true,
                                              dataSource: [
                                                ChartData(
                                                  'David',
                                                  17,
                                                  color: getColorForPercentage(
                                                      min: 0,
                                                      max: 0.17,
                                                      currentPrice:
                                                          tradeProvider
                                                              .tipsDetail!
                                                              .findTips!
                                                              .lastPrice
                                                              .toString(),
                                                      previousPrice:
                                                          tradeProvider
                                                              .tipsDetail!
                                                              .findTips!
                                                              .targetPrice
                                                              .toString()),
                                                ),
                                                ChartData(
                                                  'Steve',
                                                  17,
                                                  color: getColorForPercentage(
                                                      min: 0,
                                                      max: 0.34,
                                                      currentPrice:
                                                          tradeProvider
                                                              .tipsDetail!
                                                              .findTips!
                                                              .lastPrice
                                                              .toString(),
                                                      previousPrice:
                                                          tradeProvider
                                                              .tipsDetail!
                                                              .findTips!
                                                              .targetPrice
                                                              .toString()),
                                                ),
                                                ChartData(
                                                  'Jack',
                                                  16,
                                                  color: getColorForPercentage(
                                                      min: 0,
                                                      max: 0.51,
                                                      currentPrice:
                                                          tradeProvider
                                                              .tipsDetail!
                                                              .findTips!
                                                              .lastPrice
                                                              .toString(),
                                                      previousPrice:
                                                          tradeProvider
                                                              .tipsDetail!
                                                              .findTips!
                                                              .targetPrice
                                                              .toString()),
                                                ),
                                                ChartData(
                                                  'Others',
                                                  16,
                                                  color: getColorForPercentage(
                                                      min: 0,
                                                      max: 0.68,
                                                      currentPrice:
                                                          tradeProvider
                                                              .tipsDetail!
                                                              .findTips!
                                                              .lastPrice
                                                              .toString(),
                                                      previousPrice:
                                                          tradeProvider
                                                              .tipsDetail!
                                                              .findTips!
                                                              .targetPrice
                                                              .toString()),
                                                ),
                                                ChartData(
                                                  'Others',
                                                  17,
                                                  color: getColorForPercentage(
                                                      min: 0,
                                                      max: 0.85,
                                                      currentPrice:
                                                          tradeProvider
                                                              .tipsDetail!
                                                              .findTips!
                                                              .lastPrice
                                                              .toString(),
                                                      previousPrice:
                                                          tradeProvider
                                                              .tipsDetail!
                                                              .findTips!
                                                              .targetPrice
                                                              .toString()),
                                                ),
                                                ChartData(
                                                  'Others',
                                                  17,
                                                  color: getColorForPercentage(
                                                      min: 0,
                                                      max: 1,
                                                      currentPrice:
                                                          tradeProvider
                                                              .tipsDetail!
                                                              .findTips!
                                                              .lastPrice
                                                              .toString(),
                                                      previousPrice:
                                                          tradeProvider
                                                              .tipsDetail!
                                                              .findTips!
                                                              .targetPrice
                                                              .toString()),
                                                )
                                              ],
                                              pointColorMapper:
                                                  (ChartData data, _) =>
                                                      data.color,
                                              xValueMapper:
                                                  (ChartData data, _) => data.x,
                                              yValueMapper:
                                                  (ChartData data, _) => data.y,
                                              // Starting angle of doughnut
                                              startAngle: 270,

                                              // Ending angle of doughnut
                                              endAngle: 90)
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: SizeConfig.screenHeight! *
                                                0.11),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Text(
                                                  "₹${tradeProvider.tipsDetail!.findTips!.lastPrice ?? "-"}",
                                                  style: CommonTextStyle
                                                      .mediumHeadingStyle
                                                      .copyWith(
                                                    fontSize: 28,
                                                  )),
                                            ),
                                            Center(
                                              child: Text("Last Trade Price",
                                                  style: CommonTextStyle
                                                      .chipTextStyle
                                                      .copyWith(
                                                          color: PickColors
                                                              .hintTextColor)),
                                            ),
                                            PickHeightAndWidth.height25,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                PrizeContainerWidget(
                                                  title: TradeTitles.buyPrice,
                                                  subTitle:
                                                      "₹${tradeProvider.tipsDetail!.findTips!.buyPrice}",
                                                ),
                                                PrizeContainerWidget(
                                                  title: TradeTitles.sLPrice,
                                                  subTitle:
                                                      "₹${tradeProvider.tipsDetail!.findTips!.stopLimit}",
                                                ),
                                                PrizeContainerWidget(
                                                  title:
                                                      TradeTitles.targetPrice,
                                                  subTitle:
                                                      "₹${tradeProvider.tipsDetail!.findTips!.targetPrice}",
                                                )
                                              ],
                                            ),
                                            PickHeightAndWidth.height40,
                                            Text(
                                              "LATEST ADDITIONS",
                                              style: CommonTextStyle
                                                  .smallTextStyle
                                                  .copyWith(
                                                color: PickColors.hintTextColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: tradeProvider
                                        .tipsDetail!.findAllTips!.isNotEmpty
                                    ? Row(
                                        children: List.generate(
                                            tradeProvider.tipsDetail!
                                                .findAllTips!.length, (index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4),
                                          child: PrizeContainerWidget(
                                            title: (DateFormat.MMMd().format(
                                                DateTime.parse(tradeProvider
                                                        .tipsDetail!
                                                        .findAllTips![index]
                                                        .createdAt ??
                                                    "-"))),
                                            subTitle:
                                                "₹${tradeProvider.tipsDetail!.findAllTips![index].lastPrice ?? "-"}",
                                            bgColor: index == selectedIndex
                                                ? isPositive
                                                    ? PickColors.lightGreenColor
                                                        .withOpacity(0.6)
                                                    : PickColors.lightRedColor
                                                        .withOpacity(0.6)
                                                : PickColors.lightGreyColor,
                                          ),
                                        );
                                      }))
                                    : const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 20),
                                        child: Text("No Tips found"),
                                      ),
                              ),
                              // ListView.builder(
                              //     scrollDirection: Axis.horizontal,
                              //     itemBuilder: (context, index) {
                              //       return PrizeContainerWidget(
                              //         title: "MAR 13",
                              //         subTitle: "₹35.00",
                              //       );
                              //     }),
                              PickHeightAndWidth.height20,
                              CommonMaterialButton(
                                  title: "Back to home",
                                  verticalPadding: 24,
                                  borderRadius: 16,
                                  color: PickColors.textFieldTextColor,
                                  onPressed: () {
                                    backToScreen(context: context);
                                  })
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.screenHeight! / 2.5),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
          );
        }),
      ),
    );
  }

  Color getColorForPercentage({
    required String currentPrice,
    required String previousPrice,
    required double min,
    required double max,
  }) {
    double percentageChange =
        double.tryParse(currentPrice)! / double.tryParse(previousPrice)!;

    Color color = Colors.green;

    if (percentageChange >= min && percentageChange <= max) {
      color = Colors.grey;
      print("****************true");
    }

    return color;
  }
}

class ChartData {
  final String x;
  final double y;
  final Color? color;

  ChartData(this.x, this.y, {this.color});
}

class JBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    double width = size.width;
    double height = size.height;
    // double radius = 10;

    final path = Path();

    // path.moveTo(0, radius);
    // path.arcToPoint(Offset(radius, 0), radius: Radius.circular(radius));
    // path.lineTo(width - radius, 0);
    // path.arcToPoint(
    //   Offset(width, radius),
    //   radius: Radius.circular(radius),
    // );
    // path.lineTo(width, (height / 2) - 5);
    // path.lineTo(width + 10, (height / 2));
    // path.lineTo(width, (height / 2) + 5);
    // path.lineTo(width, height - radius);
    // path.arcToPoint(Offset(width - radius, height),
    //     radius: Radius.circular(radius));
    // path.lineTo(radius, height);
    // path.arcToPoint(Offset(0, height - radius),
    //     radius: Radius.circular(radius));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}