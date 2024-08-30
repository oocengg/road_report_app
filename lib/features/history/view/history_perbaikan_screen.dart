import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:mobileapp_roadreport/core/extensions/date_extension.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp_roadreport/core/state/finite_state.dart';
import 'package:mobileapp_roadreport/features/history/provider/detail_history_provider.dart';
import 'package:mobileapp_roadreport/features/history/widgets/loading/history_perbaikan_loading.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/font_size.dart';
import '../../../core/constants/font_weigth.dart';

class HistoryPerbaikanScreen extends StatelessWidget {
  const HistoryPerbaikanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
      child: Consumer<DetailHistoryProvider>(
        builder: (context, provider, _) {
          if (provider.state == MyState.initial) {
            return const SizedBox.shrink();
          } else if (provider.state == MyState.loading) {
            return const HistoryPerbaikanLoading();
          } else if (provider.state == MyState.loaded) {
            if (provider.index == 2) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Proses Perbaikan Jalan",
                              style: TextStyle(
                                  fontSize: AppFontSize.bodyMedium,
                                  fontWeight: AppFontWeight.bodySemiBold,
                                  color: AppColors.primary500),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Image.asset(
                              "assets/images/babu.jpg",
                              height: 172,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            const Text(
                              "Yey, sekarang jalannya sudah dalam proses perbaikan yuk pantu prosesnya dilokasi",
                              style: TextStyle(
                                  fontSize: AppFontSize.bodySmall,
                                  fontWeight: AppFontWeight.bodyRegular),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 42.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            FeatherIcons.calendar,
                            color: Color(0xff586AF5),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            formatDateEEEEddMMyyyy(provider
                                .detail[0].schedule!.dateStart
                                .toString()),
                            style: const TextStyle(
                                fontSize: AppFontSize.bodySmall,
                                fontWeight: AppFontWeight.bodyRegular),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Ke google map
                  GestureDetector(
                    onTap: () async {
                      final availableMaps = await MapLauncher.installedMaps;
                      await availableMaps.first.showMarker(
                        coords: Coords(
                          provider.listPolyline[0].points[0].latitude,
                          provider.listPolyline[0].points[0].longitude,
                        ),
                        title:
                            provider.detail[0].segmens![0].segmen!.name ?? '-',
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        color: const Color(0xff586af5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Text(
                        "Lihat Lokasi",
                        style: TextStyle(
                            fontSize: AppFontSize.actionMedium,
                            fontWeight: AppFontWeight.actionSemiBold,
                            letterSpacing: 0.75,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
