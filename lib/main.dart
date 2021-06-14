import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logo_quiz/provider/LogoProvider.dart';
import 'package:logo_quiz/provider/Notification.dart';
import 'package:logo_quiz/screens/HomeScreen.dart';
import 'package:provider/provider.dart';

import 'screens/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance.resamplingEnabled = true;
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        } else {
          // Loading is done, return the app:
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => LogoProvider(),
              ),
              ChangeNotifierProvider(
                create: (context) => NotificationService(),
              ),
            ],
            child: MaterialApp(
              title: 'Logo Quiz',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                fontFamily: 'Now',
              ),
              debugShowCheckedModeBanner: false,
              home: HomeScreen(),
            ),
          );
        }
      },
    );
  }
}
