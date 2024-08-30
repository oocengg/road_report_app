import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mobileapp_roadreport/features/profile/view/edit_profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/core/state/finite_state.dart';
import 'package:mobileapp_roadreport/features/dashboard/provider/dashboard_provider.dart';
import 'package:mobileapp_roadreport/features/home/provider/home_provider.dart';
import 'package:mobileapp_roadreport/features/profile/provider/profile_provider.dart';
import 'package:mobileapp_roadreport/features/profile/widgets/headline_widget.dart';
import 'package:mobileapp_roadreport/features/profile/widgets/information_widget.dart';
import 'package:mobileapp_roadreport/features/profile/widgets/loading/profile_loading_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> onRefresh() async {
    context.read<ProfileProvider>().getData(context);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProfileProvider>().getData(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              ListView(),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 24,
                  bottom: 40,
                ),
                child: Consumer<ProfileProvider>(
                  builder: (context, provider, _) {
                    if (provider.state == MyState.initial) {
                      return const SizedBox.shrink();
                    } else if (provider.state == MyState.loading) {
                      return const ProfileLoadingScreen();
                    } else if (provider.state == MyState.loaded) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: double.infinity,
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(CupertinoPageRoute(
                                        builder: (context) =>
                                            const EditProfileScreen(),
                                      ));
                                    },
                                    icon: const Icon(FeatherIcons.edit)),
                              ),
                              HeadlineWidget(
                                email: provider.user.email!,
                                image: provider.user.avatar!,
                                nama: provider.user.fullname!,
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 27,
                              ),
                              InformationWidget(
                                nama: provider.user.fullname ?? "-",
                                alamat: provider.user.address ?? "-",
                                noHp: provider.user.phone ?? "-",
                              ),
                            ],
                          ),
                          provider.stateLogout == MyState.loading
                              ? const Center(
                                  child: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(
                                        color: AppColors.error500,
                                      )),
                                )
                              : TextButton(
                                  onPressed: () async {
                                    await provider.logout(context);

                                    if (context.mounted) {
                                      if (provider.stateLogout ==
                                          MyState.loaded) {
                                        context
                                            .read<DashboardProvider>()
                                            .setSelectedIndex(context, 0);

                                        context
                                            .read<HomeProvider>()
                                            .buildPage(context);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Row(
                                              children: [
                                                Icon(
                                                  FeatherIcons.xCircle,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Flexible(
                                                  child: Text(
                                                      'Maaf, Terjadi kesalahan. '),
                                                ),
                                              ],
                                            ),
                                            backgroundColor: Color.fromARGB(
                                                255, 255, 83, 71),
                                            behavior: SnackBarBehavior.floating,
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  style: ButtonStyle(
                                    alignment: Alignment.center,
                                    backgroundColor:
                                        const MaterialStatePropertyAll(
                                            AppColors.error50),
                                    shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          FeatherIcons.logOut,
                                          color: AppColors.error500,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'KELUAR',
                                          style: TextStyle(
                                            fontWeight:
                                                AppFontWeight.actionSemiBold,
                                            fontSize: AppFontSize.actionLarge,
                                            color: AppColors.error500,
                                            letterSpacing: 0.75,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                        ],
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
      ),
    );
  }
}
