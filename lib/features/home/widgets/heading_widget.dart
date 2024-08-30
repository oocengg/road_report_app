import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mobileapp_roadreport/core/state/finite_state.dart';
import 'package:mobileapp_roadreport/features/home/widgets/loading/heading_loading.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/features/home/provider/home_provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../auth/views/auth_screen.dart';

class HeadingWidget extends StatefulWidget {
  const HeadingWidget({
    super.key,
  });

  @override
  State<HeadingWidget> createState() => _HeadingWidgetState();
}

class _HeadingWidgetState extends State<HeadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (
        context,
        homeProvider,
        _,
      ) {
        if (homeProvider.headingState == MyState.initial) {
          return const SizedBox.shrink();
        } else if (homeProvider.headingState == MyState.loading) {
          return const HeadingLoading();
        } else if (homeProvider.headingState == MyState.loaded) {
          return homeProvider.user.avatar == null
              ? const SizedBox.shrink()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    homeProvider.isLoggedIn
                        ? Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  homeProvider.user.avatar != '-'
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.network(
                                            homeProvider.user.avatar!,
                                            height: 32,
                                            width: 32,
                                            fit: BoxFit.cover,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return Shimmer.fromColors(
                                                baseColor:
                                                    AppColors.baseShimmerColor,
                                                highlightColor: AppColors
                                                    .highlightShimmerColor,
                                                child: Container(
                                                  height: 32,
                                                  width: 32,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    color: AppColors.neutral200,
                                                  ),
                                                ),
                                              );
                                            },
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Container(
                                              color: AppColors.neutral200,
                                              child: const Icon(Icons
                                                  .image_not_supported_outlined),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          height: 32,
                                          width: 32,
                                          decoration: BoxDecoration(
                                            color: AppColors.primary500,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            homeProvider
                                                    .user.fullname!.isNotEmpty
                                                ? homeProvider.user.fullname![0]
                                                    .toUpperCase()
                                                : '',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: AppFontSize.bodySmall,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Flexible(
                                    child: Text(
                                      'Hai, ${homeProvider.user.fullname!.split(' ')[0]}!',
                                      style: const TextStyle(
                                        fontWeight: AppFontWeight.bodySemiBold,
                                        fontSize: AppFontSize.bodyMedium,
                                        color: AppColors.primary500,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : const Expanded(
                            child: Text(
                              'RoadReport',
                              style: TextStyle(
                                fontWeight: AppFontWeight.bodySemiBold,
                                fontSize: AppFontSize.bodyMedium,
                                color: AppColors.primary500,
                              ),
                            ),
                          ),
                    const SizedBox(
                      width: 20,
                    ),
                    homeProvider.isLoggedIn
                        ? const SizedBox.shrink()
                        : IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) => const AuthScreen(),
                                ),
                              );
                            },
                            icon: const Icon(
                              FeatherIcons.logIn,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                  ],
                );
        } else {
          return homeProvider.user.avatar == null
              ? Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'RoadReport',
                        style: TextStyle(
                          fontWeight: AppFontWeight.bodySemiBold,
                          fontSize: AppFontSize.bodyMedium,
                          color: AppColors.primary500,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => const AuthScreen(),
                          ),
                        );
                      },
                      icon: const Icon(
                        FeatherIcons.logIn,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    homeProvider.isLoggedIn
                        ? Expanded(
                            child: Row(
                              children: [
                                homeProvider.user.avatar != '-'
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.network(
                                          homeProvider.user.avatar!,
                                          height: 32,
                                          width: 32,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Shimmer.fromColors(
                                              baseColor:
                                                  AppColors.baseShimmerColor,
                                              highlightColor: AppColors
                                                  .highlightShimmerColor,
                                              child: Container(
                                                height: 32,
                                                width: 32,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  color: AppColors.neutral200,
                                                ),
                                              ),
                                            );
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Container(
                                            color: AppColors.neutral200,
                                            child: const Icon(Icons
                                                .image_not_supported_outlined),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 32,
                                        width: 32,
                                        decoration: BoxDecoration(
                                          color: AppColors.primary500,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          homeProvider.user.fullname!.isNotEmpty
                                              ? homeProvider.user.fullname![0]
                                                  .toUpperCase()
                                              : '',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: AppFontSize.bodySmall,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Flexible(
                                  child: Text(
                                    'Hai, ${homeProvider.user.fullname!.split(' ')[0]}!',
                                    style: const TextStyle(
                                      fontWeight: AppFontWeight.bodySemiBold,
                                      fontSize: AppFontSize.bodyMedium,
                                      color: AppColors.primary500,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : const Expanded(
                            child: Text(
                              'RoadReport',
                              style: TextStyle(
                                fontWeight: AppFontWeight.bodySemiBold,
                                fontSize: AppFontSize.bodyMedium,
                                color: AppColors.primary500,
                              ),
                            ),
                          ),
                    const SizedBox(
                      width: 20,
                    ),
                    homeProvider.isLoggedIn
                        ? IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              FeatherIcons.bell,
                              color: Colors.black,
                              size: 24,
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) => const AuthScreen(),
                                ),
                              );
                            },
                            icon: const Icon(
                              FeatherIcons.logIn,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                  ],
                );
        }
      },
    );
  }
}
