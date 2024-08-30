import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';

// ignore: unused_element
void showAddSegmenModal(
    BuildContext context, CarouselController carouselController) {
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
                height: 18,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text(
                  'Tambahkan segmen jalan lagi bisa klik tombol tambah “Segmen Jalan”',
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
                              'Segmen\nJalan',
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
                            carouselController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );

                            Navigator.pop(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Text(
                              'Kirim ',
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
