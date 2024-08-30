import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mobileapp_roadreport/core/widgets/modals/pilih_laporan_modal.dart';
import 'package:mobileapp_roadreport/core/widgets/modals/validate_data_modal.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/core/widgets/modals/login_modal.dart';
import 'package:mobileapp_roadreport/features/dashboard/provider/dashboard_provider.dart';
import 'package:mobileapp_roadreport/features/home/provider/home_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return Consumer<DashboardProvider>(
      builder: (context, dashboardProvider, _) {
        return Scaffold(
          body: dashboardProvider.pages[dashboardProvider.selectedIndex],
          floatingActionButton: keyboardIsOpened
              ? const SizedBox.shrink()
              : FloatingActionButton(
                  shape: const CircleBorder(),
                  backgroundColor: AppColors.primary500,
                  onPressed: () async {
                    await context.read<HomeProvider>().buildPage(context);
                    if (context.mounted) {
                      if (context.read<HomeProvider>().isLoggedIn) {
                        if (context.read<HomeProvider>().user.phone != null &&
                            context.read<HomeProvider>().user.address != null) {
                          showPilihLaporanModal(context);
                        } else {
                          showValidateDataModal(context);
                        }
                      } else {
                        showLoginModal(context);
                      }
                    }
                  },
                  child: const Icon(
                    FeatherIcons.plus,
                    color: Colors.white,
                  ),
                ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            height: 70,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    dashboardProvider.icon.length,
                    (index) {
                      final icon = dashboardProvider.icon[index];
                      final title = dashboardProvider.title[index];
                      return GestureDetector(
                        onTap: () async {
                          await context.read<HomeProvider>().buildPage(context);
                          if (context.mounted) {
                            if (index == 1 || index == 0) {
                              dashboardProvider.setSelectedIndex(
                                  context, index);
                            } else if (context
                                .read<HomeProvider>()
                                .isLoggedIn) {
                              dashboardProvider.setSelectedIndex(
                                  context, index);
                            } else {
                              showLoginModal(context);
                            }
                          }
                        },
                        child: Column(
                          children: [
                            icon == FeatherIcons.fileText
                                ? const SizedBox(
                                    width: 40,
                                  )
                                : Icon(
                                    icon,
                                    color:
                                        index == dashboardProvider.selectedIndex
                                            ? AppColors.primary500
                                            : AppColors.neutral700,
                                  ),
                            const SizedBox(
                              height: 5,
                            ),
                            Expanded(
                              child: Text(
                                title,
                                style: TextStyle(
                                  fontWeight: AppFontWeight.captionRegular,
                                  fontSize: AppFontSize.caption,
                                  color:
                                      index == dashboardProvider.selectedIndex
                                          ? AppColors.primary500
                                          : AppColors.neutral700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
