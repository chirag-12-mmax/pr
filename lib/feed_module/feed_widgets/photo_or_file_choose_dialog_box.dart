import 'package:flutter/material.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/feed_module/feed_titles.dart';

class PhotosOrFilesPickerDialogBox extends StatelessWidget {
  const PhotosOrFilesPickerDialogBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
            color: PickColors.whiteColor,
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                FeedTitles.chooseFromPhotos,
                style: CommonTextStyle.subHeadingTextStyle
                    .copyWith(fontSize: 14, color: PickColors.blackColor),
              ),
            ),
            const Divider(
              color: PickColors.textFieldBorderColor,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                "Choose From File",
                style: CommonTextStyle.subHeadingTextStyle
                    .copyWith(fontSize: 14, color: PickColors.blackColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
