import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobileapp_roadreport/core/widgets/modals/cara_foto_modal.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/core/state/finite_state.dart';
import 'package:mobileapp_roadreport/core/widgets/modals/add_segmen_modal.dart';
import 'package:mobileapp_roadreport/features/add_laporan/provider/add_laporan_provider.dart';
import 'package:mobileapp_roadreport/features/add_laporan/view/add_photo_screen.dart';
import 'package:mobileapp_roadreport/features/add_laporan/widgets/loading/maps_loading.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:flutter_map_tappable_polyline/flutter_map_tappable_polyline.dart';

class MapsWidget extends StatefulWidget {
  final CarouselController carouselController;
  const MapsWidget({
    super.key,
    required this.carouselController,
  });

  @override
  State<MapsWidget> createState() => _MapsWidgetState();
}

class _MapsWidgetState extends State<MapsWidget> {
  @override
  void initState() {
    context.read<AddLaporanProvider>().image.clear();
    context.read<AddLaporanProvider>().fotoModel.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddLaporanProvider>(
      builder: (context, addLaporanProvider, _) {
        if (addLaporanProvider.state == MyState.initial) {
          return const SizedBox.shrink();
        } else if (addLaporanProvider.state == MyState.loading) {
          return const MapsLoading();
        } else if (addLaporanProvider.state == MyState.loaded) {
          return Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height - 240,
                child: FlutterMap(
                  mapController: addLaporanProvider.mapController,
                  options: MapOptions(
                    center: LatLng(
                      addLaporanProvider.latitude ?? 7.8806982,
                      addLaporanProvider.longitude ?? 112.5017044,
                    ),
                    zoom: 19,
                    maxZoom: 19,
                    interactiveFlags: InteractiveFlag.all &
                        ~InteractiveFlag.pinchMove &
                        ~InteractiveFlag.pinchZoom &
                        ~InteractiveFlag.doubleTapZoom &
                        ~InteractiveFlag.drag &
                        ~InteractiveFlag.rotate &
                        ~InteractiveFlag.flingAnimation,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'http://mt0.google.com/vt/lyrs=m&hl=en&x={x}&y={y}&z={z}&s=Ga',
                      userAgentPackageName: 'com.example.app',
                      maxNativeZoom: 20,
                      maxZoom: 20,
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: addLaporanProvider.routpoints[0],
                          builder: (ctx) => lottie.LottieBuilder.asset(
                            'assets/lotties/location.json',
                            width: 80,
                            height: 80,
                          ),
                        ),
                      ],
                    ),
                    PolylineLayer(
                      polylines: addLaporanProvider.activePolylines
                          .where((polyline) => addLaporanProvider
                              .selectedPolylines
                              .contains(_extractTagPart(polyline.tag!)))
                          .toList(),
                    ),
                    PolylineLayer(
                      polylines: addLaporanProvider.deactivePolyline,
                    ),
                    TappablePolylineLayer(
                      polylines: addLaporanProvider.polylines,
                      onTap: (polylines, tapPosition) async {
                        addLaporanProvider.image.clear();
                        addLaporanProvider.fotoModel.clear();

                        // Pisahkan string menjadi bagian-bagian berdasarkan spasi
                        List<String> parts = polylines
                            .map((polyline) => polyline.tag)
                            .join('')
                            .split('+');

                        String? id =
                            parts[0]; // Konversi bagian pertama menjadi integer
                        String? name = parts
                            .sublist(1)
                            .join(" "); // Gabungkan bagian sisa sebagai nama

                        addLaporanProvider.selectedPolylines.contains(id)
                            ? await _showDeleteModal(context, id)
                            : await _showCameraModal(context, id, name);
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 16.0, // Adjust the position as needed
                right: 12.0, // Adjust the position as needed
                child: IconButton.filled(
                  onPressed: () {
                    addLaporanProvider.getLocationData(context: context);
                  },
                  icon: const Icon(
                    FeatherIcons.refreshCcw,
                    size: 16,
                  ),
                ),
              ),
              Positioned(
                bottom: 16.0, // Adjust the position as needed
                left: 16.0, // Adjust the position as needed
                right: 16.0, // Adjust the position as needed
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    backgroundColor: MaterialStatePropertyAll(
                      addLaporanProvider.selectedPolylines.isEmpty
                          ? AppColors.primary50
                          : AppColors.primary500,
                    ),
                  ),
                  onPressed: addLaporanProvider.selectedPolylines.isEmpty
                      ? null
                      : () {
                          showAddSegmenModal(
                              context, widget.carouselController);
                        },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Lanjutkan',
                      style: TextStyle(
                        fontWeight: AppFontWeight.actionSemiBold,
                        fontSize: AppFontSize.actionLarge,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: AppColors.primary50,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  addLaporanProvider.locationOn
                      ? const Text('Maaf, data segmen belum tersedia.')
                      : const Text('Maaf, kamu belum menyalakan lokasi.'),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.indigo)),
                    onPressed: () {
                      context
                          .read<AddLaporanProvider>()
                          .getLocationData(context: context);
                    },
                    child: const Text(
                      'Coba Lagi?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  String _extractTagPart(String tag) {
    List<String> parts = tag.split('+');
    if (parts.length > 1) {
      return parts[0];
    } else {
      return ''; // Mengembalikan string kosong jika tidak ada bagian setelah +
    }
  }

  Future<void> _showCameraModal(
      BuildContext context, String idPolyline, String namaJalan) async {
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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                          // Lanjut Proses
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

                                                    Navigator.of(context).push(
                                                      CupertinoPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            AddPhotoScreen(
                                                          idPolyline:
                                                              idPolyline,
                                                          namaJalan: namaJalan,
                                                        ),
                                                      ),
                                                    );

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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      backgroundColor:
                                          const MaterialStatePropertyAll(
                                        AppColors.primary500,
                                      ),
                                    ),
                                    onPressed: () async {
                                      // Tampilkan AlertDialog
                                      bool proceed =
                                          await showCaraFoto(context);

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
                                                        .checkImageRoad(context,
                                                            fileUpload);

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

                                                      Navigator.of(context)
                                                          .push(
                                                        CupertinoPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              AddPhotoScreen(
                                                            idPolyline:
                                                                idPolyline,
                                                            namaJalan:
                                                                namaJalan,
                                                          ),
                                                        ),
                                                      );

                                                      // Matikan Crop Image
                                                      addLaporanProvider
                                                          .cropImage();
                                                    }
                                                  } else {
                                                    // Matikan Crop Image
                                                    addLaporanProvider
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
                                                              color:
                                                                  Colors.white,
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
                                        'Buka Kamera',
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
}

Future<void> _showDeleteModal(BuildContext context, String idPolyline) async {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Consumer<AddLaporanProvider>(
          builder: (context, addLaporanProvider, _) {
        return Container(
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
                        'Hapus Segmen',
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
                    color: AppColors.error50,
                  ),
                  child: const Icon(
                    FeatherIcons.xCircle,
                    color: AppColors.error500,
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
                    'Apakah anda benar-benar ingin menghapus segmen yang dipilih?',
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
                          height: 70,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              elevation: null,
                              shadowColor: null,
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              backgroundColor: const MaterialStatePropertyAll(
                                AppColors.primary50,
                              ),
                            ),
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: Text(
                                'Batal',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: AppFontWeight.actionSemiBold,
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
                          height: 70,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              backgroundColor: const MaterialStatePropertyAll(
                                AppColors.error500,
                              ),
                            ),
                            onPressed: () async {
                              await addLaporanProvider
                                  .deleteSelectedPolyline(idPolyline);

                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: Text(
                                'Hapus',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: AppFontWeight.actionSemiBold,
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
