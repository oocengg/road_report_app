import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mobileapp_roadreport/core/extensions/date_extension.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/state/finite_state.dart';
import 'package:mobileapp_roadreport/features/history/provider/detail_history_provider.dart';
import 'package:mobileapp_roadreport/features/history/widgets/loading/history_lanjut_loading.dart';

import '../../../core/constants/font_size.dart';
import '../../../core/constants/font_weigth.dart';
import '../widgets/proses_item_widget.dart';
import 'detail_jalan_screen.dart';

class HistoryLanjutScreen extends StatelessWidget {
  const HistoryLanjutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Consumer<DetailHistoryProvider>(
          builder: (context, provider, _) {
            if (provider.state == MyState.initial) {
              return const SizedBox.shrink();
            } else if (provider.state == MyState.loading) {
              return const HistoryLanjutLoading();
            } else if (provider.state == MyState.loaded) {
              if (provider.index == 1) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 6.0),
                      decoration: BoxDecoration(
                          color: AppColors.warning500,
                          borderRadius: BorderRadius.circular(6.0)),
                      child: const Text(
                        "Tindak Lanjut",
                        style: TextStyle(
                            fontSize: AppFontSize.bodySmall,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    ProsesItemWidget(
                      title: "Rencana Perbaikan",
                      body: formatDateEEEEddMMyyyy(
                          provider.detail[0].schedule!.dateStart.toString()),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    ProsesItemWidget(
                      title: "No. Tiket",
                      body: provider.detail[0].noTicket ?? "",
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    ProsesItemWidget(
                      title: "Nama",
                      body: provider.detail[0].user!.fullname ?? "",
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    ProsesItemWidget(
                      title: "Email",
                      body: provider.detail[0].user!.email ?? "",
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    ProsesItemWidget(
                      title: "Lokasi",
                      body: provider.detail[0].segmens![0].segmen!.name ?? "",
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    ProsesItemWidget(
                      title: "Tanggal Dikirim",
                      body: formatDateEEEEddMMyyyy(
                          provider.detail[0].createdAt.toString()),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    ProsesItemWidget(
                      title: "Keterangan",
                      body: provider.detail[0].note ?? "",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: provider.detail[0].segmens!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            await provider.setPolyline(provider
                                .detail[0].segmens![index].segmen!.geojson!);
                            await provider.setCenter(provider.detail[0]
                                .segmens![index].segmen!.centerPoint!);

                            if (context.mounted) {
                              Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) => DetailJalanScreen(
                                  index: index,
                                ),
                              ));
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 13.5, horizontal: 12.0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                color: AppColors.primary50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Segmen Jalan ${index + 1}",
                                  style: const TextStyle(
                                    fontSize: AppFontSize.bodySmall,
                                    fontWeight: AppFontWeight.bodySemiBold,
                                  ),
                                ),
                                const Icon(
                                  FeatherIcons.chevronRight,
                                  size: 24,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 12,
                        );
                      },
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
      ),
    );
  }
}
