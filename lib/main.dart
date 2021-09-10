import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:client_manager/screen/campManagement/addDeviceScreen.dart';
import 'package:client_manager/screen/homePage/homePageScreen.dart';
import 'package:client_manager/screen/signPage/loginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:client_manager/function/mainFunction.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'getX/fcm/notification_controller.dart';

var fcm_Token;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  AwesomeNotifications().createNotificationFromJsonData(message.data);

  if (message.notification.android.imageUrl != null) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: 1,
      channelKey: 'high_importance_channel',
      title: message.notification?.title,
      body: message.notification?.body,
      bigPicture: message.notification.android.imageUrl,
      notificationLayout: NotificationLayout.BigPicture,
      displayOnBackground: true,
      displayOnForeground: true,
      largeIcon: message.notification.android.imageUrl,
    ));
  } else {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: 1,
      channelKey: 'high_importance_channel',
      title: message.notification?.title,
      body: message.notification?.body,
      displayOnBackground: true,
      displayOnForeground: true,
    ));
  }
}

void main() async {
  final token = new FlutterSecureStorage();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
          channelKey: 'high_importance_channel',
          channelName: 'High Importance notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white,
          playSound: true,
          enableLights: true,
          enableVibration: true,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
        ),
      ]);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      // Insert here your friendly dialog box before call the request method
      // This is very important to not harm the user experience
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  AwesomeNotifications().actionStream.listen((receivedNotification) {});

  FirebaseMessaging.instance.getToken().then((token) {
    fcm_Token = token;
  });
  await token.write(key: 'fcm_token', value: fcm_Token);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.put(Notification_Controller());
      }),
      title: '모닥모닥',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
