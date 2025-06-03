import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:semester_project/routes/route_generator_constants.dart';
import '../const.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../widgets/colors/custom_colors.dart';
import '../widgets/utils/custom_utils.dart';

class CustomResponse {
  final int statusCode;
  final String body;

  CustomResponse({
    required this.statusCode,
    required this.body,
  });
}
class CustomServices {
  static Map<String, String> headersFromUrlencoded = {
    'Content-Type': 'Application/x-www-form-urlencoded',
  };

  static Future<CustomResponse> getRequest(String path, context) async {
    print('$apiURL$path');
    try {
      Map<String, String> header = {
        'Content-Type': 'Application/json',
        'Authorization': 'Bearer $accessToken',
        '_id': userId
      };
      final response = await http.get(
        Uri.parse('$apiURL$path'),
        headers: header,
      );
      if(response.statusCode == 403){
        ToastMessageUtils().showToastMessage(
            'Session Expired', ToastGravity.TOP, CustomColors.lightRed);
        Navigator.of(context).pop(UserConstants.logInPage);
      }
      return CustomResponse(
        statusCode: response.statusCode,
        body: response.body,
      );
    } catch (err) {
      return CustomResponse(statusCode: 69, body: err.toString());
    }
  }

  static Future<CustomResponse> postRequest(String path, final body, context) async {
    try {
      Map<String, String> header = {
        'Content-Type': 'Application/json',
        'Authorization': 'Bearer $accessToken',
        '_id': userId
      };
      final response = await http.post(
        Uri.parse('$apiURL$path'),
        headers: header,
        body: jsonEncode(body),
      );
      if(response.statusCode == 403){
        ToastMessageUtils().showToastMessage(
            'Session Expired', ToastGravity.TOP, CustomColors.lightRed);
        Navigator.of(context).pop(UserConstants.logInPage);
      }
      return CustomResponse(
        statusCode: response.statusCode,
        body: response.body,
      );
    } catch (err) {
      return CustomResponse(
        statusCode: 69,
        body: err.toString(),
      );
    }
  }

  static Future<CustomResponse> putRequest(String path, final body, context) async {
    try {
      Map<String, String> header = {
        'Content-Type': 'Application/json',
        'Authorization': 'Bearer $accessToken',
        '_id': userId
      };
      final response = await http.put(
        Uri.parse('$apiURL$path'),
        headers: header,
        body: jsonEncode(body),
      );
      if(response.statusCode == 403){
        ToastMessageUtils().showToastMessage(
            'Session Expired', ToastGravity.TOP, CustomColors.lightRed);
        Navigator.of(context).pop(UserConstants.logInPage);
      }
      return CustomResponse(
        statusCode: response.statusCode,
        body: response.body,
      );
    } catch (err) {
      return CustomResponse(
        statusCode: 69,
        body: err.toString(),
      );
    }
  }

  static Future<CustomResponse> ERPlogin(Map<String, dynamic> body) async {
    try {
      String url = '$apiURL/auth';
      // final encodedBody = body.entries
      //     .map((e) =>
      //         '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      //     .join('&');

      // print(encodedBody.runtimeType);
      Map<String, String> header = {
        'Content-Type': 'Application/json',
      };
      final response = await http.post(
        Uri.parse(url),
        headers: header,
        body: jsonEncode(body),
      );

      return CustomResponse(
        statusCode: response.statusCode,
        body: response.body,
      );
    } catch (err) {
      return CustomResponse(
        statusCode: 69,
        body: err.toString(),
      );
    }
  }
}