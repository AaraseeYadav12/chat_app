import 'package:bolo_chat/chat/chat_screen.dart';
import 'package:bolo_chat/navigation screen/call_history_screen.dart';
import 'package:bolo_chat/navigation screen/profile_screen.dart';
import 'package:bolo_chat/navigation screen/status_screen.dart';
import 'package:bolo_chat/navigation_bar/navigation_bar.dart';
import 'package:bolo_chat/screens/forget_password_screen.dart';
import 'package:bolo_chat/screens/login_email_screen.dart';
import 'package:bolo_chat/screens/signup_screen.dart';
import 'package:bolo_chat/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<void> getFCMToken() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Permission for notification
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print("Notification permission granted");

    String? token = await messaging.getToken();

    print("FCM TOKEN : $token");
  } else {
    print("Notification permission denied");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await getFCMToken();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/forgotpassword': (context) => ForgotPasswordScreen(),
        //'/chatscreen': (context) => ChatScreen(), // FIXED ✅
        '/home': (context) => HomeScreen(),
        '/call': (context) => CallHistoryScreen(),
        '/status': (context) => StatusScreen(),
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}
