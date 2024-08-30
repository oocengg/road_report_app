import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/core/state/finite_state.dart';
import 'package:mobileapp_roadreport/features/auth/provider/auth_provider.dart';
import 'package:mobileapp_roadreport/features/dashboard/provider/dashboard_provider.dart';
import 'package:mobileapp_roadreport/features/dashboard/view/dashboard_screen.dart';

import '../../../core/constants/colors.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.5,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/bg_login.png",
                  ),
                  fit: BoxFit.cover),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "RoadReport App",
                    style: TextStyle(
                      fontSize: AppFontSize.heading4,
                      fontWeight: AppFontWeight.headingSemiBold,
                      color: Colors.white,
                      letterSpacing: 0.15,
                    ),
                  ),
                  SizedBox(
                    height: 11.0,
                  ),
                  Text(
                    "Aplikasi pelaporan jalan berlubang",
                    style: TextStyle(
                      fontSize: AppFontSize.bodyMedium,
                      fontWeight: AppFontWeight.bodyRegular,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: 1,
                        color: AppColors.neutral500,
                      ),
                      const Text(
                        "Silakan Masuk Disini",
                        style: TextStyle(
                          fontSize: AppFontSize.actionMedium,
                          fontWeight: AppFontWeight.actionSemiBold,
                          color: AppColors.neutral500,
                          letterSpacing: 0.75,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: 1,
                        color: AppColors.neutral500,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  //set consumer buat login
                  Consumer<AuthProvider>(builder: (context, provider, _) {
                    //kalo loding jadi muter
                    return provider.state == MyState.loading
                        ? const Center(
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: AppColors.primary500,
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () async {
                              //panggil fungsi login dari auth provider
                              await provider.login();
                              //pake context mounted biar jalan dulu yang await
                              if (context.mounted) {
                                if (provider.state == MyState.loaded) {
                                  //lek berhasil pop dulu halaman login baru ke dashboard
                                  Navigator.pop(context);
                                  //set index buat dashboard biar ke halaman home
                                  context
                                      .read<DashboardProvider>()
                                      .setSelectedIndex(context, 0);
                                  Navigator.of(context).pushReplacement(
                                    CupertinoPageRoute(
                                      builder: (BuildContext context) =>
                                          const DashboardScreen(),
                                    ),
                                  );
                                } else if (provider.state == MyState.failed) {
                                  ScaffoldMessenger.of(context).showSnackBar(
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
                                      backgroundColor:
                                          Color.fromARGB(255, 255, 83, 71),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                }
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 12.0),
                              decoration: BoxDecoration(
                                color: AppColors.primary50,
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/google.png",
                                    width: 24,
                                    height: 24,
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  const Text(
                                    "Masuk Dengan Gmail",
                                    style: TextStyle(
                                      fontSize: AppFontSize.actionMedium,
                                      fontWeight: AppFontWeight.actionSemiBold,
                                      color: AppColors.primary500,
                                      letterSpacing: 0.75,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                  })
                ],
              ),
            ),
          ),
          const Text(
            "POWERED BY",
            style: TextStyle(
              fontSize: AppFontSize.overlineSmall,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/pis_logo_1.png",
                width: 40,
                height: 40,
              ),
              Image.asset(
                "assets/images/polinema.png",
                width: 40,
                height: 40,
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
