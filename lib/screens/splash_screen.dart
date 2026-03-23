import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> getFCMToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("✅ Permission granted");

      String? token = await messaging.getToken();
      print("🔥 FCM TOKEN : $token");
    } else {
      print("❌ Permission denied");
    }
  }

//  @override
  //void initState() {
    //super.initState();

    //getFCMToken(); // ✅ YAHAN CALL KARO
  //}
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 7), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
    getFCMToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie animation
            Lottie.asset('asset/freindchat.json', height: 320, repeat: true),

            const SizedBox(height: 20),

            // Gradient Animated Text
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF2196F3), Color(0xFF9C27B0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  TyperAnimatedText(
                    'Welcome To MitraTalk',
                    textStyle: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                  TyperAnimatedText(
                    'Let’s Connect & Chat',
                    textStyle: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    speed: const Duration(milliseconds: 120),
                  ),
                ],
                pause: const Duration(milliseconds: 1000),
              ),
            ),

            const SizedBox(height: 30),

            // Loading indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2196F3)),
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}
