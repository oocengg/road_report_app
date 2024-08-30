import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/state/finite_state.dart';
import 'package:mobileapp_roadreport/features/history/view/history_screen.dart';
import 'package:mobileapp_roadreport/features/home/provider/home_provider.dart';
import 'package:mobileapp_roadreport/features/home/view/home_screen.dart';
import 'package:mobileapp_roadreport/features/laporan/view/laporan_screen.dart';
import 'package:mobileapp_roadreport/features/profile/view/profile_screen.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/services/location_service.dart';

class DashboardProvider with ChangeNotifier {
  // Dashboard  ini gunanya untuk menampung bottom navbar
  // Jadi ga ada screen yang berarti
  // Dashboard ini akan menampung pages yang di klik dari botton navbar

  // Ini index stiap halaman
  int selectedIndex = 0;

  // State untuk loading
  MyState state = MyState.initial;
  MyState draftState = MyState.initial;

  // Long lat
  double? latitude;
  double? longitude;

  // Service Location
  final serviceLocation = LocationService();

  bool locationOn = false;

  // Icon
  final List icon = [
    FeatherIcons.home,
    FeatherIcons.map,
    FeatherIcons
        .fileText, // ini hanya tambahan karena 5 dan akan tertutup oleh FAB
    FeatherIcons.calendar,
    FeatherIcons.user,
  ];

  // Title buat Icon Diatas
  final List<String> title = [
    'Beranda',
    'Laporan',
    '', // ini hanya tambahan karena 5 dan akan tertutup oleh FAB
    'Riwayat',
    'Profil',
  ];

  // Pages untuk icon icon diatas
  final List<Widget> pages = [
    const HomeScreen(),
    const LaporanScreen(),
    const HomeScreen(), // ini hanya tambahan karena 5 dan akan tertutup oleh FAB
    const HistoryScreen(),
    const ProfileScreen(),
  ];

  bool isCropped = false;

  // Set Pages yang dipilih
  void setSelectedIndex(BuildContext context, int index) {
    selectedIndex = index;

    notifyListeners();
  }

  //  Setter crop image
  void cropImage() {
    isCropped = !isCropped;
    notifyListeners();
  }

  // Add Image untuk draft
  Future<void> addImage(
    BuildContext context,
    File imageFile,
    List<String> draft,
    List<String> lat,
    List<String> lng,
    List<String> timestamp,
  ) async {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    try {
      final preferences = await SharedPreferences.getInstance();
      final File finishedFile = await compressImage(imageFile);

      final appDir = await getTemporaryDirectory();
      DateTime now = DateTime.now();
      final fileName = now.millisecondsSinceEpoch;

      await File(finishedFile.path).copy('${appDir.path}/$fileName');

      if (context.mounted) {
        draft.add('${appDir.path}/$fileName');
        lat.add(latitude.toString());
        lng.add(longitude.toString());
        timestamp.add(DateTime.now().toString());
        await preferences.setStringList("draft", draft);
        await preferences.setStringList("lat", lat);
        await preferences.setStringList("lng", lng);
        await preferences.setStringList("timestamp", timestamp);

        homeProvider.setDraft();

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Row(
                children: [
                  Icon(
                    FeatherIcons.checkCircle,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Text(
                      'Sukses, draft foto berhasil ditambahkan.',
                    ),
                  ),
                ],
              ),
              backgroundColor: AppColors.success500,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(
                FeatherIcons.xCircle,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  'Maaf, terjadi kesalahan saat menambahkan gambar.',
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.error500,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    notifyListeners();
  }

  // Function compress image
  Future<File> compressImage(File croppedFile) async {
    var fileFromImage = File(croppedFile.path);
    var basename = path.basenameWithoutExtension(fileFromImage.path);
    var pathString =
        fileFromImage.path.split(path.basename(fileFromImage.path))[0];

    var pathStringWithExtension = "$pathString${basename}_image.jpg";

    int maxFileSizeInBytes = 1000000; // 2 MB
    int currentFileSize = await croppedFile.length();
    int quality = 90;

    File compressedFiles;

    compressedFiles = croppedFile;

    while (currentFileSize > maxFileSizeInBytes) {
      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        croppedFile.absolute.path,
        pathStringWithExtension,
        quality: quality,
      );

      currentFileSize = await compressedFile!.length();
      quality -= 10; // Decrease quality by 10 each iteration (adjust as needed)

      compressedFiles = File(compressedFile.path);
    }

    return compressedFiles;
  }

  // Get lokasi device
  Future<void> getLocationData({required BuildContext context}) async {
    locationOn = false;

    if (state == MyState.loaded || state == MyState.failed) {
      state = MyState.loading;
      notifyListeners();
    }
    final location = await serviceLocation.getUserLocation().then((value) {
      if (value == null) {
        state = MyState.failed;
        notifyListeners();
      } else {
        return value;
      }
    });

    if (location != null) {
      latitude = location.latitude;
      longitude = location.longitude;

      try {
        locationOn = true;

        state = MyState.loaded;
        notifyListeners();
      } catch (e) {
        state = MyState.failed;
        notifyListeners();
      }
    } else {
      state = MyState.failed;
      notifyListeners();
      // print("eror mas bro");
    }
  }
}
