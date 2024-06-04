// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shah_investment/auth_module/auth_models/user_model.dart';
import 'package:shah_investment/constants/api_info/api_routes.dart';
import 'package:shah_investment/constants/api_info/common_api_structure.dart';
import 'package:shah_investment/constants/share_pref_keys.dart';
import 'package:shah_investment/constants/share_preference.dart';
import 'package:shah_investment/logical_functions/debug_print.dart';
import 'package:shah_investment/widgets/show_toast.dart';

class AuthProvider with ChangeNotifier {
  //for FCM token
  String? fcmToken;

  //Send OTP To User Mobile NumberService
  Future<bool> sendOtpApiService({
    required dynamic dataParameter,
    required BuildContext context,
  }) async {
    try {
      var response = await ApiManager.requestApi(
          context: context,
          endPoint: APIRoutes.sendOtpApiRoute,
          serviceLabel: "Send OTP",
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
      printDebug(textString: "Error During Send OTP Service : $e");
      return false;
    }
  }

  Future<bool> signUpApiService({
    required dynamic dataParameter,
    required BuildContext context,
  }) async {
    try {
      var response = await ApiManager.requestApi(
          context: context,
          endPoint: APIRoutes.signUpApiRoute,
          serviceLabel: "Send SignUp OTP",
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
      printDebug(textString: "Error During Send SignUp OTP Service : $e");
      return false;
    }
  }

  UserModel? currentUserData;

  //Verify User Mobile Number
  int? isActive;
  int? isSubscribe;
  Future<bool> verifyOtpApiService({
    required dynamic dataParameter,
    required BuildContext context,
  }) async {
    try {
      var response = await ApiManager.requestApi(
          context: context,
          endPoint: APIRoutes.verifyOtpApiRoute,
          serviceLabel: "Verify OTP",
          dataParameter: dataParameter,
          apiMethod: APIMethod.POST);

      if (response != null) {
        if (response["status"].toString() == "200") {
          //Current User Data

          currentUserData = UserModel.fromJson(response["data"]);
          isActive = response["data"]["isActive"];
          isSubscribe = response["data"]["isSubscribe"];

          Shared_Preferences.prefSetString(
              SharedP.keyAuthInformation, jsonEncode(response["data"]));

          //Set Authentication Token
          ApiManager.setAuthenticationToken(
              token: currentUserData?.token ?? "");

          notifyListeners();

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
      printDebug(textString: "Error During Verify OTP Service : $e");
      return false;
    }
  }

  //Get Single User data-----------
  Future<bool> getSingleUserDataService({
    required BuildContext context,
  }) async {
    try {
      var response = await ApiManager.requestApi(
          context: context,
          endPoint: APIRoutes.getSingleProfileApiRoute,
          serviceLabel: "Verify OTP",
          apiMethod: APIMethod.GET);

      if (response != null) {
        if (response["status"].toString() == "200") {
          //Current User Data

          currentUserData = UserModel.fromJson(response["data"]);
          isActive = response["data"]["isActive"];
          isSubscribe = response["data"]["isActive"];

          Shared_Preferences.prefSetString(
              SharedP.keyAuthInformation, jsonEncode(response["data"]));

          //Set Authentication Token
          // ApiManager.setAuthenticationToken(
          //     token: currentUserData?.token ?? "");

          notifyListeners();

          // showToast(
          //     message: response["message"], isPositive: true, context: context);
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
      printDebug(textString: "Error During Verify OTP Service : $e");
      return false;
    }
  }

  Future<bool> profileUpdateApiService({
    required dynamic dataParameter,
    required BuildContext context,
  }) async {
    try {
      var response = await ApiManager.requestApi(
          context: context,
          endPoint: APIRoutes.profileUpdateApiRoute,
          serviceLabel: "Profile Update",
          dataParameter: dataParameter,
          apiMethod: APIMethod.PUT);

      if (response != null) {
        if (response["status"].toString() == "200") {
          //Current User Data

          currentUserData = UserModel.fromJson(response["data"]);
          isActive = response["data"]["isActive"];

          Shared_Preferences.prefSetString(
              SharedP.keyAuthInformation, jsonEncode(response["data"]));

          // //Set Authentication Token
          // ApiManager.setAuthenticationToken(
          //     token: currentUserData?.token ?? "");

          notifyListeners();

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
      printDebug(textString: "Error During Profile Update Service : $e");
      return false;
    }
  }

  // Soft & Hard delete account

  Future<bool> softAndHardDeleteApiService({
    required bool isHardDelete,
    required String reason,
    required String description,
    required BuildContext context,
  }) async {
    try {
      var response = await ApiManager.requestApi(
          context: context,
          endPoint: isHardDelete
              ? APIRoutes.hardDeleteApiRoute
              : APIRoutes.softDeleteApiRoute,
          serviceLabel: "Soft & Hard Account Delete",
          dataParameter: {
            "reason": reason,
            if (description != "") "description": description,
          },
          apiMethod: APIMethod.DELETE);

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
          textString: "Error During Soft & Hard Account Delete Service : $e");
      return false;
    }
  }
}
