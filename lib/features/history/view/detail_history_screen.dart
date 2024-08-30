import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp_roadreport/core/state/finite_state.dart';
import 'package:mobileapp_roadreport/features/history/widgets/loading/detail_history_header_loading.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/font_size.dart';
import '../../../core/constants/font_weigth.dart';
import '../provider/detail_history_provider.dart';
import '../widgets/stepper_widget.dart';
import 'history_lanjut_screen.dart';
import 'history_perbaikan_screen.dart';
import 'history_proses_screen.dart';
import 'history_selesai_screen.dart';

class DetailHistoryScreen extends StatefulWidget {
  final int current;
  final String id;
  const DetailHistoryScreen(
      {super.key, required this.current, required this.id});

  @override
  State<DetailHistoryScreen> createState() => _DetailHistoryScreenState();
}

class _DetailHistoryScreenState extends State<DetailHistoryScreen> {
  int currentIndex = 1;
  PageController controller = PageController();

  // Agar ringan
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // Untuk menjalankan fungsi saat halaman baru dibuka
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DetailHistoryProvider>().getData(context, widget.id);
    });
    super.initState();
    currentIndex = widget.current;
    controller = PageController(initialPage: currentIndex);
  }

  // Menyimpan halaman sesuai dengan status laporan
  List<Widget> pages = [
    const HistoryProsesScreen(),
    const HistoryLanjutScreen(),
    const HistoryPerbaikanScreen(),
    const HistorySelesaiScreen()
  ];

  // Saat posisi refresh
  Future<void> onRefresh() async {
    context.read<DetailHistoryProvider>().getData(context, widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Riwayat',
            style: TextStyle(
                fontWeight: AppFontWeight.bodySemiBold,
                fontSize: AppFontSize.bodyMedium,
                color: Colors.white),
          ),
          backgroundColor: AppColors.primary500,
        ),
        body: Container(
          color: Colors.white,
          child: Stack(
            children: [
              ListView(),
              Column(
                children: [
                  Consumer<DetailHistoryProvider>(
                    builder: (context, provider, _) {
                      if (provider.state == MyState.initial) {
                        return const SizedBox.shrink();
                      } else if (provider.state == MyState.loading) {
                        return const DetailHistoryHeaderLoading();
                      } else if (provider.state == MyState.loaded) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 16.0,
                            ),
                            // Tampilkan waktu laporan diatas
                            provider.detail[0].statusId == "DONE"
                                ? FittedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            FeatherIcons.clock,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            formatTimeDifference(
                                                        provider.detail[0]
                                                            .updatedAt!,
                                                        provider.detail[0]
                                                            .createdAt!) ==
                                                    "0"
                                                ? "Laporan baru saja diselesaikan"
                                                : "Diselesaikan dalam waktu ${formatTimeDifference(provider.detail[0].updatedAt!, provider.detail[0].createdAt!)}",
                                            style: const TextStyle(
                                              fontSize: AppFontSize.bodySmall,
                                              fontWeight:
                                                  AppFontWeight.bodyRegular,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : FittedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            FeatherIcons.clock,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            formatTimeDifference(
                                                        DateTime.now(),
                                                        provider.detail[0]
                                                            .createdAt!) ==
                                                    "0"
                                                ? "Laporan baru saja dikirim"
                                                : "${formatTimeDifference(DateTime.now(), provider.detail[0].createdAt!)}, sejak laporan dikirim",
                                            style: const TextStyle(
                                              fontSize: AppFontSize.bodySmall,
                                              fontWeight:
                                                  AppFontWeight.bodyRegular,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                StepperWidget(
                                  title: "Dalam\nproses",
                                  garis: 0,
                                  garis1: 1,
                                  index: 0,
                                  currentIndex: widget.current,
                                  callback: () {},
                                ),
                                StepperWidget(
                                  title: "Tindak\nLanjut",
                                  garis: 1,
                                  garis1: 1,
                                  index: 1,
                                  currentIndex: widget.current,
                                  callback: () {},
                                ),
                                StepperWidget(
                                  title: "Perbaikan",
                                  garis: 1,
                                  garis1: 1,
                                  index: 2,
                                  currentIndex: widget.current,
                                  callback: () {},
                                ),
                                StepperWidget(
                                  title: "Selesai",
                                  garis: 1,
                                  garis1: 0,
                                  index: 3,
                                  currentIndex: widget.current,
                                  callback: () {},
                                ),
                              ],
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  //Tampilkan halaman detail laporan sesuai dengan current status
                  Expanded(
                    child: PageView.builder(
                      controller: controller,
                      onPageChanged: (value) {
                        setState(() {
                          currentIndex = value;
                        });
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return pages[widget.current];
                      },
                      itemCount: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String formatTimeDifference(DateTime startDate, DateTime endDate) {
  Duration difference = startDate.isBefore(endDate)
      ? endDate.difference(startDate)
      : startDate.difference(endDate);

  final days = difference.inDays;
  final hours = difference.inHours % 24;

  String formattedDifference = '';
  if (days > 0) {
    formattedDifference += '$days Hari ';
  }
  if (hours > 0) {
    formattedDifference += '$hours Jam ';
  }
  if (days == 0 && hours == 0) {
    formattedDifference = "0";
  }

  return formattedDifference.trim();
}
