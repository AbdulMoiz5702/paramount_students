import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import '../../models/user_models/user_OTP_data.dart';
import '../helper_fuctions/snack_bar.dart';
import 'app_exceptions.dart';
import 'package:http/http.dart' as http;


class TimeoutExceptionCustom extends AppException {
  TimeoutExceptionCustom() : super("That took too long. Try again in a moment.");
}


class NoInternetException extends AppException {
  NoInternetException() : super("You're offline. Check your connection and try again.");
}


class ServerException extends AppException {
  ServerException() : super("Server's having a bad day. Please try again soon.");
}


class UnknownException extends AppException {
  UnknownException(dynamic error) : super("Something went wrong. We'll look into it.");
}


class ApiException extends AppException {
  ApiException(String message) : super("Oops! $message");
}




class ExceptionHandler {

  static int ? statusCode;

  static void handle(dynamic error, BuildContext context, {String tag = "General"}) {
    String errorMessage = getMessage(error);
    debugPrint("⚠️ Exception in [$tag]: $errorMessage");
    debugPrint("StackTrace: ${error is Error ? error.stackTrace : 'No stack trace'}");
    if (context.mounted) {
      SnackBarClass.errorSnackBar(context: context, message: errorMessage);
    }
  }

  static String getMessage(dynamic error) {
    if (error is TimeoutException) {
      return TimeoutExceptionCustom().message;
    } else if (error is SocketException || error.toString().contains('SocketException')) {
      return NoInternetException().message;
    } else if (error is HttpException) {
      return ServerException().message;
    } else if (error is AppException) {
      return error.message;
    } else if (error is Exception || error is String) {
      final message = error.toString();
      final jsonStartIndex = message.indexOf('{');
      if (jsonStartIndex != -1) {
        final jsonString = message.substring(jsonStartIndex).trim();
        try {
          final decoded = jsonDecode(jsonString);
          if (decoded is Map<String, dynamic>) {
            if (decoded.containsKey('statusCode') && decoded['statusCode'] is int) {
              final code = decoded['statusCode'];
              statusCode = getStatusCode(code);
              debugPrint("Status Code: $statusCode");
            }
          }
          if (decoded is Map<String, dynamic>) {
            if (decoded.containsKey('message') && decoded['message'] is String) {
              return ApiException(decoded['message']).message;
            } else if (decoded.containsKey('responseBody') && decoded['responseBody'] is String) {
              return ApiException(decoded['responseBody']).message;
            } else if (decoded['responseBody'] is Map<String, dynamic>) {
              final innerBody = decoded['responseBody'];
              if (innerBody.containsKey('message')) {
                return ApiException(innerBody['message']).message;
              }
            }
          }
        } catch (e) {
          return UnknownException(error).message;
        }
      }
      return ApiException(message).message;
    }
    return UnknownException(error).message;
  }

  static int? getStatusCode(int statusCode) {
    return statusCode;
  }

  static UserOTPData? getUserOTPData(dynamic error) {
    try {
      final message = error.toString();
      final jsonStartIndex = message.indexOf('{');
      if (jsonStartIndex != -1) {
        final jsonString = message.substring(jsonStartIndex).trim();
        final decoded = jsonDecode(jsonString);
        if (decoded is Map<String, dynamic>) {
          final responseBody = decoded['responseBody'];
          if (responseBody is Map<String, dynamic> && responseBody['userData'] != null) {
            final otpData = UserOTPData.fromJson(responseBody['userData']);
            debugPrint('OTP ID: ${otpData.id}, OTP: ${otpData.otp}');
            return otpData;
          }
        }
      }
    } catch (e) {
      debugPrint('Failed to extract OTP data: $e');
    }
    return null;
  }

  static void handleApiResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      throw ApiException("Server responded with status code ${response.statusCode} and response body ${response.body.toString()}");
    } else {
      throw ApiException("Server responded with status code ${response.statusCode} and response body ${response.body.toString()}");
    }
  }
}





