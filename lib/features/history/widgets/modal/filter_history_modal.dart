import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/features/history/provider/history_provider.dart';
import 'package:provider/provider.dart';

void showFilterHistoryModal(BuildContext context) {
  final provider = Provider.of<HistoryProvider>(context, listen: false);
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Pilih Berdasarkan",
                  style: TextStyle(
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
            height: 0.5,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    Navigator.of(context).pop();
                    context.read<HistoryProvider>().resetCurrentPage();
                    await provider.getData(context);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    decoration: BoxDecoration(
                        color: AppColors.primary50,
                        borderRadius: BorderRadius.circular(6.0)),
                    child: const Text(
                      "Semua",
                      style: TextStyle(
                          fontSize: AppFontSize.actionMedium,
                          fontWeight: AppFontWeight.actionSemiBold,
                          letterSpacing: 0.75,
                          color: AppColors.neutral800),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                InkWell(
                  onTap: () async {
                    Navigator.of(context).pop();
                    context.read<HistoryProvider>().resetCurrentPage();
                    context.read<HistoryProvider>().setFiltered(true);
                    context.read<HistoryProvider>().setId("[eq]=PROG");
                    await provider.filter(context);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    decoration: BoxDecoration(
                        color: AppColors.primary50,
                        borderRadius: BorderRadius.circular(6.0)),
                    child: const Text(
                      "Dalam Proses",
                      style: TextStyle(
                          fontSize: AppFontSize.actionMedium,
                          fontWeight: AppFontWeight.actionSemiBold,
                          letterSpacing: 0.75,
                          color: AppColors.neutral800),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                InkWell(
                  onTap: () async {
                    Navigator.of(context).pop();
                    context.read<HistoryProvider>().resetCurrentPage();
                    context.read<HistoryProvider>().setFiltered(true);
                    context.read<HistoryProvider>().setId("[eq]=FOLUP");
                    await provider.filter(context);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    decoration: BoxDecoration(
                        color: AppColors.primary50,
                        borderRadius: BorderRadius.circular(6.0)),
                    child: const Text(
                      "Tindak Lanjut",
                      style: TextStyle(
                          fontSize: AppFontSize.actionMedium,
                          fontWeight: AppFontWeight.actionSemiBold,
                          letterSpacing: 0.75,
                          color: AppColors.neutral800),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                InkWell(
                  onTap: () async {
                    Navigator.of(context).pop();
                    context.read<HistoryProvider>().resetCurrentPage();
                    context.read<HistoryProvider>().setFiltered(true);
                    context
                        .read<HistoryProvider>()
                        .setId("[ne]=PROG,FOLUP,RJT,DONE");
                    await provider.filter(context);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    decoration: BoxDecoration(
                        color: AppColors.primary50,
                        borderRadius: BorderRadius.circular(6.0)),
                    child: const Text(
                      "Perbaikan",
                      style: TextStyle(
                          fontSize: AppFontSize.actionMedium,
                          fontWeight: AppFontWeight.actionSemiBold,
                          letterSpacing: 0.75,
                          color: AppColors.neutral800),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                InkWell(
                  onTap: () async {
                    Navigator.of(context).pop();
                    context.read<HistoryProvider>().resetCurrentPage();
                    context.read<HistoryProvider>().setFiltered(true);
                    context.read<HistoryProvider>().setId("[eq]=DONE");
                    await provider.filter(context);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    decoration: BoxDecoration(
                        color: AppColors.primary50,
                        borderRadius: BorderRadius.circular(6.0)),
                    child: const Text(
                      "Selesai",
                      style: TextStyle(
                          fontSize: AppFontSize.actionMedium,
                          fontWeight: AppFontWeight.actionSemiBold,
                          letterSpacing: 0.75,
                          color: AppColors.neutral800),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                InkWell(
                  onTap: () async {
                    Navigator.of(context).pop();
                    context.read<HistoryProvider>().resetCurrentPage();
                    context.read<HistoryProvider>().setFiltered(true);
                    context.read<HistoryProvider>().setId("[eq]=RJT");
                    await provider.filter(context);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    decoration: BoxDecoration(
                        color: AppColors.primary50,
                        borderRadius: BorderRadius.circular(6.0)),
                    child: const Text(
                      "Ditolak",
                      style: TextStyle(
                          fontSize: AppFontSize.actionMedium,
                          fontWeight: AppFontWeight.actionSemiBold,
                          letterSpacing: 0.75,
                          color: AppColors.neutral800),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      );
    },
  );
}
