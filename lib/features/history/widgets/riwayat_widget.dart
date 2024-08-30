import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mobileapp_roadreport/features/history/view/history_screen.dart';
import 'package:mobileapp_roadreport/features/history/widgets/modal/ditolak_modal.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/core/state/finite_state.dart';
import 'package:mobileapp_roadreport/features/history/provider/history_provider.dart';
import 'package:mobileapp_roadreport/features/history/widgets/item/riwayat_item_widget.dart';
import 'package:mobileapp_roadreport/features/history/widgets/loading/history_loading_screen.dart';

import '../view/detail_history_screen.dart';
import 'modal/filter_history_modal.dart';

class RiwayatWidget extends StatefulWidget {
  const RiwayatWidget({super.key});

  @override
  State<RiwayatWidget> createState() => _RiwayatWidgetState();
}

class _RiwayatWidgetState extends State<RiwayatWidget> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(_scrollListener);
      // Load initial data
      context.read<HistoryProvider>().resetCurrentPage();
      context.read<HistoryProvider>().getData(context);
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() async {
    if (_scrollController.position.extentAfter == 0) {
      // User has reached the end of the list, load more data here
      if (!_isLoading) {
        // Set _isLoading to true to prevent multiple requests while loading
        setState(() {
          _isLoading = true;
        });

        if (context.read<HistoryProvider>().history.length !=
            context.read<HistoryProvider>().totalItem) {
          context.read<HistoryProvider>().addCurrentPage();

          if (context.read<HistoryProvider>().filtered) {
            context.read<HistoryProvider>().filter(context).then((success) {
              // Once data is loaded, set _isLoading to false
              setState(() {
                _isLoading = false;
              });
            });
          } else {
            // Call a function to load more data
            context.read<HistoryProvider>().getData(context).then((success) {
              // Once data is loaded, set _isLoading to false
              setState(() {
                _isLoading = false;
              });
            });
          }
        } else {
          setState(() {
            _isLoading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Row(
                children: [
                  Icon(
                    FeatherIcons.checkCircle,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Text(
                      'Semua data laporan telah dimuat',
                    ),
                  ),
                ],
              ),
              backgroundColor: AppColors.success500,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                child: Text(
                  'Informasi',
                  style: TextStyle(
                      fontSize: AppFontSize.bodyMedium,
                      fontWeight: AppFontWeight.bodySemiBold),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showFilterHistoryModal(context);
                },
                child: const Icon(
                  FeatherIcons.filter,
                  size: 20,
                  color: AppColors.primary500,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: Consumer<HistoryProvider>(
              builder: (context, provider, _) {
                if (provider.state == MyState.initial) {
                  return const SizedBox.shrink();
                } else if (provider.state == MyState.loading) {
                  return const HistoryLoadingScreen();
                } else if (provider.state == MyState.loaded) {
                  if (provider.history.isNotEmpty) {
                    return ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        if (index < provider.history.length) {
                          return InkWell(
                            onTap: () {
                              if (provider.history[index].statusId == "RJT") {
                                showHistoryDitolakModal(
                                    context, provider.history[index]);
                              } else {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => provider
                                                .history[index].statusId ==
                                            "PROG"
                                        ? DetailHistoryScreen(
                                            current: 0,
                                            id: provider.history[index].id!,
                                          )
                                        : provider.history[index].statusId ==
                                                "FOLUP"
                                            ? DetailHistoryScreen(
                                                current: 1,
                                                id: provider.history[index].id!,
                                              )
                                            : provider.history[index]
                                                            .statusId ==
                                                        "RPR" ||
                                                    provider.history[index]
                                                            .statusId ==
                                                        "FIXED"
                                                ? DetailHistoryScreen(
                                                    current: 2,
                                                    id: provider
                                                        .history[index].id!,
                                                  )
                                                : provider.history[index]
                                                            .statusId ==
                                                        "DONE"
                                                    ? DetailHistoryScreen(
                                                        current: 3,
                                                        id: provider
                                                            .history[index].id!,
                                                      )
                                                    : const HistoryScreen(),
                                  ),
                                );
                              }
                            },
                            child: RiwayatItemWidget(
                              ticket: provider.history[index].noTicket!,
                              progress: provider.history[index].statusId!,
                              street: provider
                                  .history[index].segmens![0].segmen!.name!,
                              date:
                                  provider.history[index].createdAt!.toString(),
                              photo: provider.history[index].segmens![0]
                                  .photos![0].absPath!,
                            ),
                          );
                        } else if (index == provider.history.length &&
                            _isLoading) {
                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                              ],
                            ),
                          );
                        } else {
                          return const Center(
                            child: Text('Tidak ada data yang perlu dimuat.'),
                          ); // Return an empty item for other cases
                        }
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 12,
                        );
                      },
                      itemCount: provider.history.length + (_isLoading ? 1 : 0),
                    );
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/empty.png",
                            height: MediaQuery.of(context).size.height * 0.35,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: const Text(
                              "Mohon maaf, anda belum memiliki laporan.",
                              style: TextStyle(
                                fontSize: AppFontSize.bodyMedium,
                                fontWeight: AppFontWeight.bodyRegular,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
