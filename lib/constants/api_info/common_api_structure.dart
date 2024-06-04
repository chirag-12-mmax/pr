// ignore: constant_identifier_names

// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shah_investment/auth_module/auth_models/user_model.dart';
import 'package:shah_investment/auth_module/auth_views/phone_number_sign_in.dart';
import 'package:shah_investment/constants/api_info/api_routes.dart';
import 'package:shah_investment/constants/navigation_screen.dart';
import 'package:shah_investment/constants/share_pref_keys.dart';
import 'package:shah_investment/constants/share_preference.dart';
import 'package:shah_investment/general_helper.dart';
import 'package:shah_investment/logical_functions/debug_print.dart';
import 'package:shah_investment/trades_module/trade_provider.dart';
import 'package:shah_investment/widgets/dialogs/common_confirmation_dialog_box.dart';
import 'package:shah_investment/widgets/loaders/show_overlay_loader.dart';

// ignore: constant_identifier_names
enum APIMethod { POST, GET, PUT, FETCH, DELETE }

//Set Default Headers
Map<String, dynamic> headers = {
  'Content-type': 'application/json; charset=utf-8',
  'Accept': 'application/json',
};

BuildContext? tempContext;
UserModel? currentUserData;

class ApiManager {
  //Set Dio Object
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: APIRoutes.BASEURL,
      headers: headers,
      contentType: "application/json; charset=utf-8",
      receiveDataWhenStatusError: false,
      validateStatus: (_) => true,
    ),
  )..interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (RequestOptions requestOptions,
            RequestInterceptorHandler requestHandler) async {
          printDebug(
              textString:
                  "===============ONRequest Headers.....${requestOptions.headers}");

          return requestHandler.next(requestOptions);
        },
        onError: (DioException e, ErrorInterceptorHandler handler) async {
          printDebug(textString: "===============ONERROR Headers.....${e}");
          return handler.next(e);
        },
        onResponse: (e, handler) async {
          if (e.statusCode!.toString() == "401") {
            //Set Authentication Token
            ApiManager.setAuthenticationToken(
                token: currentUserData?.refreshToken ?? "");

            var refreshResponse = await ApiManager.requestApi(
                context: null,
                endPoint: APIRoutes.refreshTokenApiRoute,
                serviceLabel: "Refresh Token",
                dataParameter: {},
                apiMethod: APIMethod.POST);

            if (refreshResponse != null) {
              currentUserData = UserModel.fromJson(refreshResponse["data"]);

              Shared_Preferences.prefSetString(SharedP.keyAuthInformation,
                  jsonEncode(refreshResponse["data"]));

              ApiManager.setAuthenticationToken(
                  token: currentUserData?.token ?? "");
            }
            return handler.resolve(await _retry(e.requestOptions));
          } else {
            return handler.next(e);
          }
        },
      )
    ]);

  // Re-Call Api After Resolve Issue
  static Future<Response> _retry(RequestOptions requestOptions) async {
    dynamic requestOption = requestOptions.data;
    print("==============Path........${requestOptions.path}");

    if (requestOptions.path.contains("LogOutFromOnBoarding")) {
      return _dio.post(
        requestOptions.path,
        data: requestOption,
        queryParameters: requestOptions.queryParameters,
      );
    } else {
      return _dio.request(
        requestOptions.path,
        data: requestOption,
        queryParameters: requestOptions.queryParameters,
      );
    }
  }

  //Set Token in Header
  static setAuthenticationToken({required String token}) async {
    headers["Authorization"] = "Bearer $token";

    _dio.options = BaseOptions(headers: headers);
  }

  static Future<dynamic> requestApi({
    dynamic dataParameter,
    required String endPoint,
    required String serviceLabel,
    bool isQueryParameter = false,
    required APIMethod apiMethod,
    required BuildContext? context,
  }) async {
    //Response
    Response? response;

    try {
      if (context != null) {
        tempContext = context;
      }

      //Get Response From Information
      response = await _getDioResponse(
          apiMethod: apiMethod,
          data: dataParameter,
          url: endPoint.contains("https://")
              ? endPoint
              : (APIRoutes.BASEURL + endPoint),
          isQueryParameter: isQueryParameter);

      //Check Response If Is in Debug mode

      printDebug(
          textString:
              "\n\n*****************************$serviceLabel*****************************");
      printDebug(textString: "Request url: ${response.realUri}");
      printDebug(textString: "Request headers: ${_dio.options.headers}");
      printDebug(textString: "Request parameters: $dataParameter");
      printDebug(textString: "Request Auth: ${_dio.options.headers}");
      printDebug(textString: "Request status Code: ${response.statusCode}");
      printDebug(textString: "Request data: ${response.data}");
      printDebug(
          textString:
              "\n=============================***====================================\n");

      final helper = tempContext != null
          ? Provider.of<GeneralHelper>(tempContext!, listen: false)
          : null;

      //Check Response Status Code

      switch (response.statusCode.toString()) {
        case "200":
          return response.data;
        case "207":
          return tempContext != null
              ? await showDialog(
                  barrierDismissible: false,
                  context: tempContext!,
                  builder: (context) {
                    return CommonConfirmationDialogBox(
                      buttonTitle:
                          helper!.translateTextTitle(titleText: "Okay"),
                      title: helper.translateTextTitle(titleText: "Alert"),
                      subTitle: helper.translateTextTitle(
                          titleText:
                              "Your account is already login in other device !"),
                      onPressButton: () async {
                        await Shared_Preferences.clearAllPref();
                        final tradeProvider =
                            Provider.of<TradeProvider>(context, listen: false);

                        tradeProvider.changeBottomBarIndex(selectedIndex: 1);

                        changeScreenWithClearStack(
                            context: context,
                            widget: const PhoneNumberSignInScreen());
                      },
                    );
                  },
                )
              : null;

        default:
          if (tempContext != null) {
            hideOverlayLoader();
            await showDialog(
              barrierDismissible: false,
              context: tempContext!,
              builder: (context) {
                return CommonConfirmationDialogBox(
                  buttonTitle: helper!.translateTextTitle(titleText: "Okay"),
                  title: helper.translateTextTitle(titleText: "Alert"),
                  subTitle: helper.translateTextTitle(
                      titleText:
                          "I'am sorry, we are unable to process your request. Please try again "),
                  onPressButton: () {
                    backToScreen(context: context);
                  },
                );
              },
            );
          }

          return null;
      }
    } on DioException catch (e) {
      printDebug(textString: "DIO Exception: $e");
      printDebug(
          textString:
              "\n\n*****************************DIO*****************************");
      printDebug(textString: "Request url: ${APIRoutes.BASEURL + endPoint}");
      printDebug(textString: "Request headers: ${_dio.options.headers}");
      printDebug(textString: "Request parameters: $dataParameter");
      printDebug(textString: "Request Auth: ${_dio.options.headers}");
      printDebug(textString: "Request status Code: ${e.response?.statusCode}");
      printDebug(textString: "Request data: ${e.response}");
      printDebug(
          textString:
              "\n=============================***====================================\n");
      final helper = tempContext != null
          ? Provider.of<GeneralHelper>(tempContext!, listen: false)
          : null;
      if (tempContext != null) {
        hideOverlayLoader();
        await showDialog(
          barrierDismissible: false,
          context: tempContext!,
          builder: (context) {
            return CommonConfirmationDialogBox(
              buttonTitle: helper!.translateTextTitle(titleText: "Okay"),
              title: helper.translateTextTitle(titleText: "Alert"),
              subTitle: helper.translateTextTitle(
                  titleText:
                      "I'm sorry, we are unable to process your request. Please try again"),
              onPressButton: () {
                backToScreen(context: context);
              },
            );
          },
        );
      }
    } catch (e) {
      final helper = tempContext != null
          ? Provider.of<GeneralHelper>(tempContext!, listen: false)
          : null;
      printDebug(textString: "Other Exception: $e");
      if (tempContext != null) {
        hideOverlayLoader();
        await showDialog(
          barrierDismissible: false,
          context: tempContext!,
          builder: (context) {
            return CommonConfirmationDialogBox(
              buttonTitle: helper!.translateTextTitle(titleText: "Okay"),
              title: helper.translateTextTitle(titleText: "Alert"),
              subTitle: helper.translateTextTitle(
                  titleText:
                      "I'm sorry, we are unable to process your request. Please try again"),
              onPressButton: () {
                backToScreen(context: context);
              },
            );
          },
        );
      }
    }
  }

  //Get Response From Dio

  static Future<Response> _getDioResponse(
      {required String url,
      required dynamic data,
      bool isQueryParameter = false,
      required APIMethod apiMethod}) async {
    if (!isQueryParameter) {
      switch (apiMethod) {
        case APIMethod.POST:
          return await _dio.postUri(
            Uri.parse(url),
            data: data,
          );

        case APIMethod.PUT:
          return await _dio.putUri(
            Uri.parse(url),
            data: data,
          );
        case APIMethod.FETCH:
          return await _dio.patchUri(
            Uri.parse(url),
            data: data,
          );

        case APIMethod.DELETE:
          return await _dio.deleteUri(
            Uri.parse(url),
            data: data,
          );

        default:
          return await _dio.getUri(
            Uri.parse(url),
          );
      }
    } else {
      if (apiMethod == APIMethod.POST) {
        return await _dio.post(url,
            queryParameters:
                data != null ? (data as Map<String, dynamic>) : null);
      } else {
        return await _dio.get(url,
            queryParameters:
                data != null ? (data as Map<String, dynamic>) : null);
      }
    }
  }
}
