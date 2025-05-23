// This is the function that will be called when a background message is received
import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:task_master/firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final localNotifications = FlutterLocalNotificationsPlugin();
  if (message.notification != null) {
    await localNotifications.show(
      message.messageId?.hashCode ?? DateTime.now().millisecondsSinceEpoch,
      message.notification!.title,
      message.notification!.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'task-assignments',
          'Task Assignments',
          channelDescription: 'This channel is used for task assignment notifications.',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(presentAlert: true, presentBadge: true, presentSound: true),
      ),
      payload: jsonEncode(message.data),
    );
  }
}

class NotificationsRepository {
  const NotificationsRepository({required this.firebaseMessaging, required this.localNotifications});

  @visibleForTesting
  final FirebaseMessaging firebaseMessaging;

  @visibleForTesting
  final FlutterLocalNotificationsPlugin localNotifications;

  Future<void> initialize() async {
    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initSettings = InitializationSettings(android: androidSettings, iOS: iosSettings);

    await localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        _handleNotificationTap(details);
      },
    );

    await _createNotificationChannel();

    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationTap(
        NotificationResponse(notificationResponseType: NotificationResponseType.selectedNotification, id: 0, payload: jsonEncode(message.data)),
      );
    });

    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationTap(
        NotificationResponse(
          notificationResponseType: NotificationResponseType.selectedNotification,
          id: 0,
          payload: jsonEncode(initialMessage.data),
        ),
      );
    }
  }

  Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'task-assignments',
      'Task Assignments',
      description: 'This channel is used for task assignment notifications.',
      importance: Importance.high,
    );

    await localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  }

  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    if (message.notification != null) {
      await localNotifications.show(
        message.messageId?.hashCode ?? DateTime.now().millisecondsSinceEpoch,
        message.notification!.title,
        message.notification!.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'task-assignments',
            'Task Assignments',
            channelDescription: 'This channel is used for task assignment notifications.',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: DarwinNotificationDetails(presentAlert: true, presentBadge: true, presentSound: true),
        ),
        payload: jsonEncode(message.data),
      );
    }
  }

  void _handleNotificationTap(NotificationResponse details) {
    if (details.payload != null) {
      final Map<String, dynamic> _ = jsonDecode(details.payload ?? '{}');
    }
  }

  Future<String?> getToken() async {
    if (Platform.isIOS) {
      final apnsToken = await FirebaseMessaging.instance.getAPNSToken();

      if (apnsToken == null) {
        return null;
      }
    }

    return await firebaseMessaging.getToken();
  }

  Future<void> subscribeToTopic(String topic) async {
    await firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await firebaseMessaging.unsubscribeFromTopic(topic);
  }
}
