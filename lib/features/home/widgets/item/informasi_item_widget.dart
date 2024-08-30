import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/features/home/provider/home_provider.dart';
import 'package:mobileapp_roadreport/features/home/view/add_draft_laporan_screen.dart';
import 'package:provider/provider.dart';

class InformasiItemWidget extends StatelessWidget {
  final int index;
  const InformasiItemWidget({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, _) {
      return Container(
        width: 218,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 3,
              offset: const Offset(0, 1),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 2,
              offset: const Offset(0, 1),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 218,
              height: 127,
              decoration: const BoxDecoration(
                color: AppColors.neutral300,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Image.file(
                  File(provider.draft[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        FeatherIcons.mapPin,
                        size: 16,
                        color: AppColors.neutral600,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: FittedBox(
                          child: Text(
                            "${provider.lat[index]}, ${provider.lng[index]}",
                            style: const TextStyle(
                              fontSize: AppFontSize.caption,
                              fontWeight: AppFontWeight.captionRegular,
                              color: AppColors.neutral600,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Draft Foto ${index + 1}',
                    style: const TextStyle(
                      fontSize: AppFontSize.bodyMedium,
                      fontWeight: AppFontWeight.bodyBold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    'Lengkapi laporan kamu sekarang.',
                    style: TextStyle(
                      fontSize: AppFontSize.bodySmall,
                      fontWeight: AppFontWeight.bodyRegular,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          _onClosePage(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.error500,
                          ),
                          child: const Icon(
                            FeatherIcons.trash2,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return AddDraftLaporanScreen(
                                    index: index,
                                  );
                                },
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(0.0, 1.0);
                                  const end = Offset.zero;
                                  const curve = Curves.ease;

                                  final tween = Tween(begin: begin, end: end);
                                  final curvedAnimation = CurvedAnimation(
                                    parent: animation,
                                    curve: curve,
                                  );

                                  return SlideTransition(
                                    position: tween.animate(curvedAnimation),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.primary500,
                            ),
                            child: const Text(
                              'Laporkan',
                              style: TextStyle(
                                fontSize: AppFontSize.bodySmall,
                                fontWeight: AppFontWeight.bodySemiBold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Future<bool> _onClosePage(BuildContext context) async {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    return (await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Hapus Foto Draft',
          ),
          content: const Text(
            'Tindakan ini akan menghapus foto draft yang belum dilaporkan, apakah kamu yakin ingin menghapus draft ini?',
            style: TextStyle(
              fontSize: AppFontSize.bodyMedium,
              fontWeight: AppFontWeight.bodyRegular,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text(
                'Batal',
                style: TextStyle(
                  color: AppColors.primary500,
                  fontSize: AppFontSize.bodySmall,
                  fontWeight: AppFontWeight.bodySemiBold,
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(
                  AppColors.error500,
                ),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              onPressed: () async {
                await homeProvider.deleteDraft(index);
                if (context.mounted) {
                  Navigator.of(context).pop(true);

                  if (homeProvider.draft.isEmpty) {
                    Navigator.pop(context);
                  }
                }
              },
              child: const Text(
                'Hapus',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: AppFontSize.bodySmall,
                  fontWeight: AppFontWeight.bodySemiBold,
                ),
              ),
            ),
          ],
        );
      },
    ));
  }
}
