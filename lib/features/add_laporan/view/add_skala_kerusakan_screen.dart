// ----------------------------------------- AI Info
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dio/dio.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mobileapp_roadreport/core/state/finite_state.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/core/widgets/modals/pilih_jenis_kerusakan_modal.dart';
import 'package:mobileapp_roadreport/features/add_laporan/provider/add_laporan_provider.dart';

class AddSkalaKerusakan extends StatefulWidget {
  final String idPolyline;
  final String namaJalan;
  const AddSkalaKerusakan(
      {super.key, required this.idPolyline, required this.namaJalan});

  @override
  State<AddSkalaKerusakan> createState() => _AddSkalaKerusakanState();
}

class _AddSkalaKerusakanState extends State<AddSkalaKerusakan> {
  @override
  void initState() {
    context.read<AddLaporanProvider>().jenisKerusakan = '';
    context.read<AddLaporanProvider>().tipeKerusakan = '';
    // ----------------------------------------- AI Info
    context.read<AddLaporanProvider>().buah = '';
    context.read<AddLaporanProvider>().cancelToken = CancelToken();
    context.read<AddLaporanProvider>().stateAI = MyState.initial;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddLaporanProvider>(
        builder: (context, addLaporanProvider, _) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Laporkan Jalan',
            style: TextStyle(
              fontWeight: AppFontWeight.bodySemiBold,
              fontSize: AppFontSize.bodyMedium,
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColors.primary500,

          // ----------------------------------------- AI Info
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              addLaporanProvider.cancelToken
                  .cancel("Request was cancelled by user!");
            },
            icon: const Icon(
              FeatherIcons.arrowLeft,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    // Container(
                    //   padding: const EdgeInsets.all(16),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
                    //     color: AppColors.neutral50,
                    //     border: Border.all(
                    //       color: AppColors.neutral200,
                    //     ),
                    //   ),
                    //   child: const Row(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Icon(
                    //         FeatherIcons.fileText,
                    //         color: AppColors.primary500,
                    //         size: 24,
                    //       ),
                    //       SizedBox(
                    //         width: 16,
                    //       ),
                    //       Expanded(
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //               'Skala Kerusakan',
                    //               style: TextStyle(
                    //                 fontWeight: AppFontWeight.bodySemiBold,
                    //                 fontSize: AppFontSize.bodyMedium,
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               height: 4,
                    //             ),
                    //             Text(
                    //               'Silahkan pilih jenis kerusakan dan Tingkat Kerusakan jalan saat ini.',
                    //               style: TextStyle(
                    //                 fontWeight: AppFontWeight.bodyRegular,
                    //                 fontSize: AppFontSize.bodySmall,
                    //                 color: AppColors.neutral600,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),

                    // ----------------------------------------- AI Info
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.neutral50,
                        border: Border.all(
                          color: AppColors.neutral200,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addLaporanProvider.stateAI == MyState.loading
                              ? LottieBuilder.asset(
                                  'assets/lotties/gear.json',
                                  width: 40,
                                  height: 40,
                                )
                              : addLaporanProvider.stateAI == MyState.loaded
                                  ? const Icon(
                                      FeatherIcons.check,
                                      color: AppColors.primary500,
                                      size: 24,
                                    )
                                  : const Icon(
                                      FeatherIcons.fileText,
                                      color: AppColors.primary500,
                                      size: 24,
                                    ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                addLaporanProvider.stateAI == MyState.loading
                                    ? Row(
                                        children: <Widget>[
                                          const Text(
                                            'Proses validasi kerusakan',
                                            style: TextStyle(
                                              fontWeight:
                                                  AppFontWeight.bodySemiBold,
                                              fontSize: AppFontSize.bodyMedium,
                                            ),
                                          ),
                                          DefaultTextStyle(
                                            style: const TextStyle(
                                              fontWeight:
                                                  AppFontWeight.bodySemiBold,
                                              fontSize: AppFontSize.bodyMedium,
                                              color: Colors.black,
                                            ),
                                            textAlign: TextAlign.justify,
                                            child: AnimatedTextKit(
                                              animatedTexts: [
                                                TyperAnimatedText(
                                                  '...',
                                                  speed: const Duration(
                                                    milliseconds: 500,
                                                  ),
                                                ),
                                              ],
                                              isRepeatingAnimation: true,
                                              repeatForever: true,
                                              pause: const Duration(
                                                milliseconds: 1000,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : addLaporanProvider.stateAI ==
                                            MyState.loaded
                                        ? const Text(
                                            'Yey proses validasi selesai!',
                                            style: TextStyle(
                                              fontWeight:
                                                  AppFontWeight.bodySemiBold,
                                              fontSize: AppFontSize.bodyMedium,
                                            ),
                                          )
                                        : const Text(
                                            'Skala Kerusakan',
                                            style: TextStyle(
                                              fontWeight:
                                                  AppFontWeight.bodySemiBold,
                                              fontSize: AppFontSize.bodyMedium,
                                            ),
                                          ),
                                const SizedBox(
                                  height: 4,
                                ),
                                addLaporanProvider.stateAI == MyState.loading
                                    ? const Text(
                                        'Tunggu sebentar lagi, dalam proses validasi gambar kerusakan jalan.',
                                        style: TextStyle(
                                          fontWeight: AppFontWeight.bodyRegular,
                                          fontSize: AppFontSize.bodySmall,
                                          color: AppColors.neutral600,
                                        ),
                                      )
                                    : addLaporanProvider.stateAI ==
                                            MyState.loaded
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Klik tombol dibawah untuk mengisi otomatis jenis dan tingkat kerusakan.',
                                                style: TextStyle(
                                                  fontWeight:
                                                      AppFontWeight.bodyRegular,
                                                  fontSize:
                                                      AppFontSize.bodySmall,
                                                  color: AppColors.neutral600,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              Text(
                                                '- Jenis Kerusakan : ${addLaporanProvider.jenisRandom}',
                                                style: const TextStyle(
                                                  fontWeight:
                                                      AppFontWeight.bodyRegular,
                                                  fontSize:
                                                      AppFontSize.bodySmall,
                                                  color: AppColors.neutral600,
                                                ),
                                              ),
                                              Text(
                                                '- Tingkat Kerusakan : ${addLaporanProvider.tingkatRandom}',
                                                style: const TextStyle(
                                                  fontWeight:
                                                      AppFontWeight.bodyRegular,
                                                  fontSize:
                                                      AppFontSize.bodySmall,
                                                  color: AppColors.neutral600,
                                                ),
                                              ),
                                            ],
                                          )
                                        : const Text(
                                            'Silahkan pilih jenis kerusakan dan tipe kerusakan jalan saat ini atau gunakan AI untuk validasi gambar otomatis.',
                                            style: TextStyle(
                                              fontWeight:
                                                  AppFontWeight.bodyRegular,
                                              fontSize: AppFontSize.bodySmall,
                                              color: AppColors.neutral600,
                                            ),
                                          ),
                                const SizedBox(
                                  height: 4,
                                ),
                                addLaporanProvider.stateAI == MyState.loading
                                    ? const SizedBox.shrink()
                                    : addLaporanProvider.stateAI ==
                                            MyState.loaded
                                        ? TextButton(
                                            onPressed: () {
                                              addLaporanProvider
                                                  .setSkalaKerusakan();
                                            },
                                            style: const ButtonStyle(
                                              padding: MaterialStatePropertyAll(
                                                EdgeInsets.all(
                                                  0,
                                                ),
                                              ),
                                            ),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 8,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Colors.transparent,
                                                border: Border.all(
                                                  color: AppColors.primary500,
                                                ),
                                              ),
                                              child: const Text(
                                                'Isi Otomatis',
                                              ),
                                            ),
                                          )
                                        : TextButton(
                                            onPressed: () {
                                              addLaporanProvider
                                                  .checkAIKerusakan();
                                            },
                                            style: const ButtonStyle(
                                              padding: MaterialStatePropertyAll(
                                                EdgeInsets.all(
                                                  0,
                                                ),
                                              ),
                                            ),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 8,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Colors.transparent,
                                                border: Border.all(
                                                  color: AppColors.primary500,
                                                ),
                                              ),
                                              child: const Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    FeatherIcons.loader,
                                                    size: 16,
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    'Gunakan AI',
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    // Jenis Kerusakan Section
                    const Text(
                      'Jenis Kerusakan',
                      style: TextStyle(
                        fontWeight: AppFontWeight.bodyRegular,
                        fontSize: AppFontSize.bodyMedium,
                      ),
                    ),

                    const SizedBox(
                      height: 4,
                    ),
                    GestureDetector(
                      onTap: () {
                        showPiihJenisKerusakanModal(context, 0);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: addLaporanProvider.jenisKerusakan == ''
                                ? AppColors.neutral300
                                : AppColors.primary500,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              addLaporanProvider.jenisKerusakan == ''
                                  ? 'Pilih Disini..'
                                  : addLaporanProvider.jenisKerusakan,
                              style: const TextStyle(
                                fontWeight: AppFontWeight.bodyRegular,
                                fontSize: AppFontSize.bodyMedium,
                                color: AppColors.neutral600,
                              ),
                            ),
                            const Icon(
                              FeatherIcons.chevronDown,
                              color: AppColors.neutral600,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    // Tingkat Kerusakan Section
                    const Text(
                      'Tingkat Kerusakan',
                      style: TextStyle(
                        fontWeight: AppFontWeight.bodyRegular,
                        fontSize: AppFontSize.bodyMedium,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    GestureDetector(
                      onTap: () {
                        showPiihJenisKerusakanModal(context, 1);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: addLaporanProvider.tipeKerusakan == ''
                                ? AppColors.neutral300
                                : AppColors.primary500,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              addLaporanProvider.tipeKerusakan == ''
                                  ? 'Pilih Disini..'
                                  : addLaporanProvider.tipeKerusakan,
                              style: const TextStyle(
                                fontWeight: AppFontWeight.bodyRegular,
                                fontSize: AppFontSize.bodyMedium,
                                color: AppColors.neutral600,
                              ),
                            ),
                            const Icon(
                              FeatherIcons.chevronDown,
                              color: AppColors.neutral600,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    backgroundColor: MaterialStatePropertyAll(
                      addLaporanProvider.jenisKerusakan == '' ||
                              addLaporanProvider.tipeKerusakan == ''
                          ? AppColors.primary50
                          : AppColors.primary500,
                    ),
                  ),
                  onPressed: addLaporanProvider.jenisKerusakan == '' ||
                          addLaporanProvider.tipeKerusakan == ''
                      ? null
                      : () {
                          Navigator.pop(context);
                          Navigator.pop(context);

                          addLaporanProvider
                              .addSelectedPolyline(widget.idPolyline);

                          // ----------------------------------------- AI Info
                          // addLaporanProvider.cancelToken
                          //     .cancel("Request was cancelled by user!");

                          addLaporanProvider.addSegmen(
                            widget.idPolyline,
                            widget.namaJalan,
                            addLaporanProvider.jenisKerusakan,
                            addLaporanProvider.tipeKerusakan,
                            addLaporanProvider.image,
                            addLaporanProvider.fotoModel,
                          );
                        },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Kirim',
                      style: TextStyle(
                        fontWeight: AppFontWeight.actionSemiBold,
                        fontSize: AppFontSize.actionLarge,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
