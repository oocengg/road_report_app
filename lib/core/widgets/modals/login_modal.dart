import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/features/auth/views/auth_screen.dart';

// ignore: unused_element
void showLoginModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  top: 16,
                  left: 20,
                  right: 20,
                  bottom: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ups!',
                      style: TextStyle(
                        fontSize: AppFontSize.bodyMedium,
                        fontWeight: AppFontWeight.bodySemiBold,
                      ),
                    ),
                    Icon(FeatherIcons.info),
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.primary50,
                ),
                child: const Icon(
                  FeatherIcons.logIn,
                  color: AppColors.primary500,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Silahkan Masuk Terlebih Dahulu',
                  style: TextStyle(
                    fontSize: AppFontSize.heading4,
                    fontWeight: AppFontWeight.headingSemiBold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text(
                  'Untuk melanjutkan laporan, anda diwajibkan untuk masuk terlebih dahulu. Silahkan klik tombol masuk dibawah untuk melanjutkan proses laporan.',
                  style: TextStyle(
                    fontSize: AppFontSize.bodyMedium,
                    fontWeight: AppFontWeight.bodyRegular,
                    color: AppColors.neutral800,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    backgroundColor: const MaterialStatePropertyAll(
                      AppColors.primary500,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);

                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => const AuthScreen(),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Masuk',
                      style: TextStyle(
                        fontWeight: AppFontWeight.actionSemiBold,
                        fontSize: AppFontSize.actionLarge,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 26,
              ),
            ],
          ),
        ),
      );
    },
  );
}
