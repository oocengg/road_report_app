import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/colors.dart';

class HistorySelesaiLoading extends StatelessWidget {
  const HistorySelesaiLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 24,
        ),
        Shimmer.fromColors(
          baseColor: AppColors.baseShimmerColor,
          highlightColor: AppColors.highlightShimmerColor,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 21,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: AppColors.neutral300,
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Shimmer.fromColors(
          baseColor: AppColors.baseShimmerColor,
          highlightColor: AppColors.highlightShimmerColor,
          child: Container(
            width: double.infinity,
            height: 21,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: AppColors.neutral300,
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Shimmer.fromColors(
          baseColor: AppColors.baseShimmerColor,
          highlightColor: AppColors.highlightShimmerColor,
          child: Container(
            width: double.infinity,
            height: 48,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: AppColors.neutral300,
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Shimmer.fromColors(
          baseColor: AppColors.baseShimmerColor,
          highlightColor: AppColors.highlightShimmerColor,
          child: Container(
            width: double.infinity,
            height: 48,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: AppColors.neutral300,
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
        )
      ],
    );
  }
}
