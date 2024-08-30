import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/features/onboarding/views/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../dashboard/view/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false;
  bool isFirstTime = false;

  @override
  void initState() {
    super.initState();
    startSplashScreen();
    _buildPage();
  }

  startSplashScreen() async {
    const duration = Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => !isLoggedIn && isFirstTime
              ? const OnboardingScreen()
              : const DashboardScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary500,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/images/road_report_logo.png',
              width: MediaQuery.of(context).size.width * 0.8,
            ),
          ),
          Positioned(
            bottom: 35,
            right: 0,
            left: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'POWERED BY',
                  style: TextStyle(
                    fontSize: AppFontSize.caption,
                    fontWeight: AppFontWeight.captionRegular,
                    letterSpacing: 1.5,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/pis_logo.png",
                      width: 37,
                      height: 37,
                    ),
                    Image.asset(
                      "assets/images/polinema.png",
                      width: 48,
                      height: 48,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Penting untuk medefinisikan autentikasi user pertama kalo login aplikasi, login, dan logout
  _buildPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getKeys().isNotEmpty) {
      if (prefs.getBool('isFirstTime')!) {
        setState(() {
          isLoggedIn = false;
          isFirstTime = true;
        });
      } else {
        if (prefs.getBool('isLoggedIn')!) {
          if (!JwtDecoder.isExpired(prefs.getString('jwtToken')!)) {
            setState(() {
              isLoggedIn = true;
            });
          } else {
            setState(() {
              prefs.remove("token");
              prefs.remove("jwtToken");
              prefs.remove("uid");
              prefs.remove("id");
              prefs.remove("gid");
              prefs.setBool("isLoggedIn", false);
              isLoggedIn = false;
            });
          }
        } else {
          setState(() {
            isLoggedIn = false;
          });
        }
      }
    } else {
      setState(() {
        isLoggedIn = false;
        isFirstTime = true;
      });
    }
  }
}
