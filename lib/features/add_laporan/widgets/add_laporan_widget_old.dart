import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/core/widgets/modals/camera_modal.dart';
import 'package:mobileapp_roadreport/core/widgets/modals/pilih_jenis_kerusakan_modal.dart';
import 'package:mobileapp_roadreport/features/add_laporan/provider/add_laporan_provider.dart';

// Widget disatukan antara foto dan kerusakan

class AddLaporanWidget extends StatefulWidget {
  const AddLaporanWidget({super.key});

  @override
  State<AddLaporanWidget> createState() => _AddLaporanWidgetState();
}

class _AddLaporanWidgetState extends State<AddLaporanWidget> {
  @override
  void initState() {
    context.read<AddLaporanProvider>().jenisKerusakan = '';
    context.read<AddLaporanProvider>().tipeKerusakan = '';
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
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.neutral50,
                        border: Border.all(
                          color: AppColors.neutral200,
                        ),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            FeatherIcons.camera,
                            color: AppColors.primary500,
                            size: 24,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Skala Kerusakan',
                                  style: TextStyle(
                                    fontWeight: AppFontWeight.bodySemiBold,
                                    fontSize: AppFontSize.bodyMedium,
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Silahkan pilih jenis kerusakan dan Tingkat Kerusakan jalan saat ini.',
                                  style: TextStyle(
                                    fontWeight: AppFontWeight.bodyRegular,
                                    fontSize: AppFontSize.bodySmall,
                                    color: AppColors.neutral600,
                                  ),
                                ),
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
                    const SizedBox(
                      height: 16,
                    ),

                    // Image Section
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.neutral50,
                        border: Border.all(
                          color: AppColors.neutral200,
                        ),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            FeatherIcons.camera,
                            color: AppColors.primary500,
                            size: 24,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Foto Jalan',
                                  style: TextStyle(
                                    fontWeight: AppFontWeight.bodySemiBold,
                                    fontSize: AppFontSize.bodyMedium,
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Tambahkan beberapa foto keadaan jalan sekarang untuk mempermudah proses validasi oleh pengelola jalan.',
                                  style: TextStyle(
                                    fontWeight: AppFontWeight.bodyRegular,
                                    fontSize: AppFontSize.bodySmall,
                                    color: AppColors.neutral600,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    addLaporanProvider.image.isEmpty
                        ? GestureDetector(
                            onTap: () {
                              showCameraModal(context);
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.black,
                                ),
                              ),
                              child: const Icon(FeatherIcons.camera),
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
                                if (index == addLaporanProvider.image.length) {
                                  return GestureDetector(
                                    onTap: () {
                                      showCameraModal(context);
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                      ),
                                      child: const Icon(FeatherIcons.camera),
                                    ),
                                  );
                                } else {
                                  final image = addLaporanProvider.image[index];
                                  return Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          width: 100,
                                          height: 100,
                                          File(image),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: GestureDetector(
                                          onTap: () {
                                            addLaporanProvider
                                                .removeImage(index);
                                          },
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Colors
                                                  .black12, // Ganti dengan warna latar belakang yang diinginkan
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.all(2.0),
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.white,
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
