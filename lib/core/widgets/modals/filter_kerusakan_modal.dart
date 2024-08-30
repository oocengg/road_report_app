import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp_roadreport/features/laporan/models/model/filter_item_model.dart';
import 'package:mobileapp_roadreport/features/laporan/provider/laporan_provider.dart';

import '../../constants/colors.dart';
import '../../constants/font_size.dart';
import '../../constants/font_weigth.dart';

void showFilterKerusakan(BuildContext context) {
  showModalBottomSheet(
    useSafeArea: true,
    isScrollControlled: true,
    isDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return Consumer<LaporanProvider>(builder: (context, laporanProvider, _) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          height: MediaQuery.of(context).size.height * 0.92,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 16.0),
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
                height: 1,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.72,
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 24.0,
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: laporanProvider.filterItems.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    FilterItem item = laporanProvider.filterItems[index];
                    return InkWell(
                      onTap: () {
                        item.isSelected = !item.isSelected;
                        if (item.isSelected) {
                          laporanProvider.addSelectedFilter(item);
                        } else {
                          laporanProvider.removeSelectedFilter(item);
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary50,
                          borderRadius: BorderRadius.circular(6.0),
                          border: Border.all(
                            color: item.isSelected
                                ? AppColors.primary500
                                : Colors.transparent,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: item.color,
                                  ),
                                ),
                                const SizedBox(
                                  width: 12.0,
                                ),
                                Text(
                                  item.text,
                                  style: const TextStyle(
                                      fontSize: AppFontSize.actionMedium,
                                      fontWeight: AppFontWeight.actionSemiBold,
                                      letterSpacing: 0.75,
                                      color: AppColors.neutral800),
                                ),
                              ],
                            ),
                            item.isSelected
                                ? const Icon(
                                    FeatherIcons.check,
                                    size: 19,
                                    color: AppColors.primary500,
                                  )
                                : Container()
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  // // Do something with the selected items here
                  // print(
                  //     "Selected items: ${laporanProvider.selectedItems.map((item) => item.text).toList()}");
                  Navigator.of(context).pop(); // Close the modal
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  margin: const EdgeInsets.only(
                    left: 16.0,
                    right: 16,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary500,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: const Text(
                    "Selesai",
                    style: TextStyle(
                      fontSize: AppFontSize.actionMedium,
                      fontWeight: AppFontWeight.actionSemiBold,
                      letterSpacing: 0.75,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      });
    },
  );
}
