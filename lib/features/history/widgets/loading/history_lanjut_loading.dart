import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/colors.dart';

class HistoryLanjutLoading extends StatelessWidget {
  const HistoryLanjutLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 16,
        ),
        Shimmer.fromColors(
          baseColor: AppColors.baseShimmerColor,
          highlightColor: AppColors.highlightShimmerColor,
          child: Container(
            width: double.infinity,
            height: 74,
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
            width: MediaQuery.of(context).size.width * 0.3,
            height: 29,
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
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
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
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 12.0,
              );
            },
            itemCount: 7),
        const SizedBox(
          height: 33,
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
          height: 12.0,
        ),
        Row(
          children: [
            Shimmer.fromColors(
              baseColor: AppColors.baseShimmerColor,
              highlightColor: AppColors.highlightShimmerColor,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: 21,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppColors.neutral300,
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 102,
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
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
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 12,
            );
          },
        )
      ],
    );
  }
}
