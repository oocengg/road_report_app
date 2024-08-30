import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobileapp_roadreport/core/state/finite_state.dart';
import 'package:mobileapp_roadreport/features/profile/models/model/profile_model.dart';
import 'package:mobileapp_roadreport/features/profile/models/service/profile_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  MyState state = MyState.initial;
  MyState stateLogout = MyState.initial;

  Data user = Data();

  // Fungsi untuk mengambil data user yang akan ditampilkan ke screen
  Future<void> getData(BuildContext context) async {
    state = MyState.loading;
    notifyListeners();

    try {
      final response = await ProfileService().userEndPoint();
      if (context.mounted) {
        alamatController.text = response.data!.address ?? "";
        noHpController.text = response.data!.phone ?? "";
      }

      user = response.data!;

      state = MyState.loaded;
      notifyListeners();
    } catch (e) {
      state = MyState.failed;
      notifyListeners();
    }
  }

  // Fungsi untuk user logout dari aplikasi
  Future<void> logout(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    stateLogout = MyState.loading;
    notifyListeners();
    try {
      //logout dengan google
      await GoogleSignIn().disconnect();

      // Hapus data yang berhubungan dengan sutentikasi user
      if (context.mounted) {
        preferences.remove("token");
        preferences.remove("jwtToken");
        preferences.remove("uid");
        preferences.remove("id");
        preferences.remove("gid");
        preferences.setBool("isLoggedIn", false);
      }

      stateLogout = MyState.loaded;
      notifyListeners();
    } catch (e) {
      stateLogout = MyState.failed;
      notifyListeners();
    }
  }

  // Mulai dari sini untuk setting di edit screen
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController alamatController = TextEditingController();
  TextEditingController noHpController = TextEditingController();

  MyState stateEdit = MyState.initial;

  void controllerClear() {
    alamatController.clear();
    noHpController.clear();
    notifyListeners();
  }

  // Fungsi fungsi untuk validasi inputan
  String? validateAlamat(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return "Alamat tidak boleh kosong";
    }

    return null; // validasi berhasil
  }

  String? validateNoHp(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return "Nomor ponsel tidak boleh kosong";
    }

    const regex = r'^[0-9]+$';
    if (!RegExp(regex).hasMatch(value)) {
      return 'Hanya boleh mengandung angka';
    }

    if (value.length < 10 || value.length >= 15) {
      return "Nomor ponsel tidak valid";
    }

    return null; // validasi berhasil
  }

  // Fungsi untuk mengirimkan hasil inputan user di edit screen
  Future<void> edit(BuildContext context) async {
    stateEdit = MyState.loading;
    notifyListeners();
    if (formKey.currentState!.validate()) {
      try {
        if (context.mounted) {
          await ProfileService()
              .editEndPoint(alamatController.text, noHpController.text);

          controllerClear();
          stateEdit = MyState.loaded;
          notifyListeners();
        }
      } catch (e) {
        stateEdit = MyState.failed;
        notifyListeners();
      }
    } else {
      stateEdit = MyState.initial;
      notifyListeners();
    }
  }
}
