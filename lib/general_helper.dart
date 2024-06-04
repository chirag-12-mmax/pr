// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shah_investment/constants/api_info/api_routes.dart';
import 'package:shah_investment/constants/api_info/common_api_structure.dart';
import 'package:shah_investment/constants/global_list.dart';
import 'package:shah_investment/logical_functions/debug_print.dart';

class GeneralHelper with ChangeNotifier {
  //Language Settings
  dynamic currentLanguageData = {};
  dynamic translateTextTitle({required String titleText}) {
    return currentLanguageData[titleText] ?? titleText;
  }

  // Upload image service
  Future<dynamic> imageUploadService({
    required String fieName,
    required Uint8List fileByteData,
    required BuildContext context,
  }) async {
    try {
      var response = await ApiManager.requestApi(
          context: context,
          endPoint: APIRoutes.imageUploadApiRoute,
          serviceLabel: "Upload image",
          dataParameter: FormData.fromMap({
            "image": GlobalList.contentTypes[fieName.split('.').last] != null
                ? MultipartFile.fromBytes(
                    fileByteData,
                    filename: fieName,
                    contentType: MediaType.parse(
                        GlobalList.contentTypes[fieName.split('.').last]!),
                  )
                : MultipartFile.fromBytes(fileByteData, filename: fieName),
          }),
          apiMethod: APIMethod.POST);

      if (response != null) {
        if (response["status"].toString() == "200") {
          return response["data"]['image'];
        } else {
          printDebug(
            textString: response["message"],
          );
        }
      } else {
        printDebug(textString: "image not Selected");
      }
    } catch (e) {
      printDebug(textString: "Error During Upload image Service : $e");
    }
  }
}
