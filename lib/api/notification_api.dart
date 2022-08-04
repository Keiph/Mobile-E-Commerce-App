import 'package:boogle_mobile/screens/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationApi {
  static final FlutterLocalNotificationsPlugin  _notifications = FlutterLocalNotificationsPlugin();

  static Future _notificationsDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
          'channel id',
          'channel name',
          importance: Importance.max,
      icon: "@drawable/splash"),
      iOS: IOSNotificationDetails(),
    );
  }
  static Future init() async{
    final android = AndroidInitializationSettings('@drawable/splash');
    final iOS = IOSInitializationSettings();
    final settings = InitializationSettings(android: android,iOS:iOS);

    await _notifications.initialize(
        settings,
        onSelectNotification: (payload) async{},
    );
  }


    static Future showNotification({
    int id = 0,
    String? title,
    String? body,

  }) async =>
      _notifications.show(
        id,
        title,
        body,
        await _notificationsDetails(),
      );
}
