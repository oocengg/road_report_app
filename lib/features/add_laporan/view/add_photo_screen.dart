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
import 'package:mobileapp_roadreport/features/add_laporan/provider/add_laporan_provider.dart';
// import 'package:mobileapp_roadreport/features/add_laporan/view/add_skala_kerusakan_screen.dart';

class AddPhotoScreen extends StatefulWidget {
  final String idPolyline;
  final String namaJalan;
  const AddPhotoScreen(
      {super.key, required this.idPolyline, required this.namaJalan});

  @override
  State<AddPhotoScreen> createState() => _AddPhotoScreenState();
}

class _AddPhotoScreenState extends State<AddPhotoScreen> {
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
              Expanded(
                child: DottedBorder(
                  padding: const EdgeInsets.all(0),
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(8),
                  color: addLaporanProvider.image.isNotEmpty
                      ? Colors.transparent
                      : Colors.black.withOpacity(0.4),
                  child: SizedBox(
                    width: double.infinity, // Total height of 3 items + spacing
                    child: addLaporanProvider.image.isEmpty
                        ? GestureDetector(
                            onTap: () {
                              showCameraModal(context);
                            },
                            child: const Center(
                              child: Icon(
                                FeatherIcons.camera,
                                size: 50,
                              ),
                            ),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: addLaporanProvider.image.length + 1,
                            itemBuilder: (context, index) {
                              if (index == addLaporanProvider.image.length) {
                                return Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showCameraModal(context);
                                      },
                                      child: DottedBorder(
                                        padding: const EdgeInsets.all(0),
                                        borderType: BorderType.RRect,
                                        radius: const Radius.circular(10),
                                        child: SizedBox(
                                          height: 110,
                                          width: 110,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: const Icon(
                                                  FeatherIcons.camera)),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                final image = addLaporanProvider.image[index];
                                return Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () => _showFullScreenImage(
                                        context,
                                        image,
                                        addLaporanProvider,
                                        index,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          width: 110,
                                          height: 110,
                                          File(image),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 8,
                                      right: 15,
                                      child: GestureDetector(
                                        onTap: () {
                                          showDeleteImageModal(context, image,
                                              addLaporanProvider, index, false);
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
                ),
              ),
              const SizedBox(
                height: 16,
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
                      addLaporanProvider.image.isEmpty
                          ? AppColors.primary50
                          : AppColors.primary500,
                    ),
                  ),
                  onPressed: addLaporanProvider.image.isEmpty
                      ? null
                      : () {
                          // Skala Kerusakan
                          // Navigator.of(context).push(
                          //   CupertinoPageRoute(
                          //     builder: (BuildContext context) =>
                          //         AddSkalaKerusakan(
                          //       idPolyline: widget.idPolyline,
                          //       namaJalan: widget.namaJalan,
                          //     ),
                          //   ),
                          // );

                          Navigator.pop(context);

                          addLaporanProvider
                              .addSelectedPolyline(widget.idPolyline);

                          addLaporanProvider.addSegmen(
                            widget.idPolyline,
                            widget.namaJalan,
                            '-',
                            '-',
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
