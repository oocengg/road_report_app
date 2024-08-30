import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/colors.dart';

class HistoryPerbaikanLoading extends StatelessWidget {
  const HistoryPerbaikanLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                  const SizedBox(
                    height: 20.0,
                  ),
                  Shimmer.fromColors(
                    baseColor: AppColors.baseShimmerColor,
                    highlightColor: AppColors.highlightShimmerColor,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 172,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: AppColors.neutral300,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Shimmer.fromColors(
                    baseColor: AppColors.baseShimmerColor,
                    highlightColor: AppColors.highlightShimmerColor,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 70,
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
              height: 42.0,
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
          ],
        )
      ],
    );
  }
}
