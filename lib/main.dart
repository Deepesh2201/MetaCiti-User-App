import 'package:flutter/material.dart';
import 'package:log_print/log_print.dart';
import 'package:log_print/log_print_config.dart';
import 'package:one_context/one_context.dart';
import 'package:tagyourtaxi_driver/functions/functions.dart';
import 'package:tagyourtaxi_driver/functions/notifications.dart';
import 'pages/loadingPage/loadingpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setLogPrintConfig(LogPrintConfig(colorful: true, debugMode: true));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  OneContext().key = GlobalKey<NavigatorState>();
  checkInternetConnection();

  initMessaging();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    platform = Theme.of(context).platform;
    return GestureDetector(
        onTap: () {
          //remove keyboard on touching anywhere on the screen.
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Meta Citi',
            theme: ThemeData(),
            navigatorKey: OneContext().key,
            builder: (context, child) {
              return OneContext().builder(context, child,
                  mediaQueryData:
                      MediaQuery.of(context).copyWith(textScaleFactor: 1.0));
            },
            home: const LoadingPage()));
  }
}
