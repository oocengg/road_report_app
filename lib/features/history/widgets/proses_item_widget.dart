import 'package:flutter/material.dart';

import '../../../core/constants/font_size.dart';
import '../../../core/constants/font_weigth.dart';

class ProsesItemWidget extends StatelessWidget {
  final String title;
  final String body;
  const ProsesItemWidget({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: AppFontSize.bodySmall,
              fontWeight: AppFontWeight.bodyRegular,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              body,
              style: const TextStyle(
                fontSize: AppFontSize.bodySmall,
                fontWeight: AppFontWeight.bodyRegular,
              ),
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
    );
  }
}
