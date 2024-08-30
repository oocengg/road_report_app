import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/colors.dart';

class DetailHistoryHeaderLoading extends StatelessWidget {
  const DetailHistoryHeaderLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16.0,
        ),
        Shimmer.fromColors(
          baseColor: AppColors.baseShimmerColor,
          highlightColor: AppColors.highlightShimmerColor,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: 24,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: AppColors.neutral300,
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: DottedLine(
                lineThickness: 0,
                dashColor: AppColors.primary500,
              ),
            ),
            Column(
              children: [
                Shimmer.fromColors(
                  baseColor: AppColors.baseShimmerColor,
                  highlightColor: AppColors.highlightShimmerColor,
                  child: Container(
                    width: 12,
                    height: 12,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: AppColors.neutral300,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Shimmer.fromColors(
                  baseColor: AppColors.baseShimmerColor,
                  highlightColor: AppColors.highlightShimmerColor,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: 32,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: AppColors.neutral300,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                ),
              ],
            ),
            const Expanded(
              child: DottedLine(
                lineThickness: 0,
                dashColor: AppColors.primary500,
              ),
            ),
            Column(
              children: [
                Shimmer.fromColors(
                  baseColor: AppColors.baseShimmerColor,
                  highlightColor: AppColors.highlightShimmerColor,
                  child: Container(
                    width: 12,
                    height: 12,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: AppColors.neutral300,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Shimmer.fromColors(
                  baseColor: AppColors.baseShimmerColor,
                  highlightColor: AppColors.highlightShimmerColor,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: 32,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: AppColors.neutral300,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                )
              ],
            ),
            const Expanded(
              child: DottedLine(
                lineThickness: 0,
                dashColor: AppColors.primary500,
              ),
            ),
            Column(
              children: [
                Shimmer.fromColors(
                  baseColor: AppColors.baseShimmerColor,
                  highlightColor: AppColors.highlightShimmerColor,
                  child: Container(
                    width: 12,
                    height: 12,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: AppColors.neutral300,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Shimmer.fromColors(
                  baseColor: AppColors.baseShimmerColor,
                  highlightColor: AppColors.highlightShimmerColor,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: 16,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: AppColors.neutral300,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                )
              ],
            ),
            const Expanded(
              child: DottedLine(
                lineThickness: 0,
                dashColor: AppColors.primary500,
              ),
            ),
            Column(
              children: [
                Shimmer.fromColors(
                  baseColor: AppColors.baseShimmerColor,
                  highlightColor: AppColors.highlightShimmerColor,
                  child: Container(
                    width: 12,
                    height: 12,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: AppColors.neutral300,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Shimmer.fromColors(
                  baseColor: AppColors.baseShimmerColor,
                  highlightColor: AppColors.highlightShimmerColor,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: 16,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: AppColors.neutral300,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                )
              ],
            ),
            const Expanded(
              child: DottedLine(
                lineThickness: 0,
                dashColor: AppColors.primary500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
