import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/navigations/tab_store.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();
  final TabStore _tabStore = getIt<TabStore>();
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> _createNotificationChannel(
      String id, String name, String description) async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var androidNotificationChannel = AndroidNotificationChannel(id, name,
        description: description, importance: Importance.max);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);
  }

  Future<void> init() async {
    var status = await Permission.notification.status;

    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
    if (status.isDenied) {
      await Permission.notification.request();
    }
    if (status.isGranted) {
      await _createNotificationChannel(
          "channelID", "channelNAME", "channelDESC");
    }

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('icon');

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) async {},
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
      selectNotification(response.payload);
    });
    tz.initializeTimeZones();
    // tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails("channelID", "channelNAME",
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            icon: "icon",
            playSound: true,
            enableVibration: true,
            sound: RawResourceAndroidNotificationSound('smile')),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    print("noti");
    return flutterLocalNotificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  void selectNotification(dynamic payload) {
    //Handle notification tapped logic here
    _tabStore.setTabIndex(3);
    print(payload);
  }
}
