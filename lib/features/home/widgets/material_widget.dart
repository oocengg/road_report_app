import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/features/home/widgets/item/material_item_widget.dart';

class MaterialWidget extends StatelessWidget {
  const MaterialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'Jumlah Material Saat Ini',
                  style: TextStyle(
                    fontSize: AppFontSize.bodyMedium,
                    fontWeight: AppFontWeight.bodySemiBold,
                  ),
                ),
              ),
              Icon(
                FeatherIcons.info,
                size: 20,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 60,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 10, // Replace with the actual number of items
            itemBuilder: (context, index) {
              return const MaterialItemWidget(
                title: 'Aspal',
                value: '500lt',
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 12),
          ),
        ),
      ],
    );
  }
}
