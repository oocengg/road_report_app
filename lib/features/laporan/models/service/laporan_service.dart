import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobileapp_roadreport/core/constants/app_constant.dart';
import 'package:mobileapp_roadreport/features/laporan/models/model/segmen_detail_laporan.dart';
import 'package:mobileapp_roadreport/features/laporan/models/model/segmen_status_response_model.dart';

class LaporanService {
  // Dio Untuk get tanpa interceptor
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: AppConstant.baseUrl,
    ),
  );

  // Hit API untuk mengambil semua segmen
  Future<List<SegmenStatusResponseModel>> getAllSegmen(
    double latitude,
    double longitude,
    int radius,
  ) async {
    List<SegmenStatusResponseModel> segmenData = [];

    try {
      var jsonData = jsonEncode(
        {
          "latitude": latitude,
          "longitude": longitude,
          "radius": radius,
        },
      );

      final response = await dio.post(
        "street-segmens/report?embed=report.report,report.analytic_data",
        options: Options(
          headers: {
            'X-API-KEY': 'rrkr-8d99f820-zwhl-6306-9dxg-75da636f85a2',
          },
        ),
        data: jsonData,
      );

      if (response.data['data'] != [] || response.data['data'] != null) {
        for (var json in response.data['data']) {
          segmenData.add(SegmenStatusResponseModel.fromJson(json));
        }
      }

      return segmenData;
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }

  // Hit API untuk mengambil data laporan dari segmen yang tampil
  Future<SegmenDetailLaporan> getSegemDetailLaporanData(
    String id,
  ) async {
    try {
      final response = await dio.get(
        "street-segmens/detail/$id",
        options: Options(
          headers: {
            'X-API-KEY': 'rrkr-8d99f820-zwhl-6306-9dxg-75da636f85a2',
          },
        ),
      );

      final result = SegmenDetailLaporan.fromJson(response.data['data']);
      return result;
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }
}
