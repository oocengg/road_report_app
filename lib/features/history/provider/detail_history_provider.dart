import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/features/add_laporan/models/model/geojson_model.dart';
import 'package:mobileapp_roadreport/features/history/models/model/geopoint_model.dart';
import 'package:mobileapp_roadreport/features/history/models/service/history_service.dart';

import '../../../core/state/finite_state.dart';
import '../models/model/history_detail_response.dart';

class DetailHistoryProvider with ChangeNotifier {
  MyState state = MyState.initial;
  MyState ratingState = MyState.initial;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // controller untuk inputan saran pda ihstory selesai
  final TextEditingController saranController = TextEditingController();

  List<Datum> detail = [];
  int index = 0;

  List<Polyline> listPolyline = [];
  LatLng center = const LatLng(0, 0);

  // Fungsi untuk mengambil response API
  void getData(BuildContext context, String id) async {
    state = MyState.loading;
    notifyListeners();

    try {
      final response = await HistoryService().historyDetailEndPoint(id);
      detail = HistoryDetailResponse.fromJson(response).data!;
      // Cek status laporan untuk set index halaman
      if (detail[0].statusId == "PROG") {
        index = 0;
        notifyListeners();
      } else if (detail[0].statusId == "FOLUP") {
        index = 1;
        notifyListeners();
      } else if (detail[0].statusId == "RPR" || detail[0].statusId == "FIXED") {
        index = 2;
        setPolyline(detail[0].segmens![0].segmen!.geojson!);
        notifyListeners();
      } else if (detail[0].statusId == "DONE") {
        index = 3;
        // Setting bagian rating hanya untuk di status DONE
        if (detail[0].rating == null) {
          rating = 0;
          saranController.clear();
        } else if (detail[0].rating!.comment != null &&
            detail[0].rating!.comment!.isNotEmpty) {
          saranController.text = detail[0].rating!.comment!;
        } else {
          saranController.text = "-";
        }
        notifyListeners();
      } else {
        index = 0;
        notifyListeners();
      }

      state = MyState.loaded;
      notifyListeners();
    } catch (e) {
      state = MyState.failed;
      notifyListeners();
    }
  }

  // Fungsi untuk set kordinat di map
  Future<void> setPolyline(String geojson) async {
    try {
      // Get Segmen with radius
      List<Polyline> polylinesList = [];

      // Mendekode geojson menjadi objek GeoJsonModel
      GeoJsonModel geoJsonModel = geoJsonModelFromJson(geojson);

      try {
        // Pengecekan apakah geoJsonModel memiliki tipe LineString
        if (geoJsonModel.type == "LineString") {
          // Mengambil koordinat dari geoJsonModel
          List<LatLng> points = [];
          List<List<double>> coordinates = geoJsonModel.coordinates;

          // Membentuk daftar titik LatLng
          for (List<double> coordinate in coordinates) {
            double lat = coordinate[1];
            double lng = coordinate[0];
            points.add(LatLng(lat, lng));
          }

          Polyline polyline = Polyline(
            points: points,
            color: AppColors.primary500,
            strokeWidth: 6,
          );

          polylinesList.add(polyline);
        }
        listPolyline = polylinesList;
      } catch (e) {
        rethrow;
        // state = MyState.failed;
        // notifyListeners();
      }
    } catch (e) {
      rethrow;
      // state = MyState.failed;
      // notifyListeners();
    }
  }

  // Fungsi untuk set titik tengah map
  Future<void> setCenter(String geojson) async {
    try {
      // Get Segmen with radius

      // Mendekode geojson menjadi objek GeoJsonModel
      GeoPointModel geoJsonModel = geoPointModelFromJson(geojson);

      try {
        // Pengecekan apakah geoJsonModel memiliki tipe LineString
        if (geoJsonModel.type == "Point") {
          // Mengambil koordinat dari geoJsonModel
          List<double> coordinates = geoJsonModel.coordinates!;

          // Membentuk daftar titik LatLng
          double lat = coordinates[1];
          double lng = coordinates[0];
          center = LatLng(lat, lng);
        }
      } catch (e) {
        rethrow;
        // state = MyState.failed;
        // notifyListeners();
      }
    } catch (e) {
      rethrow;
      // state = MyState.failed;
      // notifyListeners();
    }
  }

  double rating = 0;

  // Fungsi untuk mengirim rating yang diinputkan oleh user
  Future<void> postRating() async {
    ratingState = MyState.loading;
    notifyListeners();

    try {
      // Panggil end point
      await HistoryService()
          .ratingEndPoint(rating, saranController.text, detail[0].id!);

      // kosongi variabel
      rating = 0;
      saranController.clear();

      ratingState = MyState.loaded;
      notifyListeners();
    } on DioException catch (e) {
      rating = 0;
      saranController.clear();

      ratingState = MyState.failed;
      notifyListeners();
      throw Exception(e.toString());
    }
  }
}
