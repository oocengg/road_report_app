import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tappable_polyline/flutter_map_tappable_polyline.dart';
import 'package:mobileapp_roadreport/features/laporan/widgets/modal/segmen_modal.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/core/state/finite_state.dart';
import 'package:mobileapp_roadreport/core/widgets/modals/filter_kerusakan_modal.dart';
import 'package:mobileapp_roadreport/features/laporan/provider/laporan_provider.dart';
import 'package:mobileapp_roadreport/features/laporan/widgets/loading/laporan_loading.dart';
import 'package:lottie/lottie.dart' as lottie;

class LaporanScreen extends StatefulWidget {
  const LaporanScreen({super.key});

  @override
  State<LaporanScreen> createState() => _LaporanScreenState();
}

class _LaporanScreenState extends State<LaporanScreen> {
  bool isGestureActive = false;
  Timer? _printTimer; // Declare Timer

  void _updateCenterCoordinates() {
    if (_printTimer != null && _printTimer!.isActive) {
      _printTimer!.cancel(); // Cancel the previous timer if it's still active
    }

    setState(() {
      isGestureActive = true;
    });

    _printTimer = Timer(const Duration(seconds: 1), () {
      setState(() {
        isGestureActive = false;
      });

      context.read<LaporanProvider>().polylines.clear();

      double zoomLevel = context.read<LaporanProvider>().mapController.zoom;
      double distanceInMeter;

      if (zoomLevel >= 13 && zoomLevel <= 14) {
        distanceInMeter = 5.35 * 1000; // Konversi dari kilometer ke meter
      } else if (zoomLevel > 14 && zoomLevel <= 15) {
        distanceInMeter = 3.24 * 1000;
      } else if (zoomLevel > 15 && zoomLevel <= 16) {
        distanceInMeter = 1.57 * 1000;
      } else if (zoomLevel > 16 && zoomLevel <= 17) {
        distanceInMeter = 853;
      } else if (zoomLevel > 17 && zoomLevel <= 18) {
        distanceInMeter = 390;
      } else if (zoomLevel > 18 && zoomLevel <= 19) {
        distanceInMeter = 207;
      } else {
        distanceInMeter = 207;
      }

      context.read<LaporanProvider>().getSegmenData(
            context.read<LaporanProvider>().mapController.center.latitude,
            context.read<LaporanProvider>().mapController.center.longitude,
            distanceInMeter.toInt(),
          );
    });
  }

  @override
  void dispose() {
    _printTimer?.cancel(); // Cancel the timer when disposing the widget
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LaporanProvider>().selectedItems.clear();
      context.read<LaporanProvider>().clearIsSelected();
      context.read<LaporanProvider>().zoom = 16;
      context.read<LaporanProvider>().getLocationData(context: context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Titik Laporan',
          style: TextStyle(
            fontWeight: AppFontWeight.bodySemiBold,
            fontSize: AppFontSize.bodyMedium,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primary500,
        actions: [
          IconButton(
            onPressed: () {
              context.read<LaporanProvider>().selectedItems.clear();
              context.read<LaporanProvider>().clearIsSelected();
              context.read<LaporanProvider>().zoom = 16;
              context.read<LaporanProvider>().getLocationData(context: context);
            },
            icon: const Icon(
              FeatherIcons.refreshCw,
              size: 22,
            ),
          ),
        ],
      ),
      body: Consumer<LaporanProvider>(
        builder: (context, laporanProvider, _) {
          if (laporanProvider.state == MyState.initial) {
            return const SizedBox.shrink();
          } else if (laporanProvider.state == MyState.loading) {
            return const LaporanLoading();
          } else if (laporanProvider.state == MyState.loaded) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: FlutterMap(
                    mapController: laporanProvider.mapController,
                    options: MapOptions(
                      center: laporanProvider.routpoints[0],
                      zoom: 16,
                      maxZoom: 19,
                      minZoom: 13,
                      onPositionChanged: (position, hasGesture) {
                        if (hasGesture) {
                          laporanProvider.zoom =
                              laporanProvider.mapController.zoom;
                          _updateCenterCoordinates();
                        }
                      },
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
                            point: laporanProvider.routpoints[0],
                            builder: (ctx) => lottie.LottieBuilder.asset(
                              'assets/lotties/location.json',
                              width: 80,
                              height: 80,
                            ),
                          ),
                        ],
                      ),
                      TappablePolylineLayer(
                        onTap: (polylines, tapPosition) async {
                          String tag = polylines
                              .map((polyline) => polyline.tag)
                              .toString();
                          String color = polylines
                              .map((polyline) => polyline.color)
                              .map((color) =>
                                  "0x${color.value.toRadixString(16).padLeft(8, '0')}")
                              .toString();

                          tag = tag.replaceAll('(', '').replaceAll(')', '');
                          color = color.replaceAll('(', '').replaceAll(')', '');

                          int colorValue =
                              int.parse(color.substring(2), radix: 16);

                          await laporanProvider.getDetailSegmen(tag);

                          if (context.mounted) {
                            showDetailSegmenModal(context, colorValue);
                          }
                        },
                        polylines: laporanProvider.selectedItems.isEmpty
                            ? laporanProvider.polylines
                            : laporanProvider.polylines
                                .where(
                                  (element) => laporanProvider.selectedItems
                                      .map((item) => item.color)
                                      .toList()
                                      .contains(element.color),
                                )
                                .toList(),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 16,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            laporanProvider.zoom >= 19
                                ? null
                                : laporanProvider.plusZoom();
                          },
                          icon: Icon(
                            FeatherIcons.plus,
                            color: laporanProvider.zoom >= 19
                                ? AppColors.neutral300
                                : Colors.black,
                            size: 24,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            laporanProvider.zoom <= 13
                                ? null
                                : laporanProvider.minZoom();
                          },
                          icon: Icon(
                            FeatherIcons.minus,
                            color: laporanProvider.zoom <= 13
                                ? AppColors.neutral300
                                : Colors.black,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 16,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      onPressed: () {
                        showFilterKerusakan(context);
                      },
                      icon: const Icon(
                        FeatherIcons.filter,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                laporanProvider.stateGetSegmen == MyState.loading
                    ? Positioned(
                        right: 0,
                        top: 0,
                        left: 0,
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Maaf, Terjadi kesalahan saat mengambil data.'),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(AppColors.primary500)),
                    onPressed: () {
                      // context.read<SmallMapsProvider>().getSegmenData(
                      //       -7.874585,
                      //       112.519770,
                      //       1570,
                      //     );
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
            );
          }
        },
      ),
    );
  }
}
