import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';

class HeadlineWidget extends StatefulWidget {
  final String image;
  final String nama;
  final String email;
  const HeadlineWidget(
      {super.key,
      required this.image,
      required this.nama,
      required this.email});

  @override
  State<HeadlineWidget> createState() => _HeadlineWidgetState();
}

class _HeadlineWidgetState extends State<HeadlineWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.image != '-'
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    widget.image,
                    height: 64,
                    width: 64,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    color: AppColors.primary500,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    widget.nama.isNotEmpty ? widget.nama[0].toUpperCase() : '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppFontSize.heading2,
                      color: Colors.white,
                    ),
                  ),
                ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'Halo, ${widget.nama}',
            style: const TextStyle(
                fontSize: AppFontSize.heading4,
                fontWeight: AppFontWeight.headingSemiBold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            width: 280,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.neutral50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  FeatherIcons.mail,
                ),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: Text(
                    widget.email,
                    style: const TextStyle(
                      fontSize: AppFontSize.bodySmall,
                      fontWeight: AppFontWeight.bodyRegular,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
