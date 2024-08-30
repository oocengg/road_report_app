import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/core/widgets/modals/add_segmen_modal.dart';
import 'package:mobileapp_roadreport/features/add_laporan/provider/add_laporan_provider.dart';
import 'package:mobileapp_roadreport/features/add_laporan/widgets/add_keterangan_widget.dart';
import 'package:mobileapp_roadreport/features/add_laporan/widgets/maps_widget.dart';

class AddLaporanScreen extends StatefulWidget {
  const AddLaporanScreen({super.key});

  @override
  State<AddLaporanScreen> createState() => _AddLaporanScreenState();
}

class _AddLaporanScreenState extends State<AddLaporanScreen> {
  final CarouselController _carouselController = CarouselController();
  final PageController _pageController = PageController();

  Future<bool> _autoClose() async {
    return true;
  }

  Future<bool> _onClosePage() async {
    return (await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Tinggalkan Halaman',
          ),
          content: const Text(
            'Tindakan ini akan menghapus seluruh segmen yang belum dilaporkan, apakah kamu yakin ingin meninggalkan halaman ini?',
            style: TextStyle(
              fontSize: AppFontSize.bodyMedium,
              fontWeight: AppFontWeight.bodyRegular,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text(
                'Batal',
                style: TextStyle(
                  color: AppColors.primary500,
                  fontSize: AppFontSize.bodySmall,
                  fontWeight: AppFontWeight.bodySemiBold,
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(
                  AppColors.error500,
                ),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              onPressed: () {
                context.read<AddLaporanProvider>().refreshSegmen();
                Navigator.of(context).pop(true);
              },
              child: const Text(
                'Hapus',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: AppFontSize.bodySmall,
                  fontWeight: AppFontWeight.bodySemiBold,
                ),
              ),
            ),
          ],
        );
      },
    ));
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AddLaporanProvider>().currentIndex = 0;
      context.read<AddLaporanProvider>().getLocationData(context: context);
    });

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddLaporanProvider>(
        builder: (context, addLaporanProvider, _) {
      return WillPopScope(
        onWillPop: addLaporanProvider.selectedPolylines.isEmpty
            ? _autoClose
            : _onClosePage,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text(
              'Laporkan Jalan',
              style: TextStyle(
                fontWeight: AppFontWeight.bodySemiBold,
                fontSize: AppFontSize.bodyMedium,
                color: Colors.white,
              ),
            ),
            leading: IconButton(
                onPressed: addLaporanProvider.selectedPolylines.isEmpty
                    ? () {
                        Navigator.pop(context);
                      }
                    : () async {
                        bool close = await _onClosePage();

                        if (context.mounted && close == true) {
                          Navigator.pop(context);
                        }
                      },
                icon: const Icon(FeatherIcons.arrowLeft)),
            backgroundColor: AppColors.primary500,
          ),
          body: Column(
            children: [
              CarouselSlider.builder(
                carouselController: _carouselController,
                itemCount: addLaporanProvider.data.length,
                options: CarouselOptions(
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  height: 130,
                  enableInfiniteScroll: false,
                  viewportFraction: 1.0,
                  initialPage: 0,
                  onPageChanged: (index, reason) {
                    addLaporanProvider.updateIndex(index);
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
                itemBuilder: (context, index, _) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              addLaporanProvider.data[index]['icon'],
                              size: 24.0,
                              color: AppColors.primary500,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              addLaporanProvider.data[index]['title'],
                              style: const TextStyle(
                                fontWeight: AppFontWeight.bodyBold,
                                fontSize: AppFontSize.bodyLarge,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          addLaporanProvider.data[index]['description'],
                          style: const TextStyle(
                            fontWeight: AppFontWeight.bodyRegular,
                            fontSize: AppFontSize.bodySmall,
                            color: AppColors.neutral700,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 20,
                  bottom: 20,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: addLaporanProvider.currentIndex == 0
                          ? null
                          : () {
                              addLaporanProvider.setPolyline(context);
                              _carouselController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                      child: Icon(
                        FeatherIcons.chevronLeft,
                        color: addLaporanProvider.currentIndex == 0
                            ? Colors.transparent
                            : AppColors.primary500,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(
                        addLaporanProvider.data.length,
                        (index) => Container(
                          width: 70.0,
                          height: 7.0,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: addLaporanProvider.currentIndex == index ||
                                    addLaporanProvider.currentIndex == 1
                                ? AppColors.primary500
                                : AppColors.neutral200,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: addLaporanProvider.currentIndex == 0 &&
                              addLaporanProvider.selectedPolylines.isNotEmpty
                          ? () {
                              showAddSegmenModal(context, _carouselController);
                            }
                          : null,
                      child: Icon(
                        FeatherIcons.chevronRight,
                        color: addLaporanProvider.selectedPolylines.isEmpty
                            ? AppColors.neutral200
                            : addLaporanProvider.currentIndex == 1
                                ? Colors.transparent
                                : AppColors.primary500,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  itemCount: addLaporanProvider.data.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return MapsWidget(
                        carouselController: _carouselController,
                      );
                    } else if (index == 1) {
                      return AddKeteranganWidget(
                        carouselController: _carouselController,
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
