import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';

import '../../../core/constants/colors.dart';

class StepperWidget extends StatefulWidget {
  final VoidCallback callback;
  final double garis;
  final double garis1;
  final String title;
  final int index;
  final int currentIndex;
  const StepperWidget({
    super.key,
    required this.title,
    required this.garis,
    required this.garis1,
    required this.callback,
    required this.index,
    required this.currentIndex,
  });

  @override
  State<StepperWidget> createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DottedLine(
                  lineThickness: widget.garis,
                  dashColor: AppColors.primary500,
                ),
              ),
              GestureDetector(
                onTap: widget.callback,
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  decoration: BoxDecoration(
                    color: widget.index <= widget.currentIndex
                        ? AppColors.primary500
                        : AppColors.primary200,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ),
              Expanded(
                child: DottedLine(
                  lineThickness: widget.garis1,
                  dashColor: AppColors.primary500,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            widget.title,
            style: TextStyle(
                fontSize: AppFontSize.actionSmall,
                fontWeight: AppFontWeight.actionSemiBold,
                color: widget.index <= widget.currentIndex
                    ? AppColors.primary500
                    : AppColors.primary200),
          )
        ],
      ),
    );
  }
}
