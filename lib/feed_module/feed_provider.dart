// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:shah_investment/constants/api_info/api_routes.dart';
import 'package:shah_investment/constants/api_info/common_api_structure.dart';
import 'package:shah_investment/feed_module/feed_models/feed_back_model.dart';
import 'package:shah_investment/logical_functions/debug_print.dart';
import 'package:shah_investment/widgets/show_toast.dart';

class FeedBackProvider with ChangeNotifier {
  //-----------------------add Feedback
  Future<bool> addFeedBackApiService({
    required dynamic dataParameter,
    required BuildContext context,
  }) async {
    try {
      var response = await ApiManager.requestApi(
          context: context,
          endPoint: APIRoutes.addFeedBackApiRoute,
          serviceLabel: "Add FeedBack ",
          dataParameter: dataParameter,
          apiMethod: APIMethod.POST);

      if (response != null) {
        if (response["status"].toString() == "200") {
          // showToast(
          //     message: response["message"], isPositive: true, context: context);
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
      printDebug(textString: "Error During Add FeedBack Service : $e");
      return false;
    }
  }

  // Get feedBack List Service
  List<FeedBackModel> currentUserFeedBackList = [];
  int totalFeedbackCount = 0;
  Future<bool> getFeedBackApiService({
    required dynamic dataParameter,
    required BuildContext context,
    required bool isFromLoad,
  }) async {
    try {
      var response = await ApiManager.requestApi(
          context: context,
          endPoint: APIRoutes.getFeedBackApiRoute,
          serviceLabel: "Get FeedBack List",
          isQueryParameter: true,
          dataParameter: dataParameter,
          apiMethod: APIMethod.GET);

      if (response != null) {
        if (response["status"].toString() == "200") {
          if (!isFromLoad) {
            currentUserFeedBackList.clear();
          }
          response["data"]["data"].forEach((ele) {
            currentUserFeedBackList.add(FeedBackModel.fromJson(ele));
          });
          if (!isFromLoad) {
            totalFeedbackCount = response["data"]["totalCount"];
          }

          notifyListeners();
          return true;
        } else if (response["status"].toString() == "404") {
          currentUserFeedBackList.clear();
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
      printDebug(textString: "Error Get Feed Back Service : $e");
      return false;
    }
  }

  //----------------------------addLike on FeedBack
  Future<bool> addLikeOnFeedBackApiService({
    required dynamic dataParameter,
    required BuildContext context,
  }) async {
    try {
      var response = await ApiManager.requestApi(
          context: context,
          endPoint: APIRoutes.addLinkOnFeedBackApiRoute,
          serviceLabel: "Add Like on FeedBack",
          dataParameter: dataParameter,
          apiMethod: APIMethod.POST);

      if (response != null) {
        if (response["status"].toString() == "200") {
          // showToast(
          //     message: response["message"], isPositive: true, context: context);
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
      printDebug(textString: "Error During Add Like Service : $e");
      return false;
    }
  }

  //----------------------------addLike on FeedBack
  Future<bool> removeLikeOnFeedBackApiService({
    required dynamic dataParameter,
    required BuildContext context,
  }) async {
    try {
      var response = await ApiManager.requestApi(
          context: context,
          endPoint: APIRoutes.removeLinkOnFeedBackApiRoute,
          serviceLabel: "Remove Like on FeedBack",
          dataParameter: dataParameter,
          apiMethod: APIMethod.PUT);

      if (response != null) {
        if (response["status"].toString() == "200") {
          // showToast(
          //     message: response["message"], isPositive: true, context: context);
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
      printDebug(textString: "Error During Remove Like Service : $e");
      return false;
    }
  }

  //----------------------------add Report on FeedBack
  Future<bool> addReportOnFeedBackApiService({
    required dynamic dataParameter,
    required BuildContext context,
  }) async {
    try {
      var response = await ApiManager.requestApi(
          context: context,
          endPoint: APIRoutes.addReportOnFeedBackApiRoute,
          serviceLabel: "Add Report On FeedBack",
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
      printDebug(
          textString: "Error During Add Report on FeedBack Service : $e");
      return false;
    }
  }

  //----------------------------add Report on FeedBack
  Future<bool> blockFeedBackApiService({
    required dynamic dataParameter,
    required BuildContext context,
  }) async {
    try {
      var response = await ApiManager.requestApi(
          context: context,
          endPoint: APIRoutes.blockFeedBackApiRoute,
          serviceLabel: "Block FeedBack",
          dataParameter: dataParameter,
          apiMethod: APIMethod.PUT);

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
      printDebug(textString: "Error During Block FeedBack Service : $e");
      return false;
    }
  }
}
