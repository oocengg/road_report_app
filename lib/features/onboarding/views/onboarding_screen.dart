import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/features/dashboard/view/dashboard_screen.dart';
import 'package:mobileapp_roadreport/features/onboarding/widget/page_first_widget.dart';
import 'package:mobileapp_roadreport/features/onboarding/widget/page_second_widget.dart';
import 'package:mobileapp_roadreport/features/onboarding/widget/page_third_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  PageController controller = PageController();
  late Timer _timer;

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    _timer.cancel();
  }

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: currentIndex);
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (currentIndex < 2) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }

      controller.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    });
  }

  List<Widget> pages = [
    const FirstPageWidget(),
    const SecondPageWidget(),
    const ThirdPageWidget()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: PageView(
            controller: controller,
            onPageChanged: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            children: pages,
          ),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentIndex = 0;
                    });
                    controller.animateToPage(
                      currentIndex,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                    );
                  },
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: 0 == currentIndex
                          ? AppColors.primary500
                          : AppColors.primary200,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 6.0,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentIndex = 1;
                    });
                    controller.animateToPage(
                      currentIndex,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                    );
                  },
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: 1 == currentIndex
                          ? AppColors.primary500
                          : AppColors.primary200,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 6.0,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentIndex = 2;
                    });
                    controller.animateToPage(
                      currentIndex,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                    );
                  },
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: 2 == currentIndex
                          ? AppColors.primary500
                          : AppColors.primary200,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 51,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () =>
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const DashboardScreen(),
                )),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primary500,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: const Text(
                    "Mulai",
                    style: TextStyle(
                      fontSize: AppFontSize.actionLarge,
                      fontWeight: AppFontWeight.actionSemiBold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ],
    ));
  }
}
