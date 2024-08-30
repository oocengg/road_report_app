import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mobileapp_roadreport/features/auth/model/models/auth_jwt_model.dart';
import 'package:mobileapp_roadreport/features/auth/model/models/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constant.dart';

class AuthService {
  //ambil baseurl
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: AppConstant.baseUrlAuth,
    ),
  );
  //API untuk otentikasi dengan data akun google
  Future<String> authEndPoint(
      String email, String fullname, String googleId, String avatar) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      final response = await dio.post("auth/google/register", data: {
        "email": email,
        "fullname": fullname,
        "google_id": googleId,
        "avatar": avatar
      });
      //simpan respon ke variable
      final res = AuthResponse.fromJson(response.data);

      //decode jwt decoder
      final decodedToken = JwtDecoder.decode(res.data.jwtToken);

      //simpan jwt respone
      final jwtResponse = AuthJwtResponse.fromJson(decodedToken);

      //cek apakah yang login adalah user dengan roleid
      if (jwtResponse.user!.uroleId != "895f80c1-95ee-4246-9ddf-b2507fb8538b") {
        return ("gagal");
      } else {
        //set preference user di aplikasi
        preferences.setString("jwtToken", res.data.jwtToken);
        preferences.setString("uid", jwtResponse.user!.id!);
        preferences.setString("id", jwtResponse.user!.role!.id!);
        preferences.setString("gid", jwtResponse.user!.googleId!);
        return res.data.token.toString();
      }
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }
}
