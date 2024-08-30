import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/core/extensions/date_extension.dart';
import 'package:shimmer/shimmer.dart';

class RiwayatItemWidget extends StatefulWidget {
  final String progress;
  final String ticket;
  final String street;
  final String date;
  final String photo;
  const RiwayatItemWidget({
    super.key,
    required this.progress,
    required this.street,
    required this.date,
    required this.photo,
    required this.ticket,
  });

  @override
  State<RiwayatItemWidget> createState() => _RiwayatItemWidgetState();
}

class _RiwayatItemWidgetState extends State<RiwayatItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
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
      child: Row(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                widget.photo,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Shimmer.fromColors(
                    baseColor: AppColors.baseShimmerColor,
                    highlightColor: AppColors.highlightShimmerColor,
                    child: Container(
                      height: 72,
                      width: 72,
                      color: AppColors.neutral200,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.neutral200,
                  child: const Icon(Icons.image_not_supported_outlined),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.progress == 'PROG'
                          ? "Dalam Proses"
                          : widget.progress == 'FOLUP'
                              ? "Ditinjak Lanjuti"
                              : widget.progress == 'RPR' ||
                                      widget.progress == 'FIXED'
                                  ? "Perbaikan"
                                  : widget.progress == 'DONE'
                                      ? "Selesai"
                                      : widget.progress == 'RJT'
                                          ? "Ditolak"
                                          : "",
                      style: TextStyle(
                          fontSize: AppFontSize.actionSmall,
                          fontWeight: AppFontWeight.actionSemiBold,
                          color: widget.progress == 'PROG'
                              ? AppColors.primary500
                              : widget.progress == 'FOLUP'
                                  ? AppColors.warning500
                                  : widget.progress == 'RPR' ||
                                          widget.progress == 'FIXED'
                                      ? AppColors.blue600
                                      : widget.progress == 'DONE'
                                          ? AppColors.mint600
                                          : AppColors.error500,
                          letterSpacing: 0.75),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Text(
                        "No. Tiket ${widget.ticket}",
                        style: const TextStyle(
                          fontSize: AppFontSize.bodySmall,
                          fontWeight: AppFontWeight.bodyRegular,
                          color: AppColors.neutral500,
                        ),
                        textAlign: TextAlign.right,
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
                        widget.street,
                        style: const TextStyle(
                            fontSize: AppFontSize.bodySmall,
                            fontWeight: AppFontWeight.bodyRegular),
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
                        formatDateEEEEddMMyyyy(widget.date),
                        style: const TextStyle(
                            fontSize: AppFontSize.bodySmall,
                            fontWeight: AppFontWeight.bodyRegular),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
