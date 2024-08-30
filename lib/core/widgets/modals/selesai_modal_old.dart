import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/features/add_laporan/provider/add_laporan_provider.dart';
import 'package:mobileapp_roadreport/features/dashboard/provider/dashboard_provider.dart';

void showSelesaiModalOld(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Consumer<AddLaporanProvider>(
          builder: (context, addLaporanProvider, _) {
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
                        'Selesai',
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
                    color: AppColors.success50,
                  ),
                  child: const Icon(
                    FeatherIcons.check,
                    color: AppColors.success500,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'Selamat, Laporan Diproses!',
                  style: TextStyle(
                    fontSize: AppFontSize.heading4,
                    fontWeight: AppFontWeight.headingSemiBold,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    'Laporan Anda sedang diproses oleh sistem dengan nomer tiket 0127789, untuk melihat detail laporan silahkan melihat pada laman Riwayat.',
                    style: TextStyle(
                      fontSize: AppFontSize.bodyMedium,
                      fontWeight: AppFontWeight.bodyRegular,
                      color: Colors.black,
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
                                'Keluar',
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
                                AppColors.primary500,
                              ),
                            ),
                            onPressed: () {
                              context
                                  .read<DashboardProvider>()
                                  .setSelectedIndex(context, 3);

                              Navigator.pop(context);
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 12),
                              child: Row(
                                children: [
                                  Icon(
                                    FeatherIcons.calendar,
                                    color: AppColors.primary200,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Text(
                                      'Riwayat',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight:
                                            AppFontWeight.actionSemiBold,
                                        fontSize: AppFontSize.actionMedium,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
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
      });
    },
  );
}
