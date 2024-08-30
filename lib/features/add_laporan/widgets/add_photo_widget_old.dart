import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/features/add_laporan/provider/add_laporan_provider.dart';

class AddPhotoWidgetOld extends StatelessWidget {
  final CarouselController carouselController;
  const AddPhotoWidgetOld({
    super.key,
    required this.carouselController,
  });

  @override
  Widget build(BuildContext context) {
    List<XFile> imagesFromPhone = [];
    return Consumer<AddLaporanProvider>(
        builder: (context, addLaporanProvider, _) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black.withOpacity(0.4),
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  width: double.infinity, // Total width of 3 items + spacing
                  height: MediaQuery.of(context).size.height -
                      400, // Total height of 3 items + spacing
                  child: addLaporanProvider.image.isEmpty
                      ? const Center(
                          child: Icon(
                            FeatherIcons.camera,
                            size: 50,
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
                          itemCount: addLaporanProvider.image.length,
                          itemBuilder: (context, index) {
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
                                  right: 20,
                                  child: GestureDetector(
                                    onTap: () {
                                      addLaporanProvider.removeImage(index);
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
                          },
                        ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.42,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          padding: const MaterialStatePropertyAll(
                            EdgeInsets.symmetric(horizontal: 23, vertical: 12),
                          ),
                          backgroundColor: const MaterialStatePropertyAll(
                              AppColors.primary50),
                        ),
                        onPressed: () async {
                          imagesFromPhone =
                              await ImagePicker().pickMultiImage();

                          if (imagesFromPhone.isNotEmpty) {
                            // addLaporanProvider.addListImage(imagesFromPhone);
                          }
                        },
                        child: const Text(
                          'Buka Galeri',
                          style: TextStyle(
                            fontWeight: AppFontWeight.actionSemiBold,
                            fontSize: AppFontSize.actionMedium,
                            color: AppColors.primary500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.42,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          padding: const MaterialStatePropertyAll(
                            EdgeInsets.symmetric(horizontal: 23, vertical: 12),
                          ),
                          backgroundColor: const MaterialStatePropertyAll(
                              AppColors.primary500),
                        ),
                        onPressed: () async {
                          final pickedFileCamera = await ImagePicker()
                              .pickImage(source: ImageSource.camera);
                          if (pickedFileCamera != null) {
                            // addLaporanProvider.addImage(pickedFileCamera);
                          }
                        },
                        child: const Text(
                          'Buka Kamera',
                          style: TextStyle(
                            fontWeight: AppFontWeight.actionSemiBold,
                            fontSize: AppFontSize.actionMedium,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 16.0, // Adjust the position as needed
              left: 0.0, // Adjust the position as needed
              right: 0.0, // Adjust the position as needed
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
                  carouselController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Lanjutkan',
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
      );
    });
  }
}
