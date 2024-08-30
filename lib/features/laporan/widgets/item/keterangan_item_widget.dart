import 'package:flutter/material.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';

class KeteranganItemWidget extends StatelessWidget {
  final Color color;
  final String text;
  const KeteranganItemWidget({
    super.key,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: AppFontWeight.overlineRegular,
              fontSize: AppFontSize.overlineSmall,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
