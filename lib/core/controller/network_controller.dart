import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      Get.dialog(
        AlertDialog(
          title: const Text('Tidak Ada Koneksi'),
          content: const Text(
              "Mohon periksa koneksi internet anda. Klik 'Buka Pengaturan' untuk membuka halaman pengaturan perangkat."),
          actions: [
            ElevatedButton(
              onPressed: () {
                AppSettings.openAppSettings(type: AppSettingsType.device);
              },
              style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(AppColors.primary500)),
              child: const Text(
                'Buka Pengaturan',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        barrierDismissible: false,
      );
    } else {
      if (Get.isDialogOpen!) {
        Get.back();
      }
    }
  }
}
