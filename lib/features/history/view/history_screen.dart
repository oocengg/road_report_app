import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/features/history/provider/history_provider.dart';
import 'package:mobileapp_roadreport/features/history/widgets/riwayat_widget.dart';
import 'package:mobileapp_roadreport/features/history/widgets/search_widget.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  Future<void> onRefresh() async {
    context.read<HistoryProvider>().setFiltered(false);
    context.read<HistoryProvider>().resetCurrentPage();
    context.read<HistoryProvider>().getData(context);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HistoryProvider>().resetCurrentPage();
      context.read<HistoryProvider>().getData(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Riwayat',
            style: TextStyle(
                fontWeight: AppFontWeight.bodySemiBold,
                fontSize: AppFontSize.bodyMedium,
                color: Colors.white),
          ),
          backgroundColor: AppColors.primary500,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              ListView(),
              const Column(
                children: [
                  SearchWidget(),
                  SizedBox(
                    height: 16,
                  ),
                  RiwayatWidget(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
