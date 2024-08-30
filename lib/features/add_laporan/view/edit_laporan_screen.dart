import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/core/widgets/modals/camera_modal.dart';
import 'package:mobileapp_roadreport/core/widgets/modals/delete_image_modal.dart';
// import 'package:mobileapp_roadreport/core/widgets/modals/pilih_jenis_kerusakan_modal.dart';
import 'package:mobileapp_roadreport/features/add_laporan/provider/add_laporan_provider.dart';

class EditLaporanScreen extends StatefulWidget {
  final int index;
  const EditLaporanScreen({super.key, required this.index});

  @override
  State<EditLaporanScreen> createState() => _EditLaporanScreenState();
}

class _EditLaporanScreenState extends State<EditLaporanScreen> {
  @override
  void initState() {
    context.read<AddLaporanProvider>().tipeKerusakan = context
        .read<AddLaporanProvider>()
        .listSegmen[widget.index]
        .tipeKerusakan!;
    context.read<AddLaporanProvider>().jenisKerusakan = context
        .read<AddLaporanProvider>()
        .listSegmen[widget.index]
        .jenisKerusakan!;
    context.read<AddLaporanProvider>().image.clear();
    context.read<AddLaporanProvider>().image.addAll(
        context.read<AddLaporanProvider>().listSegmen[widget.index].foto!);
    context.read<AddLaporanProvider>().fotoModel.clear();
    context.read<AddLaporanProvider>().fotoModel.addAll(
        context.read<AddLaporanProvider>().listSegmen[widget.index].fotoModel!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Laporan',
          style: TextStyle(
            fontWeight: AppFontWeight.bodySemiBold,
            fontSize: AppFontSize.bodyMedium,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primary500,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        child: Consumer<AddLaporanProvider>(
          builder: (context, addLaporanProvider, _) {
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      item('Nama Segmen', 'Segmen Jalan ${widget.index + 1}'),
                      const SizedBox(
                        height: 16,
                      ),

                      // // Jenis Kerusakan Section
                      // item('Jenis Kerusakan', ''),
                      // const SizedBox(
                      //   height: 16,
                      // ),
                      // GestureDetector(
                      //   onTap: () {
                      //     showPiihJenisKerusakanModal(context, 0);
                      //   },
                      //   child: Container(
                      //     padding: const EdgeInsets.symmetric(
                      //       horizontal: 16,
                      //       vertical: 12,
                      //     ),
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(8),
                      //       border: Border.all(
                      //         color: addLaporanProvider.jenisKerusakan == ''
                      //             ? AppColors.neutral300
                      //             : AppColors.primary500,
                      //       ),
                      //     ),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Text(
                      //           addLaporanProvider.jenisKerusakan == ''
                      //               ? 'Pilih Disini..'
                      //               : addLaporanProvider.jenisKerusakan,
                      //           style: const TextStyle(
                      //             fontWeight: AppFontWeight.bodyRegular,
                      //             fontSize: AppFontSize.bodyMedium,
                      //             color: AppColors.neutral600,
                      //           ),
                      //         ),
                      //         const Icon(
                      //           FeatherIcons.chevronDown,
                      //           color: AppColors.neutral600,
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),

                      // const SizedBox(
                      //   height: 16,
                      // ),

                      // // Tingkat Kerusakan Section
                      // item('Tingkat Kerusakan', ''),
                      // const SizedBox(
                      //   height: 16,
                      // ),
                      // GestureDetector(
                      //   onTap: () {
                      //     showPiihJenisKerusakanModal(context, 1);
                      //   },
                      //   child: Container(
                      //     padding: const EdgeInsets.symmetric(
                      //       horizontal: 16,
                      //       vertical: 12,
                      //     ),
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(8),
                      //       border: Border.all(
                      //         color: addLaporanProvider.tipeKerusakan == ''
                      //             ? AppColors.neutral300
                      //             : AppColors.primary500,
                      //       ),
                      //     ),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Text(
                      //           addLaporanProvider.tipeKerusakan == ''
                      //               ? 'Pilih Disini..'
                      //               : addLaporanProvider.tipeKerusakan,
                      //           style: const TextStyle(
                      //             fontWeight: AppFontWeight.bodyRegular,
                      //             fontSize: AppFontSize.bodyMedium,
                      //             color: AppColors.neutral600,
                      //           ),
                      //         ),
                      //         const Icon(
                      //           FeatherIcons.chevronDown,
                      //           color: AppColors.neutral600,
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),

                      // const SizedBox(
                      //   height: 16,
                      // ),

                      item('Foto Keadaan Jalan', ''),
                      const SizedBox(
                        height: 12,
                      ),

                      addLaporanProvider.image.isEmpty
                          ? GestureDetector(
                              onTap: () {
                                showCameraModal(context);
                              },
                              child: DottedBorder(
                                padding: const EdgeInsets.all(0),
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(8),
                                color: addLaporanProvider.image.isNotEmpty
                                    ? Colors.transparent
                                    : Colors.black.withOpacity(0.4),
                                child: const SizedBox(
                                  height: 100,
                                  width: double.infinity,
                                  child:
                                      Center(child: Icon(FeatherIcons.camera)),
                                ),
                              ),
                            )
                          : SizedBox(
                              height: 100,
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: addLaporanProvider.image.length + 1,
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    width: 12,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  if (index ==
                                      addLaporanProvider.image.length) {
                                    return GestureDetector(
                                      onTap: () {
                                        showCameraModal(context);
                                      },
                                      child: DottedBorder(
                                        padding: const EdgeInsets.all(0),
                                        borderType: BorderType.RRect,
                                        radius: const Radius.circular(8),
                                        color: Colors.black.withOpacity(0.4),
                                        child: const SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: Icon(FeatherIcons.camera),
                                        ),
                                      ),
                                    );
                                  } else {
                                    final image =
                                        addLaporanProvider.image[index];
                                    return Stack(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            _showFullScreenImage(
                                              context,
                                              image,
                                              addLaporanProvider,
                                              index,
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.file(
                                              width: 100,
                                              height: 100,
                                              File(image),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 8,
                                          right: 8,
                                          child: GestureDetector(
                                            onTap: () {
                                              showDeleteImageModal(
                                                context,
                                                image,
                                                addLaporanProvider,
                                                index,
                                                false,
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(
                                                    0.5), // Ganti dengan warna latar belakang yang diinginkan
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(4.0),
                                                child: Icon(
                                                  FeatherIcons.trash2,
                                                  color: AppColors.error500,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ),
                      const SizedBox(
                        height: 16,
                      ),
                      item(
                        'Alamat',
                        addLaporanProvider
                                        .listSegmen[widget.index].namaJalan! ==
                                    'null' ||
                                addLaporanProvider
                                        .listSegmen[widget.index].namaJalan ==
                                    null
                            ? '-'
                            : addLaporanProvider
                                .listSegmen[widget.index].namaJalan!,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
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
                      backgroundColor: const MaterialStatePropertyAll(
                        AppColors.primary50,
                      ),
                    ),
                    onPressed: addLaporanProvider.image.isEmpty
                        ? null
                        : () {
                            addLaporanProvider.editLaporan(widget.index);

                            Navigator.pop(context);
                          },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Selesai',
                        style: TextStyle(
                          fontWeight: AppFontWeight.actionSemiBold,
                          fontSize: AppFontSize.actionLarge,
                          color: addLaporanProvider.image.isEmpty
                              ? AppColors.primary200
                              : AppColors.primary500,
                          letterSpacing: 0.75,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showFullScreenImage(BuildContext context, image,
      AddLaporanProvider addLaporanProvider, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          backgroundColor: Colors.transparent,
          content: SizedBox(
            width: 400,
            height: MediaQuery.of(context).size.width * 0.8,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    File(image),
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors
                            .black12, // Ganti dengan warna latar belakang yang diinginkan
                        shape: BoxShape.circle,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: GestureDetector(
                    onTap: () {
                      showDeleteImageModal(
                        context,
                        image,
                        addLaporanProvider,
                        index,
                        true,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(
                            0.5), // Ganti dengan warna latar belakang yang diinginkan
                        shape: BoxShape.circle,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          FeatherIcons.trash2,
                          color: AppColors.error500,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget item(String title, String value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Flexible(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: AppFontSize.bodyMedium,
            fontWeight: AppFontWeight.bodySemiBold,
          ),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      Flexible(
        child: Text(
          value,
          style: const TextStyle(
            fontSize: AppFontSize.bodyMedium,
            fontWeight: AppFontWeight.bodyRegular,
          ),
          textAlign: TextAlign.right,
        ),
      ),
    ],
  );
}
