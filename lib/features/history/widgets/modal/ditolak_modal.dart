import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/core/extensions/date_extension.dart';
import 'package:mobileapp_roadreport/features/history/models/model/history_response.dart';
import 'package:mobileapp_roadreport/features/history/provider/detail_history_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/colors.dart';
import '../../view/detail_jalan_ditolak_screen.dart';

void showHistoryDitolakModal(BuildContext context, Datum data) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
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
                        const Text(
                          "DITOLAK",
                          style: TextStyle(
                            fontSize: AppFontSize.overlineLarge,
                            fontWeight: AppFontWeight.overlineBold,
                            color: AppColors.error500,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Text(
                          "No. Tiket ${data.noTicket!}",
                          style: const TextStyle(
                            fontSize: AppFontSize.bodySmall,
                            fontWeight: AppFontWeight.bodyRegular,
                            color: AppColors.neutral700,
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
                              data.segmens![0].photos![0].absPath ?? "",
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
                                    Icons.image_not_supported_outlined),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        Column(
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
                                Text(
                                  data.user!.fullname ?? "",
                                  style: const TextStyle(
                                      fontSize: AppFontSize.bodySmall,
                                      fontWeight: AppFontWeight.bodyRegular),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
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
                                Text(
                                  data.segmens![0].segmen!.name ?? "",
                                  style: const TextStyle(
                                      fontSize: AppFontSize.bodySmall,
                                      fontWeight: AppFontWeight.bodyRegular),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
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
                                Text(
                                  formatDateEEEEddMMyyyy(
                                      data.createdAt.toString()),
                                  style: const TextStyle(
                                      fontSize: AppFontSize.bodySmall,
                                      fontWeight: AppFontWeight.bodyRegular),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      data.rejected!.note!,
                      style: const TextStyle(
                        fontSize: AppFontSize.bodySmall,
                        fontWeight: AppFontWeight.bodyRegular,
                        color: AppColors.neutral700,
                      ),
                    ),
                    // RichText(
                    //   text: const TextSpan(
                    //       text: "Maaf laporan anda dinyatakan",
                    //       style: TextStyle(
                    //         fontSize: AppFontSize.bodySmall,
                    //         fontWeight: AppFontWeight.bodyRegular,
                    //         color: AppColors.neutral700,
                    //       ),
                    //       children: <TextSpan>[
                    //         TextSpan(
                    //           text: " ditolak ",
                    //           style: TextStyle(
                    //             fontSize: AppFontSize.bodySmall,
                    //             fontWeight: AppFontWeight.bodyRegular,
                    //             color: AppColors.error500,
                    //           ),
                    //         ),
                    //         TextSpan(
                    //           text:
                    //               "setelah dilakukan verifikasi data oleh admin, terimakasih karena telah mengirimkan laporan anda.",
                    //           style: TextStyle(
                    //             fontSize: AppFontSize.bodySmall,
                    //             fontWeight: AppFontWeight.bodyRegular,
                    //             color: AppColors.neutral700,
                    //           ),
                    //         )
                    //       ]),
                    // ),
                    const SizedBox(
                      height: 12,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.segmens!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            context.read<DetailHistoryProvider>().setPolyline(
                                data.segmens![index].segmen!.geojson!);
                            context.read<DetailHistoryProvider>().setCenter(
                                data.segmens![index].segmen!.centerPoint!);
                            Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) => DetailJalanDitolakScreen(
                                index: index,
                                data: data,
                              ),
                            ));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 13.5, horizontal: 12.0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                color: AppColors.primary50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Segmen Jalan ${index + 1}",
                                  style: const TextStyle(
                                    fontSize: AppFontSize.bodySmall,
                                    fontWeight: AppFontWeight.bodySemiBold,
                                  ),
                                ),
                                const Icon(
                                  FeatherIcons.chevronRight,
                                  size: 24,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 12,
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      });
}
