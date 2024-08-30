import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobileapp_roadreport/core/constants/app_constant.dart';
import 'package:mobileapp_roadreport/core/dio/dio_with_inteceptor.dart';
// ----------------------------------------- AI Info
import 'package:mobileapp_roadreport/features/add_laporan/models/model/ai_roadcheker_response_model.dart';
import 'package:mobileapp_roadreport/features/add_laporan/models/model/segmen_model.dart';
import 'package:mobileapp_roadreport/features/add_laporan/models/model/segmen_response_model.dart';
import 'package:mobileapp_roadreport/features/add_laporan/models/model/upload_image_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddLaporanService {
  // final Dio dio = Dio(
  //   BaseOptions(
  //     baseUrl: AppConstant.baseUrl,
  //   ),
  // );

  // Dio With Interceptop dimana sudah di set beberapa fungsi saat handle status code
  final dio = DioWithInterceptor().dioWithInterceptor;

  // Dio tanpa fungsi handle status code yang tidak perlu
  final Dio dioGlobal = Dio(
    BaseOptions(
      baseUrl: AppConstant.baseUrlGlobal,
    ),
  );

  // Hit API untuk get Segmmen
  Future<List<SegmenResponseModel>> getSegmen() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = 'Bearer ${preferences.getString('token')}';

    List<SegmenResponseModel> segmenData = [];

    try {
      final response = await dio.get(
        "street-segmens",
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );

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

  // Hit API untuk get Segmmen dengan lat long
  Future<List<SegmenResponseModel>> getSegmenWithLatLong(
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
        "street-segmens/radius?embed=report.report",
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
        data: jsonData,
      );

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

  // Hit API untuk upload Image
  Future<UploadImageResponse> uploadImage(String filePath) async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // final token = 'Bearer ${preferences.getString('token')}';

    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(filePath),
        "category": "image",
        "folder": "image",
      });

      final response = await dioGlobal.post(
        "upload-dumps",
        // options: Options(
        //   headers: {
        //     'Authorization': token,
        //   },
        // ),
        data: formData,
      );

      final res = UploadImageResponse.fromJson(response.data);

      return res;
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }

  // Hit API untuk add Laporan user
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

  // ----------------------------------------- AI Info

  // Dio with custom base url
  final Dio dioTest = Dio(
    BaseOptions(
      baseUrl: 'http://roadreport.ddns.net:5000/',
    ),
  );

  // Hit API untuk API dari Lab Pasca
  Future<AiRoadChecker> checkAiRoadChecker(String filePath) async {
    try {
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(filePath),
      });

      final response = await dioTest.post(
        "predict",
        data: formData,
      );

      final res = AiRoadChecker.fromJson(response.data);
      return res;
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }
}
