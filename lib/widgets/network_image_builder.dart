import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/generate_logo_name.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shimmer/shimmer.dart';

class BuildLogoProfileImageWidget extends StatefulWidget {
  final String? imagePath;
  final String? titleName;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BorderRadiusGeometry? borderRadius;
  final bool isColors;
  const BuildLogoProfileImageWidget(
      {super.key,
      required this.imagePath,
      required this.titleName,
      this.borderRadius,
      this.isColors = false,
      this.height,
      this.fit,
      this.width});

  @override
  State<BuildLogoProfileImageWidget> createState() =>
      _BuildLogoProfileImageWidgetState();
}

class _BuildLogoProfileImageWidgetState
    extends State<BuildLogoProfileImageWidget> {
  @override
  Widget build(BuildContext context) {
    return (widget.imagePath != null && widget.imagePath != "")
        ? NetWorkImageBuilder(
            fit: widget.fit,
            borderRadius: widget.borderRadius,
            height: widget.height ?? 40,
            width: widget.width ?? 40,
            imageUrl: widget.imagePath!,
          )
        : Container(
            height: widget.height ?? 40,
            width: widget.width ?? 40,
            // padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
              color: widget.isColors
                  ? PickColors.primaryColor.withOpacity(0.3)
                  : PickColors.greyColor,
            ),
            child: Center(
              child: Text(
                getLogoFromName(firstName: widget.titleName) ?? "",
                style: CommonTextStyle.noteTextStyle.copyWith(
                    fontSize: (widget.height ?? 40) / 2,
                    color: widget.isColors
                        ? PickColors.primaryColor
                        : Color(0x80808080)),
              ),
            ),
          );
  }
}

class NetWorkImageBuilder extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final BorderRadiusGeometry? borderRadius;
  final BoxFit? fit;

  const NetWorkImageBuilder({
    Key? key,
    required this.imageUrl,
    required this.height,
    required this.width,
    required this.borderRadius,
    this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                image: DecorationImage(
                  image: imageProvider,
                  fit: fit ?? BoxFit.cover,
                  // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn),
                ),
              ),
            ),
        placeholder: (context, url) {
          return Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              // color: PickColors.bgColor,
            ),
            child: Shimmer.fromColors(
                child: Container(),
                baseColor: Colors.grey[200]!,
                highlightColor: Colors.white),
          );
        },
        errorWidget: (context, url, error) => Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: PickColors.greyColor,
              ),
              child: const Icon(
                Icons.warning_amber_rounded,
                color: Colors.red,
              ),
            ));
  }
}
