import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    var duration = const Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() {
    //Navigator.pushReplacementNamed(context, '/home');
    Navigator.pushNamed(context, '/homepage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Center(
          child: Lottie.asset("assets/splash/splash_video.json"),
        )
      ],
    ));
  }
}
