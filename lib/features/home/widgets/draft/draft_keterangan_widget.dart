import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mobileapp_roadreport/core/state/finite_state.dart';
import 'package:mobileapp_roadreport/features/dashboard/provider/dashboard_provider.dart';
import 'package:mobileapp_roadreport/features/home/provider/home_provider.dart';
import 'package:mobileapp_roadreport/features/home/widgets/draft/draft_detail_segmen_widget.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/features/add_laporan/widgets/custom_textformfield.dart';

class DraftKeteranganWidget extends StatefulWidget {
  final CarouselController carouselController;
  final int index;
  const DraftKeteranganWidget({
    super.key,
    required this.carouselController,
    required this.index,
  });

  @override
  State<DraftKeteranganWidget> createState() => _DraftKeteranganWidgetState();
}

class _DraftKeteranganWidgetState extends State<DraftKeteranganWidget> {
  @override
  void initState() {
    context.read<HomeProvider>().image.clear();
    context.read<HomeProvider>().fotoModel.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, _) {
        return Form(
          key: homeProvider.formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Text(
                        "Keterangan",
                        style: TextStyle(
                          fontWeight: AppFontWeight.bodySemiBold,
                          fontSize: AppFontSize.bodyMedium,
                          color: AppColors.neutral900,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: CustomTextFormField(
                        enable: true,
                        hint: 'Masukan keterangan laporan',
                        maxLines: 5,
                        textInputAction: TextInputAction.done,
                        validator: (value) =>
                            homeProvider.validateKeterangan(value),
                        controller: homeProvider.keteranganController,
                      ),
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Text(
                        "Detail Laporan",
                        style: TextStyle(
                          fontWeight: AppFontWeight.bodySemiBold,
                          fontSize: AppFontSize.bodyMedium,
                          color: AppColors.neutral900,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Divider(height: 0.5),
                    const SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(bottom: 16),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: homeProvider.listSegmen.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          height: 12,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return ElevatedButton(
                            style: ButtonStyle(
                              padding: const MaterialStatePropertyAll(
                                  EdgeInsets.all(12)),
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              backgroundColor: const MaterialStatePropertyAll(
                                AppColors.primary50,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (BuildContext context) =>
                                      DraftDetailSegmenWidget(
                                    index: index,
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    'Segmen Jalan ${index + 1}',
                                    style: const TextStyle(
                                      fontSize: AppFontSize.bodySmall,
                                      fontWeight: AppFontWeight.bodySemiBold,
                                      color: Colors.black,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  FeatherIcons.chevronRight,
                                  color: AppColors
                                      .neutral700, // Ganti dengan warna yang diinginkan
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                width: double.infinity,
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
                    if (homeProvider.formKey.currentState!.validate()) {
                      _showSelesaiModal(context, widget.index);
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Laporkan Sekarang',
                      style: TextStyle(
                        fontWeight: AppFontWeight.actionSemiBold,
                        fontSize: AppFontSize.actionLarge,
                        color: Colors.white,
                        letterSpacing: 0.75,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 26,
              ),
            ],
          ),
        );
      },
    );
  }
}

void _showSelesaiModal(BuildContext context, int index) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Consumer<HomeProvider>(builder: (context, homeProvider, _) {
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
                        'Info',
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
                    color: AppColors.primary50,
                  ),
                  child: const Icon(
                    FeatherIcons.info,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'Yakin, Sudah Benar?',
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
                    'Periksa kembali data Anda sebelum dikirimkan, jika sudah benar silahkan tekan tombol “Kirim”',
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
                  child: homeProvider.state == MyState.loading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary500,
                          ),
                        )
                      : Row(
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
                                    backgroundColor:
                                        const MaterialStatePropertyAll(
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
                                      'Batal',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight:
                                            AppFontWeight.actionSemiBold,
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
                                    backgroundColor:
                                        const MaterialStatePropertyAll(
                                      AppColors.primary500,
                                    ),
                                  ),
                                  onPressed: () async {
                                    bool isDone = await homeProvider.addLaporan(
                                        context: context, index: index);
                                    if (context.mounted) {
                                      if (isDone) {
                                        context
                                            .read<DashboardProvider>()
                                            .setSelectedIndex(context, 3);
                                      }
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 12),
                                    child: Text(
                                      'Kirim',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight:
                                            AppFontWeight.actionSemiBold,
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
      });
    },
  );
}
