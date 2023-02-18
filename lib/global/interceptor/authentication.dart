import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:one_context/one_context.dart';
import 'package:tagyourtaxi_driver/global/dialogs/dialogs.dart';
import 'package:tagyourtaxi_driver/pages/login/login.dart';

class AuthenticationInterceptor extends InterceptorContract {
  @override
  Future<BaseRequest> interceptRequest({
    required BaseRequest request,
  }) async {
    log('----- Request -----');
    log(request.toString());
    log(request.headers.toString());
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {
    log('----- Response -----');
    log('Code: ${response.statusCode}');
    if(response.statusCode==HttpStatus.unauthorized){
      OneContext.instance.pushAndRemoveUntil(MaterialPageRoute(builder:(context) => const Login()),(route) => true,);
      final result=await showAuthenticationAlertDialog();
      return response;
    }
    log(response.toString());
    return response;
  }
}
