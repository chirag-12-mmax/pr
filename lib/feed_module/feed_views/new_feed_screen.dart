// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/navigation_screen.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/feed_module/feed_provider.dart';
import 'package:shah_investment/feed_module/feed_titles.dart';
import 'package:shah_investment/feed_module/feed_widgets/without_border_form_builder_text_field.dart';
import 'package:shah_investment/general_helper.dart';
import 'package:shah_investment/widgets/buttons/primary_button.dart';
import 'package:shah_investment/widgets/image_picker.dart';
import 'package:shah_investment/widgets/loaders/show_overlay_loader.dart';
import 'package:shah_investment/widgets/show_toast.dart';

class NewFeedScreen extends StatefulWidget {
  const NewFeedScreen({super.key});

  @override
  State<NewFeedScreen> createState() => _NewFeedScreenState();
}

class _NewFeedScreenState extends State<NewFeedScreen> {
  final _addNewFeedDetailsKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
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
          FeedTitles.newFeed,
          style: CommonTextStyle.noteTextStyle.copyWith(
            color: PickColors.blackColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: FormBuilder(
              key: _addNewFeedDetailsKey,
              child: const Column(
                children: [
                  ImagePickerControl(
                    isCandidatePhotoLabel: false,
                    isRequired: true,
                    isEnabled: true,
                    fieldName: "imagel",
                  ),
                  WithOutBorderCommonFormBuilderTextField(
                    hintTitle: FeedTitles.stringWriteSomethingAbout,
                    fieldKey: 'content',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 15.0, bottom: 15, right: 15),
        child: CommonMaterialButton(
          verticalPadding: 24,
          borderRadius: 16,
          title: FeedTitles.publish,
          onPressed: () async {
            _addNewFeedDetailsKey.currentState!.save();
            showOverlayLoader(context);
            if ((_addNewFeedDetailsKey.currentState!.value['imagel'] ?? [])
                    .isNotEmpty ||
                _addNewFeedDetailsKey.currentState!.value['content'] != null) {
              final generalHelperProvider =
                  Provider.of<GeneralHelper>(context, listen: false);
              final feedBackProvider =
                  Provider.of<FeedBackProvider>(context, listen: false);
              String? upLoadImageUrl;

              if ((_addNewFeedDetailsKey.currentState!.value['imagel'] ?? [])
                  .isNotEmpty) {
                upLoadImageUrl = await generalHelperProvider.imageUploadService(
                    fieName: _addNewFeedDetailsKey
                        .currentState!.value['imagel'].last.name,
                    fileByteData: await _addNewFeedDetailsKey
                        .currentState!.value['imagel'].last
                        .readAsBytes(),
                    context: context);
              }

              if (await feedBackProvider.addFeedBackApiService(
                context: context,
                dataParameter: {
                  if (upLoadImageUrl != null) "image": upLoadImageUrl,
                  if (_addNewFeedDetailsKey.currentState!.value['content'] !=
                          '' &&
                      _addNewFeedDetailsKey.currentState!.value['content'] !=
                          null)
                    'content':
                        _addNewFeedDetailsKey.currentState!.value['content'] ??
                            ""
                },
              )) {
                hideOverlayLoader();
                await showDialog(
                    context: context,
                    builder: (context) {
                      return const FeedConformationDialogBox();
                    });
                backToScreen(context: context);
              } else {
                hideOverlayLoader();
              }
            } else {
              showToast(
                  message: "Please Select Image Other Enter Wise Content",
                  isPositive: false,
                  context: context);
              hideOverlayLoader();
            }
          },
          color: PickColors.textFieldTextColor,
        ),
      ),
    );
  }
}

//Dialog box for conformation feed

class FeedConformationDialogBox extends StatelessWidget {
  const FeedConformationDialogBox({
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "When the admin will approve the feed, this feed will be shown in the feed screen.",
                  style: CommonTextStyle.noteTextStyle.copyWith(
                      color: PickColors.textFieldTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                ),
              ),
              const Divider(
                color: PickColors.textFieldBorderColor,
              ),
              InkWell(
                onTap: () {
                  backToScreen(context: context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Ok",
                    style: CommonTextStyle.noteTextStyle.copyWith(
                      color: PickColors.textFieldTextColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
