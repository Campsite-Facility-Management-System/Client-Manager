import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class Notification_Controller extends GetxController {
  static Notification_Controller get to => Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message.notification.android.imageUrl);

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
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');

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
        ),
      );
    });
  }

  notify() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'high_importance_channel',
        title: 'This is Notification title',
        body: 'This is Body of Noti',
        bigPicture:
            'https://img.theculturetrip.com/1440x807/smart/wp-content/uploads/2017/07/20588669402_b5b76bd345_k.jpg',
        notificationLayout: NotificationLayout.BigPicture,
        displayOnBackground: true,
        displayOnForeground: true,
        largeIcon:
            'https://img.theculturetrip.com/1440x807/smart/wp-content/uploads/2017/07/20588669402_b5b76bd345_k.jpg',
      ),
    );
  }
}
