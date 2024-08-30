import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/core/state/finite_state.dart';
import 'package:mobileapp_roadreport/features/dashboard/provider/dashboard_provider.dart';
import 'package:mobileapp_roadreport/features/home/provider/small_maps_provider.dart';
import 'package:mobileapp_roadreport/features/home/widgets/loading/small_maps_loading.dart';
import 'package:lottie/lottie.dart' as lottie;

class SmallMapsWidget extends StatelessWidget {
  const SmallMapsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SmallMapsProvider>(
      builder: (context, smallMapsProvider, _) {
        if (smallMapsProvider.state == MyState.initial) {
          return const SizedBox.shrink();
        } else if (smallMapsProvider.state == MyState.loading) {
          return const SmallMapsLoading();
        } else if (smallMapsProvider.state == MyState.loaded) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
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
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 160,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: AppColors.neutral300,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: FlutterMap(
                    options: MapOptions(
                      center: smallMapsProvider.routpoints[0],
                      zoom: 15,
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
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 50.0,
                            height: 50.0,
                            point: smallMapsProvider.routpoints[0],
                            builder: (ctx) => lottie.LottieBuilder.asset(
                              'assets/lotties/location.json',
                              width: 80,
                              height: 80,
                            ),
                          ),
                        ],
                      ),
                      PolylineLayer(
                        polylineCulling: false,
                        polylines: smallMapsProvider.polylines,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8.5,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          '${smallMapsProvider.polylines.length} Laporan \nDisekitar Anda.',
                          style: const TextStyle(
                            fontSize: AppFontSize.bodySmall,
                            fontWeight: AppFontWeight.captionRegular,
                            color: AppColors.neutral700,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<DashboardProvider>()
                              .setSelectedIndex(context, 1);
                        },
                        style: ButtonStyle(
                          backgroundColor: const MaterialStatePropertyAll(
                            Colors.white,
                          ),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                color: AppColors.primary500,
                              ),
                            ),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Lihat Titik Laporan',
                            style: TextStyle(
                              fontWeight: AppFontWeight.actionRegular,
                              fontSize: AppFontSize.actionSmall,
                              color: AppColors.primary500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
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
            child: SizedBox(
              height: 160,
              child: Center(
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
                        context.read<SmallMapsProvider>().getSegmenData(
                              context.read<SmallMapsProvider>().latitude ?? 0,
                              context.read<SmallMapsProvider>().longitude ?? 0,
                              1570,
                            );
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
            ),
          );
        }
      },
    );
  }
}
