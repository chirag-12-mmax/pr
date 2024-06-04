import 'package:flutter/material.dart';
import 'package:shah_investment/auth_module/auth_widgets/delete_conformation_dialog_box.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/images_route.dart';
import 'package:shah_investment/constants/navigation_screen.dart';
import 'package:shah_investment/constants/pick_height_width.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:shah_investment/trades_module/trade_titles.dart';
import 'package:shah_investment/widgets/buttons/primary_button.dart';
import 'package:shah_investment/widgets/form_controls/text_field_control.dart';
import 'package:shah_investment/widgets/show_toast.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  TextEditingController descriptionController = TextEditingController();
  String _selectedValue = '';
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
          TradeTitles.accountSetting,
          style: CommonTextStyle.noteTextStyle.copyWith(
            color: PickColors.blackColor,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TradeTitles.deleteAccount,
                  style: CommonTextStyle.mainHeadingTextStyle
                      .copyWith(fontSize: 24),
                ),
                PickHeightAndWidth.height10,
                const Text(
                  TradeTitles.deleteAccountDescription,
                  style: CommonTextStyle.noteTextStyle,
                ),
                PickHeightAndWidth.height25,
                const Divider(
                  color: PickColors.textFieldBorderColor,
                ),
                PickHeightAndWidth.height25,
                Text(
                  TradeTitles.reason,
                  style: CommonTextStyle.noteTextStyle.copyWith(fontSize: 13),
                ),
                PickHeightAndWidth.height5,
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      border:
                          Border.all(color: PickColors.textFieldDisableColor)),
                  child: RadioListTile<String>(
                    activeColor: PickColors.primaryColor,
                    title: Text(
                      TradeTitles.noLongerWant,
                      style: CommonTextStyle.noteTextStyle
                          .copyWith(color: PickColors.blackColor),
                    ),
                    value: "no_longer_use_account",
                    groupValue: _selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedValue = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.trailing,
                    contentPadding: const EdgeInsets.all(0),
                    dense: true,
                  ),
                ),
                PickHeightAndWidth.height10,
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      border:
                          Border.all(color: PickColors.textFieldDisableColor)),
                  child: RadioListTile<String>(
                    activeColor: PickColors.primaryColor,
                    title: Text(
                      TradeTitles.mergeMultipleAccount,
                      style: CommonTextStyle.noteTextStyle
                          .copyWith(color: PickColors.blackColor),
                    ),
                    value: "Merge_multiple_account",
                    groupValue: _selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedValue = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.trailing,
                    contentPadding: const EdgeInsets.all(0),
                    dense: true,
                  ),
                ),
                PickHeightAndWidth.height25,
                Text(
                  TradeTitles.other,
                  style: CommonTextStyle.noteTextStyle.copyWith(fontSize: 13),
                ),
                CommonFormBuilderTextField(
                  textStyle: CommonTextStyle.noteTextStyle
                      .copyWith(color: PickColors.blackColor),
                  fieldKey: 'descriptionKey',
                  textController: descriptionController,
                  hint: TradeTitles.enterDescription,
                  isRequired: false,
                  validationKey: '',
                  maxLines: 5,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 15.0, bottom: 15, right: 15),
        child: CommonMaterialButton(
          title: TradeTitles.deleteAccount,
          onPressed: () async {
            if (_selectedValue != "") {
              await confirmDelete(
                  context: context,
                  description: descriptionController.text.isEmpty
                      ? ""
                      : descriptionController.text,
                  reason: _selectedValue);
            } else {
              showToast(
                  message: "Please select any one reason",
                  isPositive: false,
                  context: context);
            }
          },
          color: PickColors.redColor,
          prefixIcon: PickImages.deleteAccountIcon,
          borderRadius: 30,
          verticalPadding: 16,
        ),
      ),
    );
  }
}
