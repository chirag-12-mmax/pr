// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shah_investment/constants/api_info/api_routes.dart';
import 'package:shah_investment/constants/api_info/common_api_structure.dart';
import 'package:shah_investment/logical_functions/debug_print.dart';
import 'package:shah_investment/referral_module/referral_models/referral_user_history_model.dart';
import 'package:shah_investment/widgets/show_toast.dart';

class ReferralProvider with ChangeNotifier {
  List<ReferralUserHistoryModel> referralUserHistoryDataList = [];
  int totalReferralHistoryCount = 0;
  Future<bool> referralHistoryApiService({
    required dynamic dataParameter,
    required BuildContext context,
    required bool isFromLoad,
  }) async {
    try {
      var response = await ApiManager.requestApi(
          context: context,
          endPoint: APIRoutes.referralHistoryApiRoute,
          serviceLabel: "Referral History List",
          isQueryParameter: true,
          dataParameter: dataParameter,
          apiMethod: APIMethod.GET);

      if (response != null) {
        if (response["status"].toString() == "200") {
          if (!isFromLoad) {
            referralUserHistoryDataList.clear();
          }
          response["data"]["referralData"].forEach((ele) {
            referralUserHistoryDataList
                .add(ReferralUserHistoryModel.fromJson(ele));
          });
          if (!isFromLoad) {
            totalReferralHistoryCount = response["data"]["totalCount"];
          }

          notifyListeners();
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      printDebug(textString: "Error Referral Service : $e");
      return false;
    }
  }

  //Get Address and Referral Day Data Service

  String? address;
  String? referralDay;

  Future<bool> getAddressAndReferralDayDataApiService({
    required BuildContext context,
  }) async {
    try {
      var response = await ApiManager.requestApi(
        endPoint: APIRoutes.getRaferdayApiRoute,
        serviceLabel: "Get Address And Refer Day Data List",
        isQueryParameter: true,
        apiMethod: APIMethod.GET,
        context: context,
      );

      if (response != null) {
        if (response["status"].toString() == "200") {
          referralDay = (response["data"]["referDay"] ?? "").toString();
          address = response["data"]["address"] ?? "";

          notifyListeners();
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      printDebug(textString: "Error Address And Refer Day Data Service : $e");
      return false;
    }
  }

  Future<bool> autoCutPaymentApiService({
    required dynamic dataParameter,
    required BuildContext context,
  }) async {
    try {
      var response = await ApiManager.requestApi(
          context: context,
          endPoint: APIRoutes.autoCutPaymentApiRoute,
          serviceLabel: "AutoCut Payment",
          dataParameter: dataParameter,
          apiMethod: APIMethod.PUT);

      if (response != null) {
        if (response["status"].toString() == "200") {
          showToast(
              message: response["message"], isPositive: true, context: context);
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      printDebug(textString: "Error AutoCut Payment Service : $e");
      return false;
    }
  }
}
