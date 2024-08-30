import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobileapp_roadreport/core/keys/navigator_key.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/features/add_laporan/provider/add_laporan_provider.dart';
import 'package:mobileapp_roadreport/features/auth/provider/auth_provider.dart';
import 'package:mobileapp_roadreport/features/dashboard/provider/dashboard_provider.dart';
import 'package:mobileapp_roadreport/features/history/provider/detail_history_provider.dart';
import 'package:mobileapp_roadreport/features/history/provider/history_provider.dart';
import 'package:mobileapp_roadreport/features/home/provider/faq_provider.dart';
import 'package:mobileapp_roadreport/features/home/provider/home_provider.dart';
import 'package:mobileapp_roadreport/features/home/provider/small_maps_provider.dart';
import 'package:mobileapp_roadreport/features/laporan/provider/laporan_provider.dart';
import 'package:mobileapp_roadreport/features/profile/provider/profile_provider.dart';
import 'package:mobileapp_roadreport/features/splash/view/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DashboardProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FaqProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddLaporanProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailHistoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LaporanProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SmallMapsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HistoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Road Report App',
        home: const SplashScreen(),
        theme: ThemeData().copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary500),
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
          textTheme: GoogleFonts.interTextTheme(
            Theme.of(context).textTheme,
          ).apply(
            bodyColor: Colors.black,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.white,
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
          ),
          bottomAppBarTheme: const BottomAppBarTheme(
            color: Colors.white,
            shadowColor: Colors.black,
            elevation: 20,
            surfaceTintColor: Colors.white,
          ),
          bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.white,
          ),
          dialogTheme: const DialogTheme(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
          ),
          datePickerTheme: const DatePickerThemeData(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
          ),
        ),
        navigatorKey: navigatorKey,
      ),
    );
  }
}
