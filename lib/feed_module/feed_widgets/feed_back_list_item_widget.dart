import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/date_formates.dart';
import 'package:shah_investment/constants/images_route.dart';
import 'package:shah_investment/constants/pick_height_width.dart';
import 'package:shah_investment/constants/size_config.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/feed_module/feed_models/feed_back_model.dart';
import 'package:shah_investment/feed_module/feed_provider.dart';
import 'package:shah_investment/feed_module/feed_titles.dart';
import 'package:shah_investment/widgets/loaders/show_overlay_loader.dart';
import 'package:shah_investment/widgets/network_image_builder.dart';

class FeedBackListItemWidget extends StatefulWidget {
  final FeedBackModel feedBackData;
  final void Function() onTapLike;
  final int index;

  const FeedBackListItemWidget({
    super.key,
    required this.feedBackData,
    required this.onTapLike,
    required this.index,
  });

  @override
  State<FeedBackListItemWidget> createState() => _FeedBackListItemWidgetState();
}

class _FeedBackListItemWidgetState extends State<FeedBackListItemWidget> {
  bool isLoading = false;
  int currentPageIndex = 1;
  int numberOfDataPerPage = 10;
  int selectedTabIndex = 0;
  final ValueNotifier<bool> isPageLoading = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuildLogoProfileImageWidget(
              height: 50,
              width: 50,
              borderRadius: BorderRadius.circular(10),
              imagePath: widget.feedBackData.userData?.profileImage ?? "-",
              titleName: widget.feedBackData.userData?.name ?? "-"),
          PickHeightAndWidth.width12,
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              widget.feedBackData.userData?.name ?? "-",
                              overflow: TextOverflow.ellipsis,
                              style:
                                  CommonTextStyle.subHeadingTextStyle.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          PickHeightAndWidth.width5,
                          SvgPicture.asset(PickImages.verifyIcon)
                        ],
                      ),
                      PickHeightAndWidth.height2,
                      Row(
                        children: [
                          // Text(
                          //   "@user01",
                          //   style: CommonTextStyle.textFieldTextStyle.copyWith(
                          //     color: PickColors.hintTextColor,
                          //     fontSize: 14,
                          //   ),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 3),
                          //   child:
                          //       SvgPicture.asset(height: 5, PickImages.ellipseIcon),
                          // ),
                          Text(
                            dateDifference(
                                widget.feedBackData.createdAt.toString()),
                            style: CommonTextStyle.noteTextStyle.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
                  GestureDetector(
                    onTapDown: (details) {
                      showPopupMenu(
                          index: widget.index,
                          context: context,
                          details: details,
                          feedBackId: widget.feedBackData.sId.toString());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SvgPicture.asset(
                        PickImages.moreIcon,
                      ),
                    ),
                  )
                ],
              ),
              PickHeightAndWidth.height10,
              Text(
                widget.feedBackData.content ?? "-",
                style: CommonTextStyle.chipTextStyle.copyWith(
                  fontSize: 13,
                ),
              ),
              PickHeightAndWidth.width10,
              if (widget.feedBackData.image != null &&
                  widget.feedBackData.image != "") ...[
                PickHeightAndWidth.height5,
                BuildLogoProfileImageWidget(
                    height: 300,
                    width: SizeConfig.screenWidth,
                    borderRadius: BorderRadius.circular(10),
                    imagePath: widget.feedBackData.image ?? "-",
                    titleName: ""),
                PickHeightAndWidth.height10,
              ],
              PickHeightAndWidth.height10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: widget.onTapLike,
                    child: Row(
                      children: [
                        widget.feedBackData.like == 0
                            ? SvgPicture.asset(
                                PickImages.thumbOffIcon,
                              )
                            : SvgPicture.asset(
                                PickImages.thumbOnIcon,
                              ),
                        PickHeightAndWidth.width5,
                        Text(
                          widget.feedBackData.likeCount.toString(),
                          style: CommonTextStyle.noteTextStyle.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        PickImages.commentIcon,
                      ),
                      PickHeightAndWidth.width5,
                      Text(
                        "92",
                        style: CommonTextStyle.noteTextStyle.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset(
                            PickImages.saveIcon,
                          )),
                      PickHeightAndWidth.width5,
                      Text(
                        FeedTitles.save,
                        style: CommonTextStyle.noteTextStyle.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        PickImages.shareIcon,
                      ),
                      PickHeightAndWidth.width5,
                      Text(
                        FeedTitles.share,
                        style: CommonTextStyle.noteTextStyle.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  showPopupMenu(
      {required BuildContext context,
      required TapDownDetails details,
      required int index,
      required String feedBackId}) {
    showMenu<int>(
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        details.globalPosition.dx,
        details.globalPosition.dy,
      ),
      items: [
        PopupMenuItem<int>(
            value: 1,
            child: Row(
              children: [
                const Icon(
                  Icons.block,
                  color: PickColors.redColor,
                ),
                PickHeightAndWidth.width10,
                Text(
                  'Block FeedBack',
                  style: CommonTextStyle.chipTextStyle.copyWith(
                    fontSize: 13,
                  ),
                ),
              ],
            )),
        PopupMenuItem<int>(
            value: 2,
            child: Row(
              children: [
                const Icon(
                  Icons.report,
                  color: PickColors.redColor,
                ),
                PickHeightAndWidth.width10,
                Text(
                  'Report FeedBack',
                  style: CommonTextStyle.chipTextStyle.copyWith(
                    fontSize: 13,
                  ),
                ),
              ],
            )),
      ],
      elevation: 8.0,
    ).then<void>((int? itemSelected) async {
      if (itemSelected == null) return;

      if (itemSelected == 1) {
        showOverlayLoader(context);
        final feedBackProvider =
            Provider.of<FeedBackProvider>(context, listen: false);

        if (await feedBackProvider.blockFeedBackApiService(dataParameter: {
          "feedId": feedBackId,
        }, context: context)) {
          await feedBackProvider.getFeedBackApiService(
            dataParameter: {
              "page": 1,
              "limit": 10,
              "status": selectedTabIndex,
            },
            context: context,
            isFromLoad: false,
          );
          hideOverlayLoader();
        } else {
          hideOverlayLoader();
        }
      } else {
        showOverlayLoader(context);
        final feedBackProvider =
            Provider.of<FeedBackProvider>(context, listen: false);

        if (await feedBackProvider
            .addReportOnFeedBackApiService(dataParameter: {
          "feedId": feedBackId,
        }, context: context)) {
          hideOverlayLoader();
        } else {
          hideOverlayLoader();
        }
      }
    });
  }
}
