import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp_roadreport/core/state/finite_state.dart';
import 'package:mobileapp_roadreport/features/history/provider/detail_history_provider.dart';
import 'package:mobileapp_roadreport/features/history/widgets/loading/history_selesai_loading.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/font_size.dart';
import '../../../core/constants/font_weigth.dart';
import '../widgets/rating_widget.dart';

class HistorySelesaiScreen extends StatelessWidget {
  const HistorySelesaiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Consumer<DetailHistoryProvider>(
        builder: (context, provider, _) {
          if (provider.state == MyState.initial) {
            return const SizedBox.shrink();
          } else if (provider.state == MyState.loading) {
            return const HistorySelesaiLoading();
          } else if (provider.state == MyState.loaded) {
            if (provider.index == 3) {
              return Column(
                children: [
                  const Column(
                    children: [
                      SizedBox(
                        height: 24,
                      ),
                      Text("Perbaikan Jalan Selesai",
                          style: TextStyle(
                              fontSize: AppFontSize.bodyMedium,
                              fontWeight: AppFontWeight.bodySemiBold,
                              color: AppColors.primary500)),
                      SizedBox(
                        height: 8,
                      ),
                      Text("Berikut gambar setelah jalan diperbaiki.",
                          style: TextStyle(
                              fontSize: AppFontSize.bodyMedium,
                              fontWeight: AppFontWeight.bodyRegular,
                              color: AppColors.neutral700)),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            itemCount: provider.detail[0].segmens!.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: AppColors.primary50,
                                ),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                      dividerColor: Colors.transparent),
                                  child: ExpansionTile(
                                    title: Text(
                                      'Segmen Jalan ${index + 1}',
                                      style: const TextStyle(
                                          fontWeight:
                                              AppFontWeight.bodySemiBold,
                                          fontSize: AppFontSize.bodySmall),
                                    ),
                                    children: <Widget>[
                                      ListTile(
                                        title: Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              height: 120,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  color: Colors.white),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.3,
                                                    child: const Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              FeatherIcons
                                                                  .alertTriangle,
                                                              size: 24,
                                                            ),
                                                            SizedBox(
                                                              width: 8.0,
                                                            ),
                                                            Text(
                                                              "Sebelum",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      AppFontSize
                                                                          .bodyMedium,
                                                                  fontWeight:
                                                                      AppFontWeight
                                                                          .bodySemiBold,
                                                                  color: AppColors
                                                                      .neutral900),
                                                            ),
                                                          ],
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            "Berikut foto sebelum perbaikan",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    AppFontSize
                                                                        .bodySmall,
                                                                fontWeight:
                                                                    AppFontWeight
                                                                        .bodyRegular,
                                                                color: AppColors
                                                                    .neutral700),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 5),
                                                      child: Center(
                                                        child:
                                                            ListView.separated(
                                                                physics:
                                                                    const NeverScrollableScrollPhysics(),
                                                                scrollDirection:
                                                                    Axis
                                                                        .horizontal,
                                                                shrinkWrap:
                                                                    true,
                                                                itemBuilder:
                                                                    (context,
                                                                        index1) {
                                                                  return InkWell(
                                                                    onTap: () {
                                                                      _showFullScreenImage(
                                                                          context,
                                                                          provider.detail[0].segmens![index].photos![index1].absPath ??
                                                                              "");
                                                                    },
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                      child: Image
                                                                          .network(
                                                                        provider.detail[0].segmens![index].photos![index1].absPath ??
                                                                            "",
                                                                        width:
                                                                            76,
                                                                        height:
                                                                            76,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        loadingBuilder: (context,
                                                                            child,
                                                                            loadingProgress) {
                                                                          if (loadingProgress ==
                                                                              null) {
                                                                            return child;
                                                                          }
                                                                          return Shimmer
                                                                              .fromColors(
                                                                            baseColor:
                                                                                AppColors.baseShimmerColor,
                                                                            highlightColor:
                                                                                AppColors.highlightShimmerColor,
                                                                            child:
                                                                                Container(
                                                                              height: 76,
                                                                              width: 76,
                                                                              color: AppColors.neutral200,
                                                                            ),
                                                                          );
                                                                        },
                                                                        errorBuilder: (context,
                                                                                error,
                                                                                stackTrace) =>
                                                                            Container(
                                                                          color:
                                                                              AppColors.neutral200,
                                                                          height:
                                                                              76,
                                                                          width:
                                                                              76,
                                                                          child:
                                                                              const Icon(
                                                                            Icons.image_not_supported_outlined,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                                separatorBuilder:
                                                                    (context,
                                                                        index) {
                                                                  return const SizedBox(
                                                                    width: 8,
                                                                  );
                                                                },
                                                                itemCount: provider
                                                                            .detail[
                                                                                0]
                                                                            .segmens![
                                                                                index]
                                                                            .photos!
                                                                            .length <=
                                                                        2
                                                                    ? provider
                                                                        .detail[
                                                                            0]
                                                                        .segmens![
                                                                            index]
                                                                        .photos!
                                                                        .length
                                                                    : 2),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              height: 120,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  color: Colors.white),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.3,
                                                    child: const Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                                FeatherIcons
                                                                    .checkCircle,
                                                                size: 24,
                                                                color: Color(
                                                                    0xff28CA9E)),
                                                            SizedBox(
                                                              width: 8.0,
                                                            ),
                                                            Text(
                                                              "Sesudah",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      AppFontSize
                                                                          .bodyMedium,
                                                                  fontWeight:
                                                                      AppFontWeight
                                                                          .bodySemiBold,
                                                                  color: AppColors
                                                                      .success500),
                                                            ),
                                                          ],
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            "Berikut foto sesudah perbaikan",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    AppFontSize
                                                                        .bodySmall,
                                                                fontWeight:
                                                                    AppFontWeight
                                                                        .bodyRegular,
                                                                color: AppColors
                                                                    .neutral700),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 5),
                                                    child: Center(
                                                      child: ListView.separated(
                                                          physics:
                                                              const NeverScrollableScrollPhysics(),
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          shrinkWrap: true,
                                                          itemBuilder: (context,
                                                              index1) {
                                                            return InkWell(
                                                              onTap: () {
                                                                _showFullScreenImage(
                                                                    context,
                                                                    provider
                                                                            .detail[0]
                                                                            .schedule!
                                                                            .maintenanced![index]
                                                                            .photoAfter![index1]
                                                                            .absPath ??
                                                                        "");
                                                              },
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                                child: Image
                                                                    .network(
                                                                  provider
                                                                          .detail[
                                                                              0]
                                                                          .schedule!
                                                                          .maintenanced![
                                                                              index]
                                                                          .photoAfter![
                                                                              index1]
                                                                          .absPath ??
                                                                      "",
                                                                  width: 76,
                                                                  height: 76,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  loadingBuilder:
                                                                      (context,
                                                                          child,
                                                                          loadingProgress) {
                                                                    if (loadingProgress ==
                                                                        null) {
                                                                      return child;
                                                                    }
                                                                    return Shimmer
                                                                        .fromColors(
                                                                      baseColor:
                                                                          AppColors
                                                                              .baseShimmerColor,
                                                                      highlightColor:
                                                                          AppColors
                                                                              .highlightShimmerColor,
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            76,
                                                                        width:
                                                                            76,
                                                                        color: AppColors
                                                                            .neutral200,
                                                                      ),
                                                                    );
                                                                  },
                                                                  errorBuilder: (context,
                                                                          error,
                                                                          stackTrace) =>
                                                                      Container(
                                                                    color: AppColors
                                                                        .neutral200,
                                                                    height: 76,
                                                                    width: 76,
                                                                    child:
                                                                        const Icon(
                                                                      Icons
                                                                          .image_not_supported_outlined,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          separatorBuilder:
                                                              (context, index) {
                                                            return const SizedBox(
                                                              width: 8,
                                                            );
                                                          },
                                                          itemCount: provider
                                                                      .detail[0]
                                                                      .schedule!
                                                                      .maintenanced![
                                                                          index]
                                                                      .photoAfter!
                                                                      .length <=
                                                                  2
                                                              ? provider
                                                                  .detail[0]
                                                                  .schedule!
                                                                  .maintenanced![
                                                                      index]
                                                                  .photoAfter!
                                                                  .length
                                                              : 2),
                                                    ),
                                                  ))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: 12,
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          RatingWidget(
                            rating: provider.detail[0].rating != null
                                ? provider.detail[0].rating!.rate!
                                : 0,
                            saran: provider.detail[0].rating != null
                                ? provider.detail[0].rating!.comment ?? ""
                                : "",
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

void _showFullScreenImage(BuildContext context, String image) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        backgroundColor: Colors.transparent,
        content: SizedBox(
          width: 400,
          height: MediaQuery.of(context).size.width * 0.8,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors
                          .black12, // Ganti dengan warna latar belakang yang diinginkan
                      shape: BoxShape.circle,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
