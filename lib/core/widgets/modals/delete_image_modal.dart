import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/features/add_laporan/provider/add_laporan_provider.dart';

void showDeleteImageModal(
  BuildContext context,
  image,
  AddLaporanProvider addLaporanProvider,
  int index,
  bool fromDetail,
) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 20,
                  right: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Hapus Gambar',
                      style: TextStyle(
                        fontSize: AppFontSize.bodyMedium,
                        fontWeight: AppFontWeight.bodySemiBold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        FeatherIcons.x,
                        size: 20,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.error50,
                ),
                child: const Icon(
                  FeatherIcons.trash2,
                  color: AppColors.error500,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text(
                  'Apakah anda benar-benar ingin menghapus gambar ini?',
                  style: TextStyle(
                    fontSize: AppFontSize.bodyMedium,
                    fontWeight: AppFontWeight.bodyRegular,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: SizedBox(
                        width: double.infinity,
                        height: 70,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: null,
                            shadowColor: null,
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            backgroundColor: const MaterialStatePropertyAll(
                              AppColors.primary50,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Text(
                              'Tidak',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: AppFontWeight.actionSemiBold,
                                fontSize: AppFontSize.actionMedium,
                                color: AppColors.primary500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Flexible(
                      child: SizedBox(
                        width: double.infinity,
                        height: 70,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            backgroundColor: const MaterialStatePropertyAll(
                              AppColors.error500,
                            ),
                          ),
                          onPressed: () {
                            addLaporanProvider.removeImage(index);
                            Navigator.pop(context);
                            if (fromDetail) {
                              Navigator.pop(context);
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Text(
                              'Hapus',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: AppFontWeight.actionSemiBold,
                                fontSize: AppFontSize.actionMedium,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 26,
              ),
            ],
          ),
        ),
      );
    },
  );
}
