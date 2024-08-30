import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobileapp_roadreport/features/home/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/core/widgets/modals/camera_modal.dart';
import 'package:mobileapp_roadreport/features/add_laporan/models/model/segmen_model.dart';

class DraftDetailSegmenWidget extends StatelessWidget {
  final int index;
  const DraftDetailSegmenWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Segmen',
          style: TextStyle(
            fontWeight: AppFontWeight.bodySemiBold,
            fontSize: AppFontSize.bodyMedium,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primary500,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        child: Consumer<HomeProvider>(
          builder: (context, homeProvider, _) {
            SegmenModel selectedSegmen = homeProvider.listSegmen.firstWhere(
              (segmen) => segmen.id == homeProvider.listSegmen[index].id,
            );

            return Column(
              children: [
                Expanded(
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      item('Nama Segmen', 'Segmen Jalan ${index + 1}'),
                      const SizedBox(
                        height: 16,
                      ),
                      item('Foto Keadaan Jalan', ''),
                      const SizedBox(
                        height: 12,
                      ),
                      homeProvider.listSegmen[index].foto!.isEmpty
                          ? GestureDetector(
                              onTap: () {
                                showCameraModal(context);
                              },
                              child: Container(
                                height: 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                child: const Icon(FeatherIcons.camera),
                              ),
                            )
                          : SizedBox(
                              height: 100,
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount:
                                    homeProvider.listSegmen[index].foto!.length,
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    width: 12,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  final image = homeProvider
                                      .listSegmen[this.index].foto![index];
                                  return GestureDetector(
                                    onTap: () {
                                      _showFullScreenImage(
                                          context, image, homeProvider, index);
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        width: 100,
                                        height: 100,
                                        File(image),
                                        fit: BoxFit.cover,
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
                        'Alamat',
                        homeProvider.listSegmen[index].namaJalan! == 'null' ||
                                homeProvider.listSegmen[index].namaJalan == null
                            ? '-'
                            : homeProvider.listSegmen[index].namaJalan!,
                      ),
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
                          mapController: homeProvider.mapController,
                          options: MapOptions(
                            center: calculateCenter(homeProvider.activePolylines
                                .where((polyline) =>
                                    _extractTagPart(polyline.tag!) ==
                                    selectedSegmen.id)
                                .first
                                .points),
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
                                polylines: homeProvider.activePolylines
                                    .where((polyline) =>
                                        _extractTagPart(polyline.tag!) ==
                                        selectedSegmen.id)
                                    .toList()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  LatLng calculateCenter(List<LatLng> points) {
    double sumLat = 0;
    double sumLng = 0;

    for (var point in points) {
      sumLat += point.latitude;
      sumLng += point.longitude;
    }

    double centerLat = sumLat / points.length;
    double centerLng = sumLng / points.length;

    return LatLng(centerLat, centerLng);
  }

  void _showFullScreenImage(
      BuildContext context, image, HomeProvider homeProvider, int index) {
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
                  child: Image.file(
                    File(image),
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
}

String _extractTagPart(String tag) {
  List<String> parts = tag.split('+');
  if (parts.length > 1) {
    return parts[0];
  } else {
    return ''; // Mengembalikan string kosong jika tidak ada bagian setelah +
  }
}

Widget item(String title, String value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Flexible(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: AppFontSize.bodyMedium,
            fontWeight: AppFontWeight.bodySemiBold,
          ),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      Flexible(
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
