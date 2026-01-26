import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fruits/messages/test_firebase_notifications_view.dart';
import '../main.dart';

// الهاندلر الخاص بالخلفية
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("🔥 Background message: ${message.notification?.title}");
}

class FirebaseNotifications {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    await firebaseMessaging.requestPermission();

    var token = await firebaseMessaging.getToken();
   // print("Firebase Messaging Token: $token");

    // 1. التطبيق مفتوح أو في الخلفية (انتقال فوري)
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleNotificationClick(message, waitDelay: false);
    });

    // إعداد الإشعارات المحلية
    _initializeLocalNotifications();

    // 2. التطبيق مغلق تماماً (يحتاج تأخير لتجاوز الـ Splash)
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationClick(initialMessage, waitDelay: true);
    }
  }

  void _initializeLocalNotifications() {
    const android = AndroidInitializationSettings('@mipmap/launcher_icon');
    const settings = InitializationSettings(android: android);

    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload != null) {
          final Map<String, dynamic> data = jsonDecode(response.payload!);
          // التطبيق مفتوح بالتأكيد، لذا ننتقل فوراً
          _handleNotificationClick(RemoteMessage(data: data), waitDelay: false);
        }
      },
    );
  }

  void _handleForegroundMessage(RemoteMessage message) {
    Map<String, dynamic> notificationData = {
      'title': message.notification?.title,
      'body': message.notification?.body,
      ...message.data,
    };

    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'Notifications',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/launcher_icon',
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      notificationDetails,
      payload: jsonEncode(notificationData),
    );
  }

  // أضفت باراميتر waitDelay للتحكم في التأخير
  void _handleNotificationClick(RemoteMessage? message,
      {bool waitDelay = false}) async {
    if (message == null) return;

    if (waitDelay) {
      // ننتظر فقط إذا كان التطبيق يفتح من الصفر (Terminated)
      await Future.delayed(const Duration(milliseconds: 2500));
    }

    if (navigatorKey.currentState != null) {
      navigatorKey.currentState!.pushNamed(
        TestFirebaseNotifications.routeName,
        arguments: message,
      );
    } else {
      print("Navigator state is null");
    }
  }
}