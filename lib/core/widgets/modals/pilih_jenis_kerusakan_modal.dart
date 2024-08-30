import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp_roadreport/features/add_laporan/provider/add_laporan_provider.dart';

import '../../constants/colors.dart';
import '../../constants/font_size.dart';
import '../../constants/font_weigth.dart';

void showPiihJenisKerusakanModal(BuildContext context, int cek) {
  showModalBottomSheet(
    useSafeArea: true,
    isScrollControlled: true,
    isDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return Consumer<AddLaporanProvider>(
          builder: (context, addLaporanProvider, _) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cek == 0
                          ? "Pilih Jenis Kerusakan"
                          : "Pilih Tingkat Kerusakan",
                      style: const TextStyle(
                          fontWeight: AppFontWeight.bodySemiBold,
                          fontSize: AppFontSize.bodyMedium),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(
                        FeatherIcons.x,
                        size: 24,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color: AppColors.neutral300,
                width: double.infinity,
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 20.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        cek == 0
                            ? addLaporanProvider.setJenisKerusakan('Retak')
                            : addLaporanProvider.setTipeKerusakan('Ringan');

                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                        decoration: BoxDecoration(
                            color: AppColors.primary50,
                            borderRadius: BorderRadius.circular(6.0)),
                        child: Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: cek == 0
                                    ? AppColors.error500
                                    : AppColors.warning500,
                              ),
                            ),
                            const SizedBox(
                              width: 12.0,
                            ),
                            Text(
                              cek == 0 ? "Retak" : "Ringan",
                              style: const TextStyle(
                                  fontSize: AppFontSize.actionMedium,
                                  fontWeight: AppFontWeight.actionSemiBold,
                                  letterSpacing: 0.75,
                                  color: AppColors.neutral800),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    InkWell(
                      onTap: () {
                        cek == 0
                            ? addLaporanProvider.setJenisKerusakan('Berlubang')
                            : addLaporanProvider.setTipeKerusakan('Sedang');

                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                        decoration: BoxDecoration(
                            color: AppColors.primary50,
                            borderRadius: BorderRadius.circular(6.0)),
                        child: Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: cek == 0
                                    ? AppColors.blue600
                                    : AppColors.error400,
                              ),
                            ),
                            const SizedBox(
                              width: 12.0,
                            ),
                            Text(
                              cek == 0 ? "Berlubang" : "Sedang",
                              style: const TextStyle(
                                  fontSize: AppFontSize.actionMedium,
                                  fontWeight: AppFontWeight.actionSemiBold,
                                  letterSpacing: 0.75,
                                  color: AppColors.neutral800),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    InkWell(
                      onTap: () {
                        cek == 0
                            ? addLaporanProvider.setJenisKerusakan('Terkelupas')
                            : addLaporanProvider.setTipeKerusakan('Parah');

                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                        decoration: BoxDecoration(
                            color: AppColors.primary50,
                            borderRadius: BorderRadius.circular(6.0)),
                        child: Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: cek == 0
                                    ? AppColors.green600
                                    : AppColors.error700,
                              ),
                            ),
                            const SizedBox(
                              width: 12.0,
                            ),
                            Text(
                              cek == 0 ? "Terkelupas" : "Parah",
                              style: const TextStyle(
                                  fontSize: AppFontSize.actionMedium,
                                  fontWeight: AppFontWeight.actionSemiBold,
                                  letterSpacing: 0.75,
                                  color: AppColors.neutral800),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    cek == 0
                        ? InkWell(
                            onTap: () {
                              addLaporanProvider
                                  .setJenisKerusakan('Bergelombang');

                              Navigator.of(context).pop();
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 12.0),
                              decoration: BoxDecoration(
                                  color: AppColors.primary50,
                                  borderRadius: BorderRadius.circular(6.0)),
                              child: Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: AppColors.purple600),
                                  ),
                                  const SizedBox(
                                    width: 12.0,
                                  ),
                                  const Text(
                                    'Bergelombang',
                                    style: TextStyle(
                                        fontSize: AppFontSize.actionMedium,
                                        fontWeight:
                                            AppFontWeight.actionSemiBold,
                                        letterSpacing: 0.75,
                                        color: AppColors.neutral800),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(
                            height: 8.0,
                          ),
                  ],
                ),
              ),
            ],
          ),
        );
      });
    },
  );
}
