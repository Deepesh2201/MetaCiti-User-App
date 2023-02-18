import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:tagyourtaxi_driver/pages/login/login.dart';

Future<bool?> showAuthenticationAlertDialog() async {
  return await OneContext().showDialog<bool>(
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog( // <-- SEE HERE
          title: const Text('Whoops, Your session has expired'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Sorry, your request could not be processed. Please login again.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              OneContext().popDialog(true);
              //OneContext.instance.push(MaterialPageRoute(builder:(context) => const Login()));
            },
          ),
        ],
      );
    },
  );
}