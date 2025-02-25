import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:royalmart/presentation/screens/homescreen/home_screen.dart';
import 'package:royalmart/utilities/constants/constants.dart'; // Import the Lottie package

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
  
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return HomeScreen();
      }));
    });

    return Scaffold(backgroundColor: black,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SafeArea(
          child: Center(
            child: Lottie.asset('assets/animations/splash_screen.json'),
          ),
        ),
      ),
    );
  }
}
