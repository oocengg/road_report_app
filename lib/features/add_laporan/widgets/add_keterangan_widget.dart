import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/core/widgets/modals/selesai_modal.dart';
import 'package:mobileapp_roadreport/features/add_laporan/provider/add_laporan_provider.dart';
import 'package:mobileapp_roadreport/features/add_laporan/view/detail_segmen_screen.dart';
import 'package:mobileapp_roadreport/features/add_laporan/widgets/custom_textformfield.dart';

class AddKeteranganWidget extends StatefulWidget {
  final CarouselController carouselController;
  const AddKeteranganWidget({
    super.key,
    required this.carouselController,
  });

  @override
  State<AddKeteranganWidget> createState() => _AddKeteranganWidgetState();
}

class _AddKeteranganWidgetState extends State<AddKeteranganWidget> {
  @override
  void initState() {
    context.read<AddLaporanProvider>().image.clear();
    context.read<AddLaporanProvider>().fotoModel.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddLaporanProvider>(
      builder: (context, addLaporanProvider, _) {
        return Form(
          key: addLaporanProvider.formKey,
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
                            addLaporanProvider.validateKeterangan(value),
                        controller: addLaporanProvider.keteranganController,
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
                        itemCount: addLaporanProvider.listSegmen.length,
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
                                      DetailSegmenScreen(
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
                    if (addLaporanProvider.formKey.currentState!.validate()) {
                      showSelesaiModal(context);
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
