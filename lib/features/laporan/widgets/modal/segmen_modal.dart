import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/core/extensions/date_extension.dart';
import 'package:mobileapp_roadreport/features/laporan/provider/laporan_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

void showDetailSegmenModal(BuildContext context, int color) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Consumer<LaporanProvider>(
        builder: (context, laporanProvider, _) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Detail",
                        style: TextStyle(
                          fontSize: AppFontSize.bodyMedium,
                          fontWeight: AppFontWeight.bodySemiBold,
                        ),
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
                  height: 0.5,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            laporanProvider.segmenDetailData.status! ==
                                    'Selesai Perbaikan'
                                ? 'PERBAIKAN'
                                : laporanProvider.segmenDetailData.status!
                                    .toUpperCase(),
                            style: TextStyle(
                              fontSize: AppFontSize.overlineLarge,
                              fontWeight: AppFontWeight.overlineBold,
                              color: laporanProvider.segmenDetailData.status ==
                                      'Dalam Proses'
                                  ? AppColors.primary500
                                  : laporanProvider.segmenDetailData.status ==
                                          'Ditindak Lanjuti'
                                      ? AppColors.warning500
                                      : AppColors.blue600,
                              letterSpacing: 1.5,
                            ),
                          ),
                          Text(
                            "No. Tiket ${laporanProvider.segmenDetailData.noTicket}",
                            style: const TextStyle(
                              fontSize: AppFontSize.bodySmall,
                              fontWeight: AppFontWeight.bodyRegular,
                              color: AppColors.neutral500,
                            ),
                            textAlign: TextAlign.right,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 94,
                            height: 94,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                laporanProvider
                                        .segmenDetailData.photos![0].absPath ??
                                    "",
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Shimmer.fromColors(
                                    baseColor: AppColors.baseShimmerColor,
                                    highlightColor:
                                        AppColors.highlightShimmerColor,
                                    child: Container(
                                      height: 94,
                                      width: 94,
                                      color: AppColors.neutral200,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  color: AppColors.neutral200,
                                  child: const Icon(
                                    Icons.image_not_supported_outlined,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      FeatherIcons.user,
                                      color: AppColors.primary500,
                                      size: 16,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Flexible(
                                      child: Text(
                                        laporanProvider.segmenDetailData.user ??
                                            '-',
                                        style: const TextStyle(
                                            fontSize: AppFontSize.bodySmall,
                                            fontWeight:
                                                AppFontWeight.bodyRegular),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      FeatherIcons.mapPin,
                                      color: AppColors.primary500,
                                      size: 16,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Flexible(
                                      child: Text(
                                        laporanProvider.segmenDetailData.name ??
                                            '-',
                                        style: const TextStyle(
                                            fontSize: AppFontSize.bodySmall,
                                            fontWeight:
                                                AppFontWeight.bodyRegular),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      FeatherIcons.calendar,
                                      color: AppColors.primary500,
                                      size: 16,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Flexible(
                                      child: Text(
                                        formatDateEEEEddMMyyyy(laporanProvider
                                            .segmenDetailData.date!),
                                        style: const TextStyle(
                                          fontSize: AppFontSize.bodySmall,
                                          fontWeight: AppFontWeight.bodyRegular,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Keterangan : ',
                            style: TextStyle(
                                fontSize: AppFontSize.bodySmall,
                                fontWeight: AppFontWeight.bodyRegular),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(color),
                            ),
                            child: Text(
                              '${(laporanProvider.segmenDetailData.typeSegmenAdmin == 'permukaankasar' ? 'Permukaan Kasar' : laporanProvider.segmenDetailData.typeSegmenAdmin) ?? (laporanProvider.segmenDetailData.typeSegmenSystem == 'permukaankasar' ? 'Permukaan Kasar' : laporanProvider.segmenDetailData.typeSegmenSystem) ?? (laporanProvider.segmenDetailData.userType == '-' ? 'Sedang disurvei' : laporanProvider.segmenDetailData.userType)} ${laporanProvider.segmenDetailData.levelSegmenAdmin ?? laporanProvider.segmenDetailData.levelSegmenSystem ?? (laporanProvider.segmenDetailData.userLevel == '-' ? 'oleh Admin' : laporanProvider.segmenDetailData.userLevel)}',
                              style: TextStyle(
                                fontSize: AppFontSize.bodySmall,
                                fontWeight: AppFontWeight.bodyBold,
                                color:
                                    laporanProvider.segmenDetailData.userType ==
                                            '-'
                                        ? Colors.black.withOpacity(0.7)
                                        : Colors.white,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      laporanProvider.segmenDetailData.status == 'Dalam Proses'
                          ? RichText(
                              text: const TextSpan(
                                  text: "Laporan anda sedang dalam proses",
                                  style: TextStyle(
                                    fontSize: AppFontSize.bodySmall,
                                    fontWeight: AppFontWeight.bodyRegular,
                                    color: AppColors.neutral700,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: " Verifikasi Admin",
                                      style: TextStyle(
                                        fontSize: AppFontSize.bodySmall,
                                        fontWeight: AppFontWeight.bodySemiBold,
                                        color: AppColors.primary500,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          ", silahkan menunggu informasi selanjutnya.",
                                      style: TextStyle(
                                        fontSize: AppFontSize.bodySmall,
                                        fontWeight: AppFontWeight.bodyRegular,
                                        color: AppColors.neutral700,
                                      ),
                                    )
                                  ]),
                            )
                          : laporanProvider.segmenDetailData.status ==
                                  'Ditindak Lanjuti'
                              ? RichText(
                                  text: const TextSpan(
                                      text: "Laporan anda telah",
                                      style: TextStyle(
                                        fontSize: AppFontSize.bodySmall,
                                        fontWeight: AppFontWeight.bodyRegular,
                                        color: AppColors.neutral700,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: " Ditindak Lanjuti",
                                          style: TextStyle(
                                            fontSize: AppFontSize.bodySmall,
                                            fontWeight:
                                                AppFontWeight.bodySemiBold,
                                            color: AppColors.warning500,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              ", silahkan menunggu jadwal perbaikan.",
                                          style: TextStyle(
                                            fontSize: AppFontSize.bodySmall,
                                            fontWeight:
                                                AppFontWeight.bodyRegular,
                                            color: AppColors.neutral700,
                                          ),
                                        )
                                      ]),
                                )
                              : RichText(
                                  text: const TextSpan(
                                      text: "Laporan anda sedang dalam proses",
                                      style: TextStyle(
                                        fontSize: AppFontSize.bodySmall,
                                        fontWeight: AppFontWeight.bodyRegular,
                                        color: AppColors.neutral700,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: " Perbaikan ",
                                          style: TextStyle(
                                            fontSize: AppFontSize.bodySmall,
                                            fontWeight:
                                                AppFontWeight.bodySemiBold,
                                            color: AppColors.blue600,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              ", silahkan melihat detail progres perbaikan.",
                                          style: TextStyle(
                                            fontSize: AppFontSize.bodySmall,
                                            fontWeight:
                                                AppFontWeight.bodyRegular,
                                            color: AppColors.neutral700,
                                          ),
                                        )
                                      ]),
                                ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      );
    },
  );
}
