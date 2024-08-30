import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobileapp_roadreport/core/widgets/modals/cara_foto_modal.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/features/add_laporan/provider/add_laporan_provider.dart';

// ignore: unused_element
Future<void> showCameraModal(BuildContext context) async {
  showModalBottomSheet(
    isDismissible: false,
    enableDrag: false,
    context: context,
    builder: (BuildContext context) {
      return Consumer<AddLaporanProvider>(
          builder: (context, addLaporanProvider, _) {
        return addLaporanProvider.isCropped
            ? Container(
                height: 390,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary500,
                  ),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
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
                              'Tambahkan Foto',
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
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.primary50,
                        ),
                        child: const Icon(
                          FeatherIcons.info,
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Text(
                          'Silahkan tambahkan foto untuk memperjelas kondisi jalan terkini agar pihak admin mudah memverifikasi data, Anda bisa mengimport foto melalui galeri atau buka kamera langsung.',
                          style: TextStyle(
                            fontSize: AppFontSize.bodyMedium,
                            fontWeight: AppFontWeight.bodyRegular,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    elevation: null,
                                    shadowColor: null,
                                    shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    backgroundColor:
                                        const MaterialStatePropertyAll(
                                      AppColors.primary50,
                                    ),
                                  ),
                                  onPressed: () async {
                                    // Aktifkan Crop Image
                                    addLaporanProvider.cropImage();

                                    final pickedFileCamera =
                                        await ImagePicker().pickImage(
                                      source: ImageSource.gallery,
                                    );
                                    if (pickedFileCamera != null) {
                                      if (context.mounted) {
                                        CroppedFile? croppedFile =
                                            await ImageCropper().cropImage(
                                          sourcePath: pickedFileCamera.path,
                                          aspectRatioPresets: [
                                            CropAspectRatioPreset.square,
                                          ],
                                          uiSettings: [
                                            AndroidUiSettings(
                                              toolbarTitle: 'Sesuaikan Gambar',
                                              toolbarColor:
                                                  AppColors.primary500,
                                              toolbarWidgetColor: Colors.white,
                                              initAspectRatio:
                                                  CropAspectRatioPreset.square,
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
                                                await addLaporanProvider
                                                    .checkImageRoad(
                                                        context, fileUpload);

                                            print(
                                                '------------------------ Hasil AI : $testCheck');

                                            if (context.mounted) {
                                              if (testCheck == 'road') {
                                                await addLaporanProvider
                                                    .addImage(
                                                  context,
                                                  fileUpload,
                                                );

                                                if (context.mounted) {
                                                  Navigator.pop(context);

                                                  // Matikan Crop Image
                                                  addLaporanProvider
                                                      .cropImage();
                                                }
                                              } else {
                                                // Matikan Crop Image
                                                addLaporanProvider.cropImage();

                                                Navigator.pop(context);

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
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
                                                            'Maaf, gambar yang anda masukkan bukan gambar jalan.',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    backgroundColor:
                                                        AppColors.error500,
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                  ),
                                                );
                                              }
                                            }
                                          }
                                        } else {
                                          if (context.mounted) {
                                            // Matikan Crop Image
                                            addLaporanProvider.cropImage();

                                            Navigator.pop(context);
                                          }
                                        }
                                      }
                                    } else {
                                      // Matikan Crop Image
                                      addLaporanProvider.cropImage();
                                    }
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    child: Text(
                                      'Buka\nGaleri',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight:
                                            AppFontWeight.actionSemiBold,
                                        fontSize: AppFontSize.actionMedium,
                                        color: AppColors.primary500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Flexible(
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    backgroundColor:
                                        const MaterialStatePropertyAll(
                                      AppColors.primary500,
                                    ),
                                  ),
                                  onPressed: () async {
                                    // Tampilkan AlertDialog
                                    bool proceed = await showCaraFoto(context);

                                    if (proceed == true) {
                                      // Aktifkan Crop Image
                                      addLaporanProvider.cropImage();

                                      final pickedFileCamera =
                                          await ImagePicker().pickImage(
                                        source: ImageSource.camera,
                                      );
                                      if (pickedFileCamera != null) {
                                        if (context.mounted) {
                                          CroppedFile? croppedFile =
                                              await ImageCropper().cropImage(
                                            sourcePath: pickedFileCamera.path,
                                            aspectRatioPresets: [
                                              CropAspectRatioPreset.square,
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
                                                  await addLaporanProvider
                                                      .checkImageRoad(
                                                          context, fileUpload);

                                              print(
                                                  '------------------------ Hasil AI : $testCheck');

                                              if (context.mounted) {
                                                if (testCheck == 'road') {
                                                  await addLaporanProvider
                                                      .addImage(
                                                    context,
                                                    fileUpload,
                                                  );

                                                  if (context.mounted) {
                                                    Navigator.pop(context);

                                                    // Matikan Crop Image
                                                    addLaporanProvider
                                                        .cropImage();
                                                  }
                                                } else {
                                                  // Matikan Crop Image
                                                  addLaporanProvider
                                                      .cropImage();

                                                  Navigator.pop(context);

                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Row(
                                                        children: [
                                                          Icon(
                                                            FeatherIcons
                                                                .xCircle,
                                                            color: Colors.white,
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
                                                          AppColors.error500,
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                    ),
                                                  );
                                                }
                                              }
                                            }
                                          } else {
                                            if (context.mounted) {
                                              // Matikan Crop Image
                                              addLaporanProvider.cropImage();

                                              Navigator.pop(context);
                                            }
                                          }
                                        }
                                      } else {
                                        // Matikan Crop Image
                                        addLaporanProvider.cropImage();
                                      }
                                    }
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    child: Text(
                                      'Buka\nKamera',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight:
                                            AppFontWeight.actionSemiBold,
                                        fontSize: AppFontSize.actionMedium,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
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
