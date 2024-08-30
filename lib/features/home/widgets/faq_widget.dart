import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/core/state/finite_state.dart';
import 'package:mobileapp_roadreport/features/home/provider/faq_provider.dart';
import 'package:mobileapp_roadreport/features/home/widgets/item/faq_item_widget.dart';
import 'package:mobileapp_roadreport/features/home/widgets/loading/faq_loading.dart';

class FaqWidget extends StatelessWidget {
  const FaqWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FaqProvider>(
      builder: (context, faqProvider, _) {
        if (faqProvider.state == MyState.initial) {
          return const SizedBox.shrink();
        } else if (faqProvider.state == MyState.loading) {
          return const FaqLoading();
        } else if (faqProvider.state == MyState.loaded) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const Row(
                  children: [
                    Icon(
                      FeatherIcons.messageSquare,
                      size: 20,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      child: Text(
                        'Sering Ditanyakan?',
                        style: TextStyle(
                          fontWeight: AppFontWeight.bodySemiBold,
                          fontSize: AppFontSize.bodyMedium,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                faqProvider.faqData.isEmpty
                    ? const Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Icon(
                              FeatherIcons.helpCircle,
                              size: 20,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Maaf, Pertanyaan masih kosong.',
                              style: TextStyle(
                                fontSize: AppFontSize.bodySmall,
                                fontWeight: AppFontWeight.bodyRegular,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: faqProvider.faqData.length,
                        itemBuilder: (context, index) {
                          return FaqItemWidget(
                            title: faqProvider.faqData[index].title ?? '-',
                            data: faqProvider.faqData[index].desc ?? '-',
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                      ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text(
              'Maaf, Terjadi kesalahan saat mengambil data.',
            ),
          );
        }
      },
    );
  }
}
