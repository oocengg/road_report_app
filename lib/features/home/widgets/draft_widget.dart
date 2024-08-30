import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/features/home/provider/home_provider.dart';
import 'package:mobileapp_roadreport/features/home/view/draft_screen.dart';
import 'package:provider/provider.dart';

class DraftWidget extends StatelessWidget {
  const DraftWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, _) {
      return provider.isLoggedIn
          ? Container(
              padding: const EdgeInsets.all(12),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            const Icon(
                              FeatherIcons.folder,
                              size: 20,
                              color: AppColors.primary500,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Flexible(
                              child: Text(
                                'Draft Foto (${provider.draft.length.toString()}/5)',
                                style: const TextStyle(
                                  fontWeight: AppFontWeight.bodySemiBold,
                                  fontSize: AppFontSize.bodyMedium,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      provider.draft.isEmpty
                          ? const SizedBox.shrink()
                          : InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) => const DraftScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Lihat Semua',
                                style: TextStyle(
                                  fontSize: AppFontSize.caption,
                                  fontWeight: AppFontWeight.captionBold,
                                  color: AppColors.primary500,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width * 0.25,
                    child: provider.draft.isEmpty
                        ? const Center(
                            child: Text(
                            "Anda Belum Memiliki Draft",
                            style: TextStyle(
                              fontSize: AppFontSize.bodyMedium,
                              fontWeight: AppFontWeight.bodyRegular,
                            ),
                          ))
                        : ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                height:
                                    MediaQuery.of(context).size.width * 0.25,
                                decoration: const BoxDecoration(
                                  color: AppColors.neutral300,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  child: Image.file(
                                    File(provider.draft[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                width: 10,
                              );
                            },
                            itemCount: provider.draft.length),
                  )
                ],
              ),
            )
          : const SizedBox.shrink();
    });
  }
}
