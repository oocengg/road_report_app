import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/keys/navigator_key.dart';
import 'package:mobileapp_roadreport/features/dashboard/provider/dashboard_provider.dart';
import 'package:mobileapp_roadreport/features/dashboard/view/dashboard_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // mintak validasi punya token kalau ga ada pop semua screen lempar ke login

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    //kalau error buat per kode yang di tentukan di contract
    /*
      400 = “bad request” string(255)
      401 = “unauthorized” string(255)
      403 = “forbidden” string(255)
      404 = “not found” string(255)
      408 = “request time out” string(255)
      409 = “conflict string(255)
      429 = “too many request” string(255)
      500 = “internal server error” string(255)
      504 = “gateway timeout” string(255)
    */

    if (err.response!.statusCode != null) {
      if (err.response!.statusCode == 404) {
        ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
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
                    'Maaf, terjadi kesalahan saat mengambil data. (Error 404)',
                  ),
                ),
              ],
            ),
            backgroundColor: AppColors.error500,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else if (err.response!.statusCode == 500) {
        ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
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
                    'Maaf, terjadi kesalahan pada server. (Error 500)',
                  ),
                ),
              ],
            ),
            backgroundColor: AppColors.error500,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else if (err.response!.statusCode == 401) {
        showDialog(
          context: navigatorKey.currentContext!,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Sesi berakhir."),
              content: const Text(
                  "Sesi anda telah berakhir. Silahkan Masuk kembali."),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();

                    if (context.mounted) {
                      preferences.remove("token");
                      preferences.remove("jwtToken");
                      preferences.remove("uid");
                      preferences.remove("id");
                      preferences.remove("gid");
                      preferences.setBool("isLoggedIn", false);

                      context
                          .read<DashboardProvider>()
                          .setSelectedIndex(context, 0);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DashboardScreen(),
                          ),
                          (route) => false);
                    }
                  },
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(AppColors.primary500)),
                  child: const Text(
                    'Masuk',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
          barrierDismissible: false,
        );
      } else if (err.response!.statusCode == 400) {
        ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
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
                    'Maaf, terjadi kesalahan saat mengambil data. (Error 400)',
                  ),
                ),
              ],
            ),
            backgroundColor: AppColors.error500,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
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
                    'Maaf, terjadi kesalahan. (Error)',
                  ),
                ),
              ],
            ),
            backgroundColor: AppColors.error500,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
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
                  'Maaf, terjadi kesalahan. (Error)',
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.error500,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    super.onError(err, handler);
  }
}
