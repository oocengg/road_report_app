import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/colors.dart';

class HistoryLoadingScreen extends StatelessWidget {
  const HistoryLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Row(
              children: [
                Shimmer.fromColors(
                  baseColor: AppColors.baseShimmerColor,
                  highlightColor: AppColors.highlightShimmerColor,
                  child: Container(
                    width: 72,
                    height: 72,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: AppColors.neutral300,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      const SizedBox(
                        height: 8,
                      ),
                      Shimmer.fromColors(
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
                      const SizedBox(
                        height: 8,
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
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 12,
          );
        },
        itemCount: 5);
  }
}
