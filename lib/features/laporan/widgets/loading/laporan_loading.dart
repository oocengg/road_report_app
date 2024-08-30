import 'package:flutter/material.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:shimmer/shimmer.dart';

class LaporanLoading extends StatelessWidget {
  const LaporanLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.baseShimmerColor,
      highlightColor: AppColors.highlightShimmerColor,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: AppColors.neutral300,
          borderRadius: BorderRadius.only(),
        ),
      ),
    );
  }
}
