import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/colors.dart';

class ProfileLoadingScreen extends StatelessWidget {
  const ProfileLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Shimmer.fromColors(
                      baseColor: AppColors.baseShimmerColor,
                      highlightColor: AppColors.highlightShimmerColor,
                      child: Container(
                        width: 64,
                        height: 64,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: AppColors.neutral300,
                          borderRadius: BorderRadius.circular(32),
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
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 24,
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
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 24,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: AppColors.neutral300,
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 59,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Shimmer.fromColors(
                    baseColor: AppColors.baseShimmerColor,
                    highlightColor: AppColors.highlightShimmerColor,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: 21,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: AppColors.neutral300,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: Shimmer.fromColors(
                      baseColor: AppColors.baseShimmerColor,
                      highlightColor: AppColors.highlightShimmerColor,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        height: 21,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: AppColors.neutral300,
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Shimmer.fromColors(
                    baseColor: AppColors.baseShimmerColor,
                    highlightColor: AppColors.highlightShimmerColor,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: 21,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: AppColors.neutral300,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: Shimmer.fromColors(
                      baseColor: AppColors.baseShimmerColor,
                      highlightColor: AppColors.highlightShimmerColor,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 21,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: AppColors.neutral300,
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Shimmer.fromColors(
                    baseColor: AppColors.baseShimmerColor,
                    highlightColor: AppColors.highlightShimmerColor,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: 21,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: AppColors.neutral300,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: Shimmer.fromColors(
                      baseColor: AppColors.baseShimmerColor,
                      highlightColor: AppColors.highlightShimmerColor,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: 21,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: AppColors.neutral300,
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
