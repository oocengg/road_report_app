import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobileapp_roadreport/core/state/finite_state.dart';
import 'package:mobileapp_roadreport/features/auth/model/services/auth_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  MyState state = MyState.initial;

  //Fungsi untuk login dengan akun google
  Future<void> login() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    state = MyState.loading;
    notifyListeners();
    try {
      //Jalankan package google untuk sig in
      final GoogleSignInAccount? userGoogle = await GoogleSignIn().signIn();

      //Jika login berhasil
      if (userGoogle != null) {
        //Lakukan post API login ke server dengan data akun google
        final response = await AuthService().authEndPoint(
            userGoogle.email,
            userGoogle.displayName ?? "-",
            userGoogle.id,
            userGoogle.photoUrl ?? "-");
        //Jika post API berhasil setting preference untuk autentikasi
        if (response != "gagal") {
          preferences.setString("token", response);
          preferences.setBool("isLoggedIn", true);
          preferences.setBool("isFirstTime", false);

          //Pengecekan isi draft user
          //Cek dulu key draft ada atau tidak
          if (preferences.containsKey("draft")) {
            List<String> draftList = preferences.getStringList("draft") ?? [];

            //Cek apa ada isi draftnya
            for (String filePath in draftList) {
              if (await File(filePath).exists()) {
                // Hapus berkas dari sistem file
                await File(filePath).delete();

                // Menunggu sejenak (misalnya 1 detik)
                await Future.delayed(const Duration(seconds: 1));

                // Hapus berkas dari cache aplikasi
                await DefaultCacheManager().removeFile(filePath);
              } else {}
            }
            //Hapus cache
            final cacheDir = await getTemporaryDirectory();

            if (cacheDir.existsSync()) {
              cacheDir.deleteSync(recursive: true);
            }
            final appDir = await getApplicationSupportDirectory();

            if (appDir.existsSync()) {
              appDir.deleteSync(recursive: true);
            }
          }
          //Set draft ke default kosong lagi
          await preferences.setStringList("draft", []);
          await preferences.setStringList("lat", []);
          await preferences.setStringList("lng", []);

          state = MyState.loaded;
          notifyListeners();
        } else {
          state = MyState.failed;
          notifyListeners();
        }
      } else {
        state = MyState.initial;
        notifyListeners();
      }
    } catch (e) {
      state = MyState.failed;
      notifyListeners();
    }
  }
}
