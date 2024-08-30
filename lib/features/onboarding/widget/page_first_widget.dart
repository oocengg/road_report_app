import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/font_size.dart';
import '../../../core/constants/font_weigth.dart';

class FirstPageWidget extends StatelessWidget {
  const FirstPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius:
                BorderRadius.vertical(bottom: Radius.elliptical(500, 200)),
            image: DecorationImage(
              image: AssetImage(
                "assets/images/onboard1.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 40.0,
        ),
        const Text(
          "Laporkan Jalan Rusak",
          style: TextStyle(
            fontSize: AppFontSize.heading3,
            fontWeight: AppFontWeight.headingBold,
            color: AppColors.primary500,
            decoration: TextDecoration.none,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 41, vertical: 14),
          child: Text(
            "Nikmati fitur laporan dengan terperinci dan transparan dengan satu aplikasi",
            style: TextStyle(
              fontSize: AppFontSize.bodyMedium,
              fontWeight: AppFontWeight.bodyRegular,
              color: AppColors.neutral700,
              decoration: TextDecoration.none,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
