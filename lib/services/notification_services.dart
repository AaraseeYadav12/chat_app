import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {

  static Future<void> setupFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Permission
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("✅ Permission Granted");

      String? token = await messaging.getToken();
      print("🔥 FCM TOKEN: $token");

    } else {
      print("❌ Permission Denied");
    }

    // Token refresh
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      print("🔄 NEW TOKEN: $newToken");
    });
  }
}