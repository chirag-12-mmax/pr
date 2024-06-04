import 'package:flutter/material.dart';
import 'package:shah_investment/constants/api_info/api_routes.dart';
import 'package:shah_investment/constants/api_info/common_api_structure.dart';
import 'package:shah_investment/logical_functions/debug_print.dart';
import 'package:shah_investment/subscription_module/subscription_models/payment_history_model.dart';

class SubscriptionProvider with ChangeNotifier {
  List<PaymentHistoryModel> paymentHistoryDataList = [];
  int totalPaymentHistoryCount = 0;
  Future<bool> getPaymentHistoryApiService({
    required dynamic dataParameter,
    required BuildContext context,
    required bool isFromLoad,
  }) async {
    try {
      var response = await ApiManager.requestApi(
          context: context,
          endPoint: APIRoutes.getPaymentHistoryApiRoute,
          serviceLabel: "Payment History List",
          isQueryParameter: true,
          dataParameter: dataParameter,
          apiMethod: APIMethod.GET);

      if (response != null) {
        if (response["status"].toString() == "200") {
          if (!isFromLoad) {
            paymentHistoryDataList.clear();
          }
          response["data"]["findHistory"].forEach((ele) {
            paymentHistoryDataList.add(PaymentHistoryModel.fromJson(ele));
          });
          if (!isFromLoad) {
            totalPaymentHistoryCount = response["data"]["count"];
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
      printDebug(textString: "Error in Payment History List Service : $e");
      return false;
    }
  }
}
