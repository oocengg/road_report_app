import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobileapp_roadreport/core/constants/app_constant.dart';
import 'package:mobileapp_roadreport/core/dio/dio_with_inteceptor.dart';
import 'package:mobileapp_roadreport/features/add_laporan/models/model/segmen_model.dart';
import 'package:mobileapp_roadreport/features/add_laporan/models/model/segmen_response_model.dart';
import 'package:mobileapp_roadreport/features/add_laporan/models/model/upload_image_response_model.dart';
import 'package:mobileapp_roadreport/features/home/model/models/faq_response_model.dart';
import 'package:mobileapp_roadreport/features/profile/models/model/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeService {
  final Dio dioGlobal = Dio(
    BaseOptions(
      baseUrl: AppConstant.baseUrl,
    ),
  );

  final dio = DioWithInterceptor().dioWithInterceptor;

  // Fungsi untuk mengambil data FAQ
  Future<List<FaqResponseModel>> getFaq() async {
    List<FaqResponseModel> faqData = [];

    try {
      // Jangan lupa API KEY karena tidak pakai interceptor
      final response = await dioGlobal.get(
        "faq",
        options: Options(
          headers: {
            'X-API-KEY': 'rrkr-8d99f820-zwhl-6306-9dxg-75da636f85a2',
          },
        ),
      );

      // Simpan data response FAQ
      if (response.data['data'] != [] || response.data['data'] != null) {
        for (var json in response.data['data']) {
          faqData.add(FaqResponseModel.fromJson(json));
        }
      }

      return faqData;
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }

  // Fungsi untuk mengambil data user
  Future<UserResponse> userEndPoint() async {
    // Simpan token dalam variabel untuk digunakan
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = 'Bearer ${preferences.getString('token')}';

    try {
      final response = await dioGlobal.get(
        "users/${preferences.getString("uid")}?embed=role",
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );

      final res = UserResponse.fromJson(response.data);

      // kirim hasil response
      return res;
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }

  // Fungsi untuk mengambil data draft user yang ada
  Future<List<SegmenResponseModel>> getSegmenDraftWithLatLong(
    double lat,
    double long,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = 'Bearer ${preferences.getString('token')}';

    List<SegmenResponseModel> segmenData = [];

    try {
      var jsonData = jsonEncode({
        "latitude": lat,
        "longitude": long,
      });

      final response = await dio.post(
        "street-segmens/draftradius?embed=report.report",
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
        data: jsonData,
      );

      // Simpan hasil response draft
      if (response.data['data'] != [] || response.data['data'] != null) {
        for (var json in response.data['data']) {
          segmenData.add(SegmenResponseModel.fromJson(json));
        }
      }

      return segmenData;
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }

  // Fungsi untuk mengupload gambar draft
  Future<UploadImageResponse> uploadImage(String filePath) async {
    try {
      // Simpan dalam formdata
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(filePath),
        "category": "image",
        "folder": "image",
      });

      final response = await dioGlobal.post(
        "upload-dumps",
        data: formData,
      );

      final res = UploadImageResponse.fromJson(response.data);

      return res;
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }

  // Fungsi untuk menambahkan laporan dari draft
  Future<void> addLaporan(
    String keterangan,
    List<SegmenModel> listSegmen,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = 'Bearer ${preferences.getString('token')}';

    try {
      List<Map<String, dynamic>> segmenData = [];

      for (var segmen in listSegmen) {
        List<Map<String, dynamic>> fotoData = [];

        for (var foto in segmen.fotoModel!) {
          fotoData.add({
            "filename": foto.filename,
            "abs_path": foto.absPath,
            "file_dump_id": foto.fileDumpId,
          });
        }

        segmenData.add({
          "map_street_segmen_id": segmen.id,
          "user_type": segmen.jenisKerusakan,
          "user_level": segmen.tipeKerusakan,
          "foto": fotoData,
        });
      }

      var jsonData = jsonEncode({
        "status_id": "PROG",
        "note": keterangan,
        "segmen": segmenData,
      });

      await dio.post(
        "report-list",
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
        data: jsonData,
      );
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }
}
