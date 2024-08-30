import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobileapp_roadreport/core/dio/dio_with_inteceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../../../../core/constants/app_constant.dart';

class HistoryService {
  // final Dio dio = Dio(
  //   BaseOptions(
  //     baseUrl: AppConstant.baseUrl,
  //   ),
  // );

  //base url dengan interceptor untuk setup handle status code
  final dio = DioWithInterceptor().dioWithInterceptor;

  //fungsi untuk ambil list history user
  Future<Map<String, dynamic>> historyEndPoint(int page) async {
    //ambil token
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = 'Bearer ${preferences.getString('token')}';

    //panggil API list laporan
    try {
      final response = await dio.get(
        "report-list?user_id[eq]=${preferences.getString("uid")}&embed=user,segmens,segmens.segmen,segmens.photos,rejected&sort=-created_at&page=$page&limit=10",
        options: Options(headers: {"Authorization": token}),
      );

      //kirim response APi
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  //Fungsi untuk ambil detail laporan di history saat klik dari list
  Future<Map<String, dynamic>> historyDetailEndPoint(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = 'Bearer ${preferences.getString('token')}';

    try {
      final response = await dio.get(
        "report-list?id[eq]=$id&embed=user,schedule.maintenanced,segmens.analytic_data,segmens.segmen,segmens.photos,rejected,rating",
        options: Options(headers: {"Authorization": token}),
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  //Fungsi untuk panggil API search history dengan id laporan
  Future<Map<String, dynamic>> historySearchEndPoint(
      String id, int page) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = 'Bearer ${preferences.getString('token')}';

    try {
      final response = await dio.get(
        "report-list?user_id[eq]=${preferences.getString("uid")}&no_ticket[eq]=$id&embed=user,segmens,segmens.segmen,segmens.photos,rejected&sort=-created_at&page=$page&limit=10",
        options: Options(headers: {"Authorization": token}),
      );

      return response.data;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  //Fungsi untuk ambil API filter list laporan di history
  Future<Map<String, dynamic>> historyFilterEndPoint(
      String id, int page) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = 'Bearer ${preferences.getString('token')}';

    try {
      final response = await dio.get(
        "report-list?user_id[eq]=${preferences.getString("uid")}&embed=user,segmens,segmens.segmen,segmens.photos,rejected&sort=-created_at&page=$page&limit=10&status_id$id",
        options: Options(headers: {"Authorization": token}),
      );

      return response.data;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  //Fungsi untuk mengirim hasil inputan rating ke server
  Future<Map<String, dynamic>> ratingEndPoint(
      double rating, String saran, String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = 'Bearer ${preferences.getString('token')}';
    try {
      var body =
          jsonEncode({"report_id": id, "rate": rating, "comment": saran});
      final response = await dio.post(
        "rating",
        options: Options(headers: {"Authorization": token}),
        data: body,
      );

      return response.data;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
