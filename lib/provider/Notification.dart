import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService extends ChangeNotifier {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future initilize() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("ic_launcher");

    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Future dailyScheduleNotification(BuildContext context) async {
  //   await _flutterLocalNotificationsPlugin.zonedSchedule(
  //       0,
  //       'Logo Quiz',
  //       'There are numerous logo quizzes waiting for you to uncover.',
  //       tz.TZDateTime.now(tz.local).add(const Duration(seconds: 3)),
  //       const NotificationDetails(
  //           android: AndroidNotificationDetails('your channel id',
  //               'your channel name', 'your channel description')),
  //       androidAllowWhileIdle: true,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime);
  // }

  Future dailyIntervalNotification(BuildContext context) async {
    await _flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      'Logo Quiz',
      'There are numerous logo quizzes waiting for you to uncover.',
      RepeatInterval.daily,
      const NotificationDetails(
          android: AndroidNotificationDetails('your channel id',
              'your channel name', 'your channel description')),
      androidAllowWhileIdle: true,
    );
  }

  Future deleteAllNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
