import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/services/location_service.dart';
import 'package:mobileapp_roadreport/core/state/finite_state.dart';
import 'package:mobileapp_roadreport/features/add_laporan/models/model/geojson_model.dart';
import 'package:mobileapp_roadreport/features/laporan/models/service/laporan_service.dart';

class SmallMapsProvider with ChangeNotifier {
  double? latitude;
  double? longitude;

  MyState state = MyState.loading;

  final serviceLocation = LocationService();
  final serviceLaporan = LaporanService();

  List<Polyline> polylines = [];

  List<LatLng> routpoints = [const LatLng(-7.9467136, 112.6156684)];

  void getLocationData({required BuildContext context}) async {
    if (state == MyState.loaded || state == MyState.failed) {
      state = MyState.loading;
      notifyListeners();
    }
    final location = await serviceLocation.getUserLocation().then((value) {
      if (value == null) {
        state = MyState.failed;
        notifyListeners();
      } else {
        return value;
      }
    });

    if (location != null) {
      latitude = location.latitude;
      longitude = location.longitude;

      try {
        updateRoutePoint(location.latitude, location.longitude);

        getSegmenData(latitude!, longitude!, 1570);

        state = MyState.loaded;
        notifyListeners();
      } catch (e) {
        state = MyState.failed;
        notifyListeners();
      }
    } else {
      state = MyState.failed;
      notifyListeners();
      // print("eror mas bro");
    }
  }

  void updateRoutePoint(double latitude, double longitude) {
    routpoints.clear();

    routpoints.add(LatLng(latitude, longitude));
  }

  Future<void> getSegmenData(
    double latitude,
    double longitude,
    int radius,
  ) async {
    state = MyState.loading;
    notifyListeners();

    polylines.clear();

    try {
      final segmenData = await serviceLaporan.getAllSegmen(
        latitude,
        longitude,
        radius,
      ); // Get All Segmen

      List<Polyline> polylinesList = [];

      for (var segmen in segmenData) {
        String geoJsonString = segmen.geojson!;

        // Mendekode geojson menjadi objek GeoJsonModel
        GeoJsonModel geoJsonModel = geoJsonModelFromJson(geoJsonString);

        try {
          // Pengecekan apakah geoJsonModel memiliki tipe LineString
          if (geoJsonModel.type == "LineString") {
            if (segmen.report!.report != null) {
              if (segmen.report!.report!.statusId != 'DONE' &&
                  segmen.report!.report!.statusId != 'RJT') {
                // Mengambil koordinat dari geoJsonModel
                List<LatLng> points = [];
                List<List<double>> coordinates = geoJsonModel.coordinates;
                // Membentuk daftar titik LatLng
                for (List<double> coordinate in coordinates) {
                  double lat = coordinate[1];
                  double lng = coordinate[0];
                  points.add(LatLng(lat, lng));
                }

                // Menemukan report terkait dengan segmen ini
                var report = segmen.report;

                String tipeKerusakan = '';
                String levelKerusakan = '';

                if (report!.analyticData == null) {
                  // Jika analyticData null, ambil dari report_user_type dan report_user_level
                  tipeKerusakan = report.userType ?? '';
                  levelKerusakan = report.userLevel ?? '';
                } else {
                  if (report.analyticData!.typeSegmenAdmin != null &&
                      report.analyticData!.levelSegmenAdmin != null) {
                    tipeKerusakan = report.analyticData!.typeSegmenAdmin;
                    levelKerusakan = report.analyticData!.levelSegmenAdmin;
                  } else {
                    tipeKerusakan = report.analyticData!.typeSegmenSystem ?? '';
                    levelKerusakan =
                        report.analyticData!.levelSegmenSystem ?? '';
                  }
                }

                String skalaKerusakan = '$tipeKerusakan $levelKerusakan';

                Polyline polyline = Polyline(
                  points: points,
                  borderStrokeWidth: 2,
                  borderColor: skalaKerusakan == ' '
                      ? Colors.black
                      : skalaKerusakan == '- -'
                          ? AppColors.primary500
                          : Colors.transparent,
                  color: skalaKerusakan == 'Berlubang Parah'
                      ? AppColors.blue800
                      : skalaKerusakan == 'Berlubang Sedang'
                          ? AppColors.blue600
                          : skalaKerusakan == 'Berlubang Ringan'
                              ? AppColors.blue300
                              : skalaKerusakan == 'Terkelupas Parah'
                                  ? AppColors.green800
                                  : skalaKerusakan == 'Terkelupas Sedang'
                                      ? AppColors.green600
                                      : skalaKerusakan == 'Terkelupas Ringan'
                                          ? AppColors.mint400
                                          : skalaKerusakan == 'Retak Parah'
                                              ? AppColors.error800
                                              : skalaKerusakan == 'Retak Sedang'
                                                  ? AppColors.error500
                                                  : skalaKerusakan ==
                                                          'Retak Ringan'
                                                      ? AppColors.error300
                                                      : skalaKerusakan ==
                                                              'Bergelombang Parah'
                                                          ? AppColors.purple800
                                                          : skalaKerusakan ==
                                                                  'Bergelombang Sedang'
                                                              ? AppColors
                                                                  .purple600
                                                              : skalaKerusakan ==
                                                                      'Bergelombang Ringan'
                                                                  ? AppColors
                                                                      .purple300
                                                                  : skalaKerusakan ==
                                                                          'PermukaanKasar Parah'
                                                                      ? AppColors
                                                                          .warning600
                                                                      : skalaKerusakan ==
                                                                              'PermukaanKasar Sedang'
                                                                          ? AppColors
                                                                              .warning500
                                                                          : skalaKerusakan == 'PermukaanKasar Ringan'
                                                                              ? AppColors.warning300
                                                                              : skalaKerusakan == '- -'
                                                                                  ? AppColors.primary500.withOpacity(0.3)
                                                                                  : Colors.white,
                  strokeWidth: 6,
                );

                polylinesList.add(polyline);
              }
            }
          }
        } catch (e) {
          state = MyState.failed;
          notifyListeners();
          rethrow;
        }
      }

      polylines = polylinesList;

      state = MyState.loaded;
      notifyListeners();
    } catch (e) {
      state = MyState.failed;
      notifyListeners();
      rethrow;
    }
  }
}
