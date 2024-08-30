// import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tappable_polyline/flutter_map_tappable_polyline.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/services/location_service.dart';
import 'package:mobileapp_roadreport/core/state/finite_state.dart';
import 'package:mobileapp_roadreport/features/add_laporan/models/model/geojson_model.dart';
import 'package:mobileapp_roadreport/features/laporan/models/model/filter_item_model.dart';
import 'package:mobileapp_roadreport/features/laporan/models/model/segmen_detail_laporan.dart';
// import 'package:mobileapp_roadreport/features/laporan/models/model/geojson_model.dart';
import 'package:mobileapp_roadreport/features/laporan/models/service/laporan_service.dart';

class LaporanProvider with ChangeNotifier {
  // Setting Map Controller
  MapController mapController = MapController();

  // Setting Zoom Default
  double zoom = 13;

  // List Polyline yang akan ditampung sesuai dengan hasil get
  List<TaggedPolyline> polylines = [];

  // Lat Long Device (Center)
  double? latitude;
  double? longitude;

  // Lat Long Default
  List<LatLng> routpoints = [const LatLng(-7.9467136, 112.6156684)];

  // Fitlering Item
  List<FilterItem> filterItems = [
    FilterItem("Berlubang Parah", AppColors.blue800),
    FilterItem("Berlubang Sedang", AppColors.blue600),
    FilterItem("Berlubang Ringan", AppColors.blue300),
    FilterItem("Terkelupas Parah", AppColors.green800),
    FilterItem("Terkelupas Sedang", AppColors.green600),
    FilterItem("Terkelupas Ringan", AppColors.mint400),
    FilterItem("Retak Parah", AppColors.error800),
    FilterItem("Retak Sedang", AppColors.error500),
    FilterItem("Retak Ringan", AppColors.error300),
    FilterItem("Bergelombang Parah", AppColors.purple800),
    FilterItem("Bergelombang Sedang", AppColors.purple600),
    FilterItem("Bergelombang Ringan", AppColors.purple300),
    FilterItem("Permukaan Kasar Parah", AppColors.warning600),
    FilterItem("Permukaan Kasar Sedang", AppColors.warning500),
    FilterItem("Permukaan Kasar Ringan", AppColors.warning300),
  ];

  // Filter yang diselect
  List<FilterItem> selectedItems = [];

  // State
  MyState state = MyState.loading;
  MyState stateGetSegmen = MyState.loading;
  MyState stateGetSegmenDetail = MyState.loading;

  SegmenDetailLaporan segmenDetailData = SegmenDetailLaporan();

  // Service
  final serviceLocation = LocationService();
  final laporanService = LaporanService();

  // Clear Item Selected
  void clearIsSelected() {
    for (var item in filterItems) {
      item.isSelected = false;
    }
    notifyListeners();
  }

  // Function mengambil lokasi device
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

  // Update Center Device
  void updateRoutePoint(double latitude, double longitude) {
    routpoints.clear();

    routpoints.add(LatLng(latitude, longitude));
  }

  // Function mengambil seluruh segmen yang ada pada radius sesuai zoom
  Future<void> getSegmenData(
    double latitude,
    double longitude,
    int radius,
  ) async {
    stateGetSegmen = MyState.loading;
    notifyListeners();

    polylines.clear();

    try {
      final segmenData = await laporanService.getAllSegmen(
        latitude,
        longitude,
        radius,
      ); // Get All Segmen

      List<TaggedPolyline> polylinesList = [];

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

                TaggedPolyline polyline = TaggedPolyline(
                  tag: '${segmen.id}',
                  points: points,
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
                  strokeWidth: 8,
                  borderStrokeWidth: 2,
                );
                polylinesList.add(polyline);
              }
            }
          }
        } catch (e) {
          state = MyState.failed;
          stateGetSegmen = MyState.failed;
          notifyListeners();
          rethrow;
        }
      }

      polylines = polylinesList;

      state = MyState.loaded;
      stateGetSegmen = MyState.loaded;
      notifyListeners();
    } catch (e) {
      state = MyState.failed;
      stateGetSegmen = MyState.failed;
      notifyListeners();
      rethrow;
    }
  }

  // Menambahkan Selected Filter
  void addSelectedFilter(FilterItem item) {
    selectedItems.add(item);
    notifyListeners();
  }

  // Menghapus Selected Filter
  void removeSelectedFilter(FilterItem item) {
    selectedItems.remove(item);
    notifyListeners();
  }

  // Zoom Plus Map
  void plusZoom() {
    double zoom = mapController.zoom + 1;

    this.zoom++;
    mapController.move(mapController.center, zoom);
    notifyListeners();
  }

  // Zoom Min Map
  void minZoom() {
    double zoom = mapController.zoom - 1;

    this.zoom--;
    mapController.move(mapController.center, zoom);

    double zoomLevel = mapController.zoom;
    double distanceInMeter;

    // Pengecekan penentuan radius map
    if (zoomLevel >= 13 && zoomLevel <= 14) {
      distanceInMeter = 5.35 * 1000; // Konversi dari kilometer ke meter
    } else if (zoomLevel > 14 && zoomLevel <= 15) {
      distanceInMeter = 3.24 * 1000;
    } else if (zoomLevel > 15 && zoomLevel <= 16) {
      distanceInMeter = 1.57 * 1000;
    } else if (zoomLevel > 16 && zoomLevel <= 17) {
      distanceInMeter = 853;
    } else if (zoomLevel > 17 && zoomLevel <= 18) {
      distanceInMeter = 390;
    } else if (zoomLevel > 18 && zoomLevel <= 19) {
      distanceInMeter = 207;
    } else {
      distanceInMeter = 207;
    }

    getSegmenData(
      mapController.center.latitude,
      mapController.center.longitude,
      distanceInMeter.toInt(),
    );

    notifyListeners();
  }

  // Fungsi get detail segmen yang di klik
  Future<void> getDetailSegmen(String id) async {
    stateGetSegmenDetail = MyState.loading;
    notifyListeners();
    try {
      segmenDetailData = await laporanService.getSegemDetailLaporanData(id);

      stateGetSegmenDetail = MyState.loaded;
      notifyListeners();
    } catch (e) {
      stateGetSegmenDetail = MyState.failed;
      notifyListeners();
    }
  }
}
