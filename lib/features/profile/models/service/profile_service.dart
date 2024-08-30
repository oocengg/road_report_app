import 'package:dio/dio.dart';
import 'package:mobileapp_roadreport/core/dio/dio_with_inteceptor.dart';
import 'package:mobileapp_roadreport/features/profile/models/model/edit_profile_model.dart';
import 'package:mobileapp_roadreport/features/profile/models/model/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  final dio = DioWithInterceptor().dioWithInterceptor;

  // Fungsi untuk memanggil API untuk mendapatkan data user
  Future<UserResponse> userEndPoint() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = 'Bearer ${preferences.getString('token')}';

    try {
      final response = await dio.get(
        "users/${preferences.getString("uid")}?embed=role",
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );

      final res = UserResponse.fromJson(response.data);

      return res;
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }

  // Fungsi untuk memanggil API untuk mengirimkan data inputan edit data user
  Future<EditUserResponse> editEndPoint(String alamat, String noHp) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = 'Bearer ${preferences.getString('token')}';

    try {
      final response = await dio.put(
        "users/${preferences.getString("uid")}",
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
        data: {'address': alamat, 'phone': noHp},
      );

      final res = EditUserResponse.fromJson(response.data);

      return res;
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }
}
