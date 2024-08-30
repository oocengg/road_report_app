import 'package:flutter/material.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:shimmer/shimmer.dart';

class FaqLoading extends StatelessWidget {
  const FaqLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: AppColors.baseShimmerColor,
                highlightColor: AppColors.highlightShimmerColor,
                child: Container(
                  width: 40,
                  height: 40,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1EFEF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Shimmer.fromColors(
                baseColor: AppColors.baseShimmerColor,
                highlightColor: AppColors.highlightShimmerColor,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 40,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1EFEF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Shimmer.fromColors(
            baseColor: AppColors.baseShimmerColor,
            highlightColor: AppColors.highlightShimmerColor,
            child: Container(
              width: double.infinity,
              height: 40,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: const Color(0xFFF1EFEF),
                borderRadius: BorderRadius.circular(8),
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
              height: 40,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: const Color(0xFFF1EFEF),
                borderRadius: BorderRadius.circular(8),
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
              height: 40,
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
