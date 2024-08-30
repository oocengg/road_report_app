import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobileapp_roadreport/features/home/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/core/state/finite_state.dart';
import 'package:mobileapp_roadreport/features/add_laporan/widgets/loading/maps_loading.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:flutter_map_tappable_polyline/flutter_map_tappable_polyline.dart';

class DraftMapsWidget extends StatefulWidget {
  final CarouselController carouselController;
  final int index;
  const DraftMapsWidget({
    super.key,
    required this.carouselController,
    required this.index,
  });

  @override
  State<DraftMapsWidget> createState() => _DraftMapsWidgetState();
}

class _DraftMapsWidgetState extends State<DraftMapsWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().image.clear();
      context.read<HomeProvider>().fotoModel.clear();
      context.read<HomeProvider>().setPolyline(context, widget.index);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, _) {
        if (homeProvider.state == MyState.initial) {
          return const SizedBox.shrink();
        } else if (homeProvider.state == MyState.loading) {
          return const MapsLoading();
        } else if (homeProvider.state == MyState.loaded) {
          return Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height - 240,
                child: FlutterMap(
                  mapController: homeProvider.mapController,
                  options: MapOptions(
                    center: LatLng(
                      homeProvider.latitude ?? 7.8806982,
                      homeProvider.longitude ?? 112.5017044,
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
                          width: 30.0,
                          height: 30.0,
                          point: LatLng(
                            homeProvider.latitude!,
                            homeProvider.longitude!,
                          ),
                          builder: (ctx) => lottie.LottieBuilder.asset(
                            'assets/lotties/location.json',
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ],
                    ),
                    PolylineLayer(
                      polylines: homeProvider.activePolylines
                          .where((polyline) => homeProvider.selectedPolylines
                              .contains(_extractTagPart(polyline.tag!)))
                          .toList(),
                    ),
                    PolylineLayer(
                      polylines: homeProvider.deactivePolyline,
                    ),
                    TappablePolylineLayer(
                      polylines: homeProvider.polylines,
                      onTap: (polylines, tapPosition) async {
                        homeProvider.image.clear();
                        homeProvider.fotoModel.clear();

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

                        homeProvider.selectedPolylines.contains(id)
                            ? await _showDeleteModal(context, id)
                            : await _showPhotoModal(
                                context,
                                id,
                                name,
                                widget.index,
                                widget.carouselController,
                              );
                      },
                    ),
                  ],
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
                  const Text('Maaf, data segmen belum tersedia.'),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.indigo)),
                    onPressed: () {
                      homeProvider.getLocationData(
                          double.tryParse(homeProvider.lat[widget.index])!,
                          double.tryParse(homeProvider.lng[widget.index])!);
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

  Future<void> _showPhotoModal(
      BuildContext context,
      String idPolyline,
      String namaJalan,
      int index,
      CarouselController carouselController) async {
    showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      context: context,
      builder: (BuildContext context) {
        return Consumer<HomeProvider>(
          builder: (context, homeProvider, _) => Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: homeProvider.fotoState == MyState.loading
                ? Container(
                    width: double.infinity,
                    height: 450,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: const SizedBox(
                        child: Center(child: CircularProgressIndicator())),
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
                                'Info',
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
                          width: 150,
                          height: 150,
                          decoration: const BoxDecoration(
                            color: AppColors.neutral300,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(homeProvider.draft[index]),
                              fit: BoxFit.cover,
                            ),
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
                            'Apakah anda yakin untuk menambahkan gambar ini kedalam segmen?',
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
                                      Navigator.pop(context);
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      child: Text(
                                        'Tidak',
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
                                  height: 70,
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
                                      await homeProvider.addImage(
                                        context,
                                        File(homeProvider.draft[index]),
                                      );

                                      if (context.mounted) {
                                        Navigator.pop(context);

                                        homeProvider
                                            .addSelectedPolyline(idPolyline);

                                        await homeProvider.addSegmen(
                                          idPolyline,
                                          namaJalan,
                                          homeProvider.jenisKerusakan,
                                          homeProvider.tipeKerusakan,
                                          homeProvider.image,
                                          homeProvider.fotoModel,
                                        );

                                        if (context.mounted) {
                                          carouselController.nextPage(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeInOut,
                                          );
                                        }
                                      }
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      child: Text(
                                        'Tambahkan',
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
          ),
        );
      },
    );
  }
}

Future<void> _showDeleteModal(BuildContext context, String idPolyline) async {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Consumer<HomeProvider>(builder: (context, homeProvider, _) {
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
                              await homeProvider
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
