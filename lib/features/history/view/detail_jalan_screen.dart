import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:mobileapp_roadreport/features/history/provider/detail_history_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/font_size.dart';
import '../../../core/constants/font_weigth.dart';

class DetailJalanScreen extends StatefulWidget {
  final int index;
  const DetailJalanScreen({super.key, required this.index});

  @override
  State<DetailJalanScreen> createState() => _DetailJalanScreenState();
}

class _DetailJalanScreenState extends State<DetailJalanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Laporan',
          style: TextStyle(
              fontWeight: AppFontWeight.bodySemiBold,
              fontSize: AppFontSize.bodyMedium,
              color: Colors.white),
        ),
        backgroundColor: AppColors.primary500,
      ),
      body: Consumer<DetailHistoryProvider>(builder: (context, provider, _) {
        return SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                item(
                    "Nama Segmen",
                    provider.detail[0].segmens![widget.index].segmen!.name ??
                        ""),
                const SizedBox(
                  height: 16,
                ),
                item(
                    "Jenis Kerusakan",
                    provider.detail[0].segmens![widget.index].analyticData !=
                            null
                        ? provider.detail[0].segmens![widget.index]
                                .analyticData!.typeSegmenAdmin ??
                            provider.detail[0].segmens![widget.index]
                                .analyticData!.typeSegmenSystem ??
                            provider
                                .detail[0].segmens![widget.index].userType ??
                            ""
                        : provider.detail[0].segmens![widget.index].userType ??
                            ""),
                const SizedBox(
                  height: 16,
                ),
                item(
                    "Tingkat Kerusakan",
                    provider.detail[0].segmens![widget.index].analyticData !=
                            null
                        ? provider.detail[0].segmens![widget.index]
                                .analyticData!.levelSegmenAdmin ??
                            provider.detail[0].segmens![widget.index]
                                .analyticData!.levelSegmenSystem ??
                            provider
                                .detail[0].segmens![widget.index].userLevel ??
                            ""
                        : provider.detail[0].segmens![widget.index].userLevel ??
                            ""),
                const SizedBox(
                  height: 16,
                ),
                item("Foto Keadaan Jalan", ""),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: provider
                        .detail[0].segmens![widget.index].photos!.length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 12,
                      );
                    },
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          _showFullScreenImage(
                              context,
                              provider.detail[0].segmens![widget.index]
                                      .photos![index].absPath ??
                                  "");
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            provider.detail[0].segmens![widget.index]
                                    .photos![index].absPath ??
                                "",
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Shimmer.fromColors(
                                baseColor: AppColors.baseShimmerColor,
                                highlightColor: AppColors.highlightShimmerColor,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  color: AppColors.neutral200,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              color: AppColors.neutral200,
                              height: 100,
                              width: 100,
                              child: const Icon(
                                Icons.image_not_supported_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                item(
                    "Alamat",
                    provider.detail[0].segmens![widget.index].segmen!.name ??
                        ""),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Koordinat",
                      style: TextStyle(
                        fontSize: AppFontSize.bodyMedium,
                        fontWeight: AppFontWeight.bodySemiBold,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final availableMaps = await MapLauncher.installedMaps;
                          await availableMaps.first.showMarker(
                            coords: Coords(
                              provider.center.latitude,
                              provider.center.longitude,
                            ),
                            title:
                                provider.detail[0].segmens![0].segmen!.name ??
                                    '-',
                          );
                        },
                        child: Text(
                          "[${provider.center.latitude},${provider.center.longitude}]",
                          style: const TextStyle(
                            fontSize: AppFontSize.bodyMedium,
                            fontWeight: AppFontWeight.bodyRegular,
                            color: AppColors.blue500,
                            decoration: TextDecoration.underline,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                item("Panjang Segmen",
                    "${provider.detail[0].segmens![widget.index].segmen!.length == null ? 0 : provider.detail[0].segmens![widget.index].segmen!.length!.toStringAsFixed(2)} m"),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  width: double.infinity,
                  height: 160,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: AppColors.neutral300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FlutterMap(
                    // mapController: addLaporanProvider.mapController,
                    options: MapOptions(
                      center: provider.listPolyline[0].points[0],
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
                      PolylineLayer(
                        polylines: provider.listPolyline,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

Widget item(String title, String value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: AppFontSize.bodyMedium,
          fontWeight: AppFontWeight.bodySemiBold,
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      Expanded(
        child: Text(
          value,
          style: const TextStyle(
            fontSize: AppFontSize.bodyMedium,
            fontWeight: AppFontWeight.bodyRegular,
          ),
          textAlign: TextAlign.right,
        ),
      ),
    ],
  );
}

void _showFullScreenImage(BuildContext context, String image) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        backgroundColor: Colors.transparent,
        content: SizedBox(
          width: 400,
          height: MediaQuery.of(context).size.width * 0.8,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors
                          .black12, // Ganti dengan warna latar belakang yang diinginkan
                      shape: BoxShape.circle,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
