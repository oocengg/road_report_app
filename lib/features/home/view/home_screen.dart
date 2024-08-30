import 'package:flutter/material.dart';
import 'package:mobileapp_roadreport/features/home/widgets/draft_widget.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp_roadreport/features/home/provider/faq_provider.dart';
import 'package:mobileapp_roadreport/features/home/provider/home_provider.dart';
import 'package:mobileapp_roadreport/features/home/provider/small_maps_provider.dart';
import 'package:mobileapp_roadreport/features/home/widgets/faq_widget.dart';
import 'package:mobileapp_roadreport/features/home/widgets/heading_widget.dart';
// import 'package:mobileapp_roadreport/features/home/widgets/informasi_widget.dart';
// import 'package:mobileapp_roadreport/features/home/widgets/material_widget.dart';
import 'package:mobileapp_roadreport/features/home/widgets/small_maps_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _refreshPage() async {
    // context
    //     .read<SmallMapsProvider>()
    //     .getSegmenData(-7.874585, 112.519770, 1570);
    context.read<SmallMapsProvider>().getLocationData(context: context);
    context.read<FaqProvider>().getFaqData(context: context);
    context.read<HomeProvider>().buildPage(context);
    context.read<HomeProvider>().getData(context);
    context.read<HomeProvider>().setDraft();
    context.read<HomeProvider>().deleteDraft7();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Home Screen
      // context
      //     .read<SmallMapsProvider>()
      //     .getSegmenData(-7.874585, 112.519770, 1570);
      context.read<SmallMapsProvider>().getLocationData(context: context);
      context.read<FaqProvider>().getFaqData(context: context);
      context.read<HomeProvider>().buildPage(context);
      context.read<HomeProvider>().getData(context);
      context.read<HomeProvider>().setDraft();
      context.read<HomeProvider>().deleteDraft7();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshPage,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              shrinkWrap: true,
              children: const [
                SizedBox(
                  height: 16,
                ),
                HeadingWidget(),
                SizedBox(
                  height: 16,
                ),
                SmallMapsWidget(),
                SizedBox(
                  height: 16,
                ),
                // MaterialWidget(),
                SizedBox(
                  height: 16,
                ),
                DraftWidget(),
                SizedBox(
                  height: 16,
                ),
                FaqWidget(),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
