import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
// import 'package:mobileapp_roadreport/features/home/widgets/item/informasi_item_widget.dart';

class InformasiWidget extends StatelessWidget {
  const InformasiWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                'Informasi',
                style: TextStyle(
                  fontWeight: AppFontWeight.bodySemiBold,
                  fontSize: AppFontSize.bodyMedium,
                ),
              ),
            ),
            Icon(
              FeatherIcons.arrowRight,
              size: 25,
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        // InformasiItemWidget(),
        // SizedBox(
        //   height: 12,
        // ),
        // InformasiItemWidget(),
        // SizedBox(
        //   height: 12,
        // ),
        // InformasiItemWidget(),
      ],
    );
  }
}
