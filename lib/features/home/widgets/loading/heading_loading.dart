import 'package:flutter/material.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:shimmer/shimmer.dart';

class HeadingLoading extends StatelessWidget {
  const HeadingLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Shimmer.fromColors(
            baseColor: AppColors.baseShimmerColor,
            highlightColor: AppColors.highlightShimmerColor,
            child: Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColors.neutral200,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Shimmer.fromColors(
            baseColor: AppColors.baseShimmerColor,
            highlightColor: AppColors.highlightShimmerColor,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: 32,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: const Color(0xFFF1EFEF),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
