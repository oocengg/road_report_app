import 'package:flutter/material.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';

class InformationItemWidget extends StatelessWidget {
  final String title;
  final String value;
  const InformationItemWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: AppFontSize.bodySmall,
            fontWeight: AppFontWeight.bodyRegular,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: AppFontSize.bodySmall,
              fontWeight: AppFontWeight.bodyRegular,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
