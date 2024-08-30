import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/features/home/provider/home_provider.dart';
import 'package:mobileapp_roadreport/features/home/widgets/item/informasi_item_widget.dart';
import 'package:provider/provider.dart';

class DraftScreen extends StatelessWidget {
  const DraftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Draft Foto',
          style: TextStyle(
            fontWeight: AppFontWeight.bodySemiBold,
            fontSize: AppFontSize.bodyMedium,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primary500,
      ),
      body: Consumer<HomeProvider>(builder: (context, homeProvider, _) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.warning50),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        FeatherIcons.info,
                        color: AppColors.warning500,
                        size: 16,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Flexible(
                        child: Text(
                          'Setiap foto akan tersimpan dalam draft dalam waktu 7 hari.',
                          style: TextStyle(
                            fontSize: AppFontSize.caption,
                            fontWeight: AppFontWeight.captionRegular,
                            color: AppColors.neutral700,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 320,
                  ),
                  itemCount: homeProvider.draft.length,
                  itemBuilder: (context, index) {
                    return InformasiItemWidget(
                      index: index,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
