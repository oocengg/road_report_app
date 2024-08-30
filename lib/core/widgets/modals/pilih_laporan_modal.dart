import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/core/widgets/modals/cara_foto_modal.dart';
import 'package:mobileapp_roadreport/features/add_laporan/provider/add_laporan_provider.dart';
import 'package:mobileapp_roadreport/features/add_laporan/view/add_laporan_screen.dart';
import 'package:mobileapp_roadreport/features/dashboard/provider/dashboard_provider.dart';
import 'package:mobileapp_roadreport/features/home/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: unused_element
void showPilihLaporanModal(BuildContext context) {
  final homeProvider = Provider.of<HomeProvider>(context, listen: false);
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    enableDrag: false,
    builder: (BuildContext context) {
      return Consumer<DashboardProvider>(
          builder: (context, dashboardProvider, _) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: dashboardProvider.isCropped
              ? Container(
                  height: 230,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 20,
                          right: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Pilih Laporan',
                              style: TextStyle(
                                fontSize: AppFontSize.bodyMedium,
                                fontWeight: AppFontWeight.bodySemiBold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                FeatherIcons.x,
                                size: 20,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            homeProvider.draft.length == 5
                                ? Container(
                                    padding: const EdgeInsets.all(12),
                                    width: MediaQuery.of(context).size.width *
                                        0.42,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: AppColors.primary100),
                                        color: AppColors.neutral100),
                                    child: const Column(
                                      children: [
                                        Icon(
                                          FeatherIcons.folder,
                                          size: 24,
                                          color: AppColors.neutral400,
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          'Draft Foto',
                                          style: TextStyle(
                                              fontSize: AppFontSize.bodyMedium,
                                              fontWeight:
                                                  AppFontWeight.bodySemiBold,
                                              color: AppColors.neutral400),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          'Simpan dan kirim laporan nanti',
                                          style: TextStyle(
                                              fontSize: AppFontSize.caption,
                                              fontWeight:
                                                  AppFontWeight.captionRegular,
                                              color: AppColors.neutral400),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  )
                                : InkWell(
                                    onTap: () async {
                                      // Tampilkan AlertDialog
                                      bool proceed =
                                          await showCaraFoto(context);

                                      if (proceed == true) {
// Aktifkan Crop Image
                                        dashboardProvider.cropImage();

                                        final pickedFileCamera =
                                            await ImagePicker().pickImage(
                                          source: ImageSource.camera,
                                        );

                                        if (pickedFileCamera != null) {
                                          final preferences =
                                              await SharedPreferences
                                                  .getInstance();

                                          if (context.mounted) {
                                            await dashboardProvider
                                                .getLocationData(
                                                    context: context);

                                            if (context.mounted) {
                                              List<String> draft = preferences
                                                  .getStringList("draft")!;
                                              List<String> lat = preferences
                                                  .getStringList("lat")!;
                                              List<String> lng = preferences
                                                  .getStringList("lng")!;
                                              List<String> timestamp =
                                                  preferences.getStringList(
                                                      "timestamp")!;

                                              if (context.mounted) {
                                                CroppedFile? croppedFile =
                                                    await ImageCropper()
                                                        .cropImage(
                                                  sourcePath:
                                                      pickedFileCamera.path,
                                                  aspectRatioPresets: [
                                                    CropAspectRatioPreset
                                                        .square,
                                                  ],
                                                  uiSettings: [
                                                    AndroidUiSettings(
                                                      toolbarTitle:
                                                          'Sesuaikan Gambar',
                                                      toolbarColor:
                                                          AppColors.primary500,
                                                      toolbarWidgetColor:
                                                          Colors.white,
                                                      initAspectRatio:
                                                          CropAspectRatioPreset
                                                              .square,
                                                      lockAspectRatio: true,
                                                      hideBottomControls: true,
                                                      cropFrameColor:
                                                          AppColors.error500,
                                                    ),
                                                    IOSUiSettings(
                                                      title: 'Sesuaikan Gambar',
                                                    ),
                                                  ],
                                                );
                                                if (croppedFile != null) {
                                                  if (context.mounted) {
                                                    File fileUpload =
                                                        File(croppedFile.path);

                                                    String testCheck =
                                                        await Provider.of<
                                                                    AddLaporanProvider>(
                                                                context,
                                                                listen: false)
                                                            .checkImageRoad(
                                                                context,
                                                                fileUpload);

                                                    print(
                                                        '------------------------ Hasil AI : $testCheck');

                                                    if (context.mounted) {
                                                      if (testCheck == 'road') {
                                                        await dashboardProvider
                                                            .addImage(
                                                          context,
                                                          fileUpload,
                                                          draft,
                                                          lat,
                                                          lng,
                                                          timestamp,
                                                        );

                                                        if (context.mounted) {
                                                          Navigator.pop(
                                                              context);

                                                          // Matikan Crop Image
                                                          dashboardProvider
                                                              .cropImage();
                                                        }
                                                      } else {
                                                        // Matikan Crop Image
                                                        dashboardProvider
                                                            .cropImage();

                                                        Navigator.pop(context);

                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          const SnackBar(
                                                            content: Row(
                                                              children: [
                                                                Icon(
                                                                  FeatherIcons
                                                                      .xCircle,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Flexible(
                                                                  child: Text(
                                                                    'Maaf, gambar yang anda masukkan bukan gambar jalan.',
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            backgroundColor:
                                                                AppColors
                                                                    .error500,
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                          ),
                                                        );
                                                      }
                                                    }
                                                  }
                                                } else {
                                                  if (context.mounted) {
                                                    // Matikan Crop Image
                                                    dashboardProvider
                                                        .cropImage();

                                                    Navigator.pop(context);
                                                  }
                                                }
                                              }
                                            }
                                          }
                                        } else {
                                          // Matikan Crop Image
                                          dashboardProvider.cropImage();
                                        }
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      width: MediaQuery.of(context).size.width *
                                          0.42,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: AppColors.primary100),
                                      ),
                                      child: const Column(
                                        children: [
                                          Icon(
                                            FeatherIcons.folder,
                                            size: 24,
                                            color: AppColors.primary500,
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            'Draft Foto',
                                            style: TextStyle(
                                              fontSize: AppFontSize.bodyMedium,
                                              fontWeight:
                                                  AppFontWeight.bodySemiBold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            'Simpan dan kirim laporan nanti',
                                            style: TextStyle(
                                              fontSize: AppFontSize.caption,
                                              fontWeight:
                                                  AppFontWeight.captionRegular,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                if (homeProvider.draft.isEmpty) {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) {
                                        return const AddLaporanScreen();
                                      },
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        const begin = Offset(0.0, 1.0);
                                        const end = Offset.zero;
                                        const curve = Curves.ease;

                                        final tween =
                                            Tween(begin: begin, end: end);
                                        final curvedAnimation = CurvedAnimation(
                                          parent: animation,
                                          curve: curve,
                                        );

                                        return SlideTransition(
                                          position:
                                              tween.animate(curvedAnimation),
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                } else {
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
                                              'Maaf, anda masih memiliki draft laporan.',
                                            ),
                                          ),
                                        ],
                                      ),
                                      backgroundColor: AppColors.error500,
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                width: MediaQuery.of(context).size.width * 0.42,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border:
                                      Border.all(color: AppColors.primary100),
                                ),
                                child: const Column(
                                  children: [
                                    Icon(
                                      FeatherIcons.camera,
                                      size: 24,
                                      color: AppColors.primary500,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'Laporan',
                                      style: TextStyle(
                                        fontSize: AppFontSize.bodyMedium,
                                        fontWeight: AppFontWeight.bodySemiBold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'Foto sekarang dan laporkan sekarang',
                                      style: TextStyle(
                                        fontSize: AppFontSize.caption,
                                        fontWeight:
                                            AppFontWeight.captionRegular,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                    ],
                  ),
                ),
        );
      });
    },
  );
}
