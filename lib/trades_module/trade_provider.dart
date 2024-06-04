// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kiteparser/kite/kite_ticker.dart';
import 'package:shah_investment/constants/api_info/api_routes.dart';
import 'package:shah_investment/constants/api_info/common_api_structure.dart';
import 'package:shah_investment/logical_functions/debug_print.dart';
import 'package:shah_investment/trades_module/trade_models/notification_model.dart';
import 'package:shah_investment/trades_module/trade_models/offer_model.dart';
import 'package:shah_investment/trades_module/trade_models/subscription_model.dart';
import 'package:shah_investment/trades_module/trade_models/tab_model.dart';
import 'package:shah_investment/trades_module/trade_models/tip_details_model.dart';
import 'package:shah_investment/trades_module/trade_models/tip_model.dart';
import 'package:shah_investment/widgets/show_toast.dart';

class TradeProvider with ChangeNotifier {
  int bottomNavIndex = 1;

  void changeBottomBarIndex({required int selectedIndex}) {
    bottomNavIndex = selectedIndex;
    notifyListeners();
  }

  //Get Tips Data
  List<TipsModel> termTipsList = [];

  Future<bool> getTipDataApiService({
    required BuildContext context,
    required dynamic dataParameter,
  }) async {
    try {
      var response = await ApiManager.requestApi(
        context: context,
        endPoint: APIRoutes.getTipDataApiRoute,
        serviceLabel: "Get Tip Data",
        isQueryParameter: true,
        dataParameter: dataParameter,
        apiMethod: APIMethod.GET,
      );

      if (response != null) {
        if (response["status"].toString() == "200") {
          termTipsList.clear();
          response["data"]["findTips"].forEach((ele) {
            termTipsList.add(TipsModel.fromJson(ele));
          });
          notifyListeners();
          return true;
        } else {
          showToast(
              message: response["message"],
              isPositive: false,
              context: context);
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      printDebug(textString: "Error During Get Tip Data Service : $e");
      return false;
    }
  }

  //Get recent Archived Targets Tips Data
  List<TipsModel> recentArchivedTargets = [];

  Future<bool> getPreviousTipsDataApiService({
    required BuildContext context,
  }) async {
    try {
      var response = await ApiManager.requestApi(
        context: context,
        endPoint: APIRoutes.getPreviousTipsDataApiRoute,
        serviceLabel: "Get Recent Archived Targets Data",
        apiMethod: APIMethod.GET,
      );

      if (response != null) {
        if (response["status"].toString() == "200") {
          recentArchivedTargets.clear();

          response["data"].forEach((ele) {
            recentArchivedTargets.add(TipsModel.fromJson(ele));
          });
          notifyListeners();
          return true;
        } else {
          // showToast(
          //     message: response["message"],
          //     isPositive: false,
          //     context: context);
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      printDebug(
          textString:
              "Error During Get Recent Archived Targets Data Service : $e");
      return false;
    }
  }

  // get single tip data
  TipsDetailsModel? tipsDetail;

  Future<bool> getSingleTipDataApiService({
    required BuildContext context,
    required String tipsID,
  }) async {
    try {
      var response = await ApiManager.requestApi(
        context: context,
        endPoint: APIRoutes.getSingleTipDataApiRoute + tipsID,
        serviceLabel: "Get Single Tip Data",
        apiMethod: APIMethod.GET,
      );

      if (response != null) {
        if (response["status"].toString() == "200") {
          tipsDetail = TipsDetailsModel.fromJson(response["data"]);
          notifyListeners();
          return true;
        } else {
          showToast(
              message: response["message"],
              isPositive: false,
              context: context);
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      printDebug(textString: "Error During Get Single Tip Data Service : $e");
      return false;
    }
  }

  // Get feedBack List Service
  List<SubscriptionModel> subscriptionDataList = [];
  int totalSubscriptionCount = 0;
  Future<bool> getSubscriptionDataApiService({
    required dynamic dataParameter,
    required BuildContext context,
    required bool isFromLoad,
  }) async {
    try {
      var response = await ApiManager.requestApi(
          context: context,
          endPoint: APIRoutes.getSubscriptionDataApiRoute,
          serviceLabel: "Get Subscription List",
          isQueryParameter: true,
          dataParameter: dataParameter,
          apiMethod: APIMethod.GET);

      if (response != null) {
        if (response["status"].toString() == "200") {
          if (!isFromLoad) {
            subscriptionDataList.clear();
          }
          response["data"]["getSubscription"].forEach((ele) {
            subscriptionDataList.add(SubscriptionModel.fromJson(ele));
          });
          if (!isFromLoad) {
            totalSubscriptionCount = response["data"]["totalCount"];
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
      printDebug(textString: "Error Get Feed Back  Service : $e");
      return false;
    }
  }

  //Notification Service =============================
  List<NotificationModel> notificationDataList = [];
  int totalNotificationCount = 0;
  Future<bool> notificationApiService({
    required dynamic dataParameter,
    required BuildContext context,
    required bool isFromLoad,
  }) async {
    try {
      var response = await ApiManager.requestApi(
          context: context,
          endPoint: APIRoutes.notificationApiRoute,
          serviceLabel: "Notification Data List",
          isQueryParameter: true,
          dataParameter: dataParameter,
          apiMethod: APIMethod.GET);

      if (response != null) {
        if (response["status"].toString() == "200") {
          if (!isFromLoad) {
            notificationDataList.clear();
          }
          response["data"]["findNotification"].forEach((ele) {
            notificationDataList.add(NotificationModel.fromJson(ele));
          });
          if (!isFromLoad) {
            totalNotificationCount = response["data"]["count"];
          }
          notifyListeners();
          return true;
        } else if (response["status"].toString() == "500") {
          notificationDataList.clear();

          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      printDebug(textString: "Error Notification List Service : $e");
      return false;
    }
  }

  List<Tick> stockListData = [];

  void changeLiveStokeData({required List<Tick> stockListData}) {
    stockListData = stockListData;
    print("*************${stockListData.toList()}");
    notifyListeners();
  }

  // Buy SubscriptionPlan Service =============================

  Future<bool> buySubscriptionPlanApiService({
    required dynamic dataParameter,
    required BuildContext context,
  }) async {
    try {
      var response = await ApiManager.requestApi(
          context: context,
          endPoint: APIRoutes.buySubscriptionPlanApiRoute,
          serviceLabel: "Buy SubscriptionPlan",
          dataParameter: dataParameter,
          apiMethod: APIMethod.POST);

      if (response != null) {
        if (response["status"].toString() == "200") {
          showToast(
              message: response["message"], isPositive: true, context: context);
          return true;
        } else {
          showToast(
              message: response["message"],
              isPositive: false,
              context: context);
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      printDebug(textString: "Error NBuy SubscriptionPlan Service : $e");
      return false;
    }
  }

  // Get TabBar Service =============================
  List<TabModel> tabNameDataList = [];
  List<String> tabName = [];
  Future<bool> getTabApiService({
    required BuildContext context,
  }) async {
    try {
      var response = await ApiManager.requestApi(
          context: context,
          endPoint: APIRoutes.getTabApiRoute,
          serviceLabel: "Get Tab Bar Name Service",
          apiMethod: APIMethod.GET);

      if (response != null) {
        if (response["status"].toString() == "200") {
          tabName.clear();
          response["data"].forEach((ele) {
            tabName.add(ele["name"].toString());
            tabNameDataList.add(TabModel.fromJson(ele));
          });
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      printDebug(textString: "Error get Tab Name Service : $e");
      return false;
    }
  }

  // Get TabBar Service =============================
  List<OfferModel> offerDataList = [];

  Future<bool> getSubscriptionOfferApiService({
    required BuildContext context,
  }) async {
    try {
      var response = await ApiManager.requestApi(
          context: context,
          endPoint: APIRoutes.getSubscriptionOfferApiRoute,
          serviceLabel: "Get Subscription Offer Service",
          apiMethod: APIMethod.GET);

      if (response != null) {
        if (response["status"].toString() == "200") {
          response["data"].forEach((ele) {
            offerDataList.add(OfferModel.fromJson(ele));
          });
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      printDebug(textString: "Error  Subscription Offer  Service : $e");
      return false;
    }
  }
}
