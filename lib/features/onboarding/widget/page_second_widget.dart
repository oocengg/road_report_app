import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/font_size.dart';
import '../../../core/constants/font_weigth.dart';

class SecondPageWidget extends StatelessWidget {
  const SecondPageWidget({super.key});

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
                "assets/images/onboard2.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 40.0,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "Pantau Proses Perbaikan Jalan",
            style: TextStyle(
              fontSize: AppFontSize.heading3,
              fontWeight: AppFontWeight.headingBold,
              color: AppColors.primary500,
              decoration: TextDecoration.none,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 41, vertical: 14),
          child: Text(
            "Dengan menu riwayat yang lengkap anda bisa melihat progres laporan anda.",
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
