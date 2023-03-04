import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:log_print/log_print.dart';
import 'package:one_context/one_context.dart';
import 'package:tagyourtaxi_driver/global/dialogs/dialogs.dart';
import 'package:tagyourtaxi_driver/pages/login/login.dart';

class AuthenticationInterceptor extends InterceptorContract {
  @override
  Future<BaseRequest> interceptRequest({
    required BaseRequest request,
  }) async {
    LogPrint('----- Request -----', type: LogPrintType.info);
    LogPrint(request.toString(), type: LogPrintType.success);
    LogPrint(request.headers.toString(), type: LogPrintType.info);
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {
    LogPrint('----- Response -----', type: LogPrintType.info);
    LogPrint('Code: ${response.statusCode}', type: LogPrintType.info);
    if (response.statusCode == HttpStatus.unauthorized) {
      OneContext.instance.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Login()),
        (route) => true,
      );
      final result = await showAuthenticationAlertDialog();
      return response;
    }
    LogPrint(response.toString(), type: LogPrintType.success);
    return response;
  }
}
