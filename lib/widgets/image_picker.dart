import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/images_route.dart';
import 'package:shah_investment/constants/size_config.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/feed_module/feed_titles.dart';

class ImagePickerControl extends StatelessWidget {
  const ImagePickerControl(
      {super.key,
      required this.fieldName,
      this.bgColor,
      this.isEnabled = true,
      this.isRequired = false,
      this.onFileChange,
      this.isCandidatePhotoLabel = false,
      this.isProfile = false});

  final String fieldName;
  final Color? bgColor;
  final bool isEnabled;
  final bool isCandidatePhotoLabel;
  final bool isRequired;
  final dynamic onFileChange;
  final bool isProfile;

  @override
  Widget build(BuildContext context) {
    return FormBuilderImagePicker(
      previewHeight: isProfile ? 130 : SizeConfig.screenHeight! / 3.5,
      fit: BoxFit.cover,
      previewAutoSizeWidth: false,
      availableImageSources: const [
        ImageSourceOption.camera,
        ImageSourceOption.gallery
      ],
      transformImageWidget: (context, displayImage) => isProfile
          ? Card(
              clipBehavior: Clip.antiAlias,
              shape: const CircleBorder(),

              // child: displayImage
              child: SizedBox.expand(child: displayImage),
            )
          : Card(
              clipBehavior: Clip.antiAlias,
              // child: displayImage
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: displayImage,
              )),
            ),
      name: fieldName,
      enabled: isEnabled,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      placeholderWidget: MouseRegion(
        hitTestBehavior: HitTestBehavior.deferToChild,
        cursor: SystemMouseCursors.click,
        child: isProfile
            ? Center(
                child: CircleAvatar(
                  backgroundColor: PickColors.whiteColor,
                  radius: 50,
                  child: Image.asset(
                    height: 35,
                    width: 35,
                    PickImages.cameraImage,
                    fit: BoxFit.fill,
                    color: PickColors.textFieldDisableColor,
                  ),
                ),
              )
            : DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(20),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                dashPattern: const [5, 4],
                color: PickColors.textFieldDisableColor,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: SvgPicture.asset(PickImages.uploadIcon)),
                      Text(
                        FeedTitles.clickHereToUploadImage,
                        style: CommonTextStyle.subHeadingTextStyle.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          FeedTitles.imageSize,
                          style: CommonTextStyle.noteTextStyle.copyWith(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
      onChanged: onFileChange,
      validator: isProfile
          ? FormBuilderValidators.compose([
              if (isRequired)
                FormBuilderValidators.required(errorText: "Select Image"),
            ])
          : null,
      backgroundColor: PickColors.whiteColor,
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
          borderRadius: isProfile
              ? const BorderRadius.all(Radius.circular(80))
              : const BorderRadius.all(Radius.circular(5)),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: isProfile
              ? const BorderRadius.all(Radius.circular(80))
              : const BorderRadius.all(Radius.circular(5)),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(80)),
          borderSide: BorderSide(color: PickColors.primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(80)),
          borderSide: BorderSide(
              color: isProfile
                  ? PickColors.textFieldDisableColor
                  : PickColors.transparentColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(80)),
          borderSide: BorderSide(
              color: isProfile
                  ? PickColors.textFieldDisableColor
                  : PickColors.transparentColor),
        ),
        contentPadding: const EdgeInsets.all(-2.5),
        label: null,
        border: InputBorder.none,
        suffix: null,
        errorStyle: const TextStyle(
          color: PickColors.redColor,
        ),
      ),
      maxImages: 1,
    );
  }
}

// class FileUploadWidget extends StatelessWidget {
//   final String fieldName;
//   final bool isEnabled;
//   final bool isRequired;
//   final bool isAllowMultiple;
//   final Function(List<PlatformFile>?)? onChanged;
//   final String title;
//   const FileUploadWidget(
//       {super.key,
//       required this.fieldName,
//       required this.isEnabled,
//       required this.isRequired,
//       this.onChanged,
//       this.isAllowMultiple = false,
//       required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return FormBuilderFilePicker(
//       name: fieldName,
//       previewImages: false,
//       allowMultiple: false,
//       enabled: isEnabled,
//       maxFiles: isAllowMultiple ? null : 1,
//       withData: true,
//       validator: FormBuilderValidators.compose([
//         if (isRequired)
//           FormBuilderValidators.required(errorText: "$fieldName is Mandatory"),
//       ]),
//       onChanged: onChanged,
//       decoration: InputDecoration(
//           errorStyle: const TextStyle(
//             fontSize: 0,
//             height: 0.01,
//           ),
//           border: InputBorder.none,
//           suffix: null,
//           counter: Container()),
//       customFileViewerBuilder: (files, filesSetter) {
//         return Container();
//       },
//       typeSelectors: [
//         TypeSelector(
//           type: FileType.any,
//           selector: SizedBox(
//             child: DottedBorder(
//               borderType: BorderType.RRect,
//               padding: const EdgeInsets.all(10),
//               radius: const Radius.circular(8),
//               color: PickColors.hintColor,
//               // strokeWidth: 1,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     title,
//                     style: CommonTextStyle.subHeadingTextStyle
//                         .copyWith(fontSize: 13),
//                   ),
//                   PickHeightAndWidth.width15,
//                   SvgPicture.asset(
//                     PickImages.uploadIcon,
//                     height: 30,
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
