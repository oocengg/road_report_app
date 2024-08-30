// import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tappable_polyline/flutter_map_tappable_polyline.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/features/add_laporan/models/model/foto_model.dart';
import 'package:mobileapp_roadreport/features/add_laporan/models/model/geojson_model.dart';
import 'package:mobileapp_roadreport/features/add_laporan/models/model/laporan_model.dart';
import 'package:mobileapp_roadreport/features/add_laporan/models/model/segmen_model.dart';
import 'package:mobileapp_roadreport/features/add_laporan/models/service/add_laporan_service.dart';
import 'package:mobileapp_roadreport/features/home/model/service/home_service.dart';
import 'package:mobileapp_roadreport/core/state/finite_state.dart';
import 'package:mobileapp_roadreport/features/profile/models/model/profile_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class HomeProvider with ChangeNotifier {
  // Data untuk mengecek apakah user sudah login atau belum
  bool isLoggedIn = false;

  // State untuk handle loading screen
  MyState state = MyState.loading;
  MyState headingState = MyState.loading;

  // Ini Data User yang login, jadi bisa dipakai untuk mengambil nama dan foto di home
  Data user = Data();

  // Data sementara untuk drafting foto
  List<String> draft = [];
  List<String> lat = [];
  List<String> lng = [];
  List<String> timestamp = [];

  // Set untuk foto draft kedalam Shared Preference
  Future<void> setDraft() async {
    final pref = await SharedPreferences.getInstance();

    if (!pref.containsKey("draft")) {
      pref.setStringList("draft", []);
      pref.setStringList("lat", []);
      pref.setStringList("lng", []);
      pref.setStringList("timestamp", []);
    }
    draft = pref.getStringList("draft")!;
    lat = pref.getStringList("lat")!;
    lng = pref.getStringList("lng")!;
    timestamp = pref.getStringList("timestamp")!;
    notifyListeners();
  }

  Future<void> getData(BuildContext context) async {
    headingState = MyState.loading;
    notifyListeners();

    try {
      final response = await HomeService().userEndPoint();

      user = response.data!;

      headingState = MyState.loaded;
      notifyListeners();
    } catch (e) {
      headingState = MyState.failed;
      notifyListeners();
    }
  }

  // Pengecekean Page login atau belum
  Future<bool> buildPage(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    state = MyState.loading;
    notifyListeners();

    try {
      if (prefs.getKeys().isNotEmpty) {
        if (prefs.getBool('isLoggedIn')!) {
          if (!JwtDecoder.isExpired(prefs.getString('jwtToken')!)) {
            isLoggedIn = true;

            state = MyState.loaded;
            notifyListeners();

            return true;
          } else {
            prefs.remove("token");
            prefs.remove("jwtToken");
            prefs.remove("uid");
            prefs.remove("id");
            prefs.remove("gid");
            prefs.setBool("isLoggedIn", false);
            isLoggedIn = false;

            state = MyState.failed;
            notifyListeners();

            return false;
          }
        } else {
          isLoggedIn = false;
          state = MyState.failed;
          notifyListeners();
          return false;
        }
      } else {
        isLoggedIn = false;
        state = MyState.failed;
        notifyListeners();
        return false;
      }
    } catch (e) {
      isLoggedIn = false;
      state = MyState.failed;
      notifyListeners();
      return false;
    }
  }

  // Fungsi untuk delete draft dari shared preference
  Future<void> deleteDraft(int index) async {
    final pref = await SharedPreferences.getInstance();

    if (pref.getStringList("draft")!.length == 1) {
      await File(draft[index]).delete();
      await DefaultCacheManager().removeFile(draft[index]);

      draft.removeAt(index);
      lat.removeAt(index);
      lng.removeAt(index);
      timestamp.removeAt(index);

      await pref.setStringList("draft", draft);
      await pref.setStringList("lat", lat);
      await pref.setStringList("lng", lng);
      await pref.setStringList("timestamp", timestamp);

      final cacheDir = await getTemporaryDirectory();

      if (cacheDir.existsSync()) {
        cacheDir.deleteSync(recursive: true);
      }
      final appDir = await getApplicationSupportDirectory();

      if (appDir.existsSync()) {
        appDir.deleteSync(recursive: true);
      }
    } else {
      await File(draft[index]).delete();
      await DefaultCacheManager().removeFile(draft[index]);

      draft.removeAt(index);
      lat.removeAt(index);
      lng.removeAt(index);
      timestamp.removeAt(index);

      await pref.setStringList("draft", draft);
      await pref.setStringList("lat", lat);
      await pref.setStringList("lng", lng);
      await pref.setStringList("timestamp", timestamp);
    }

    notifyListeners();
  }

  Future<void> deleteDraft7() async {
    List<String> timeDelete = [];
    await setDraft();
    for (var i = 0; i < draft.length; i++) {
      int days = 0;

      days = formatTimeDifference(DateTime.now(), DateTime.parse(timestamp[i]));
      if (days >= 7) {
        timeDelete.add(timestamp[i]);
      }
    }

    for (var i = 0; i < timeDelete.length; i++) {
      for (var j = 0; j < timestamp.length; j++) {
        if (timestamp[j] == timeDelete[i]) {
          await deleteDraft(j);
          notifyListeners();
        }
      }
    }
    await setDraft();
    notifyListeners();
  }

  // Date Time Format untuk mengecek apakah draft sudah 7 hari atau belum
  int formatTimeDifference(DateTime startDate, DateTime endDate) {
    Duration difference = startDate.isBefore(endDate)
        ? endDate.difference(startDate)
        : startDate.difference(endDate);

    final days = difference.inDays;
    // final minutes = difference.inMinutes % 60;

    return days;
  }

  // --------------------------------- Draft Laporan
  // RoutePoint
  List<LatLng> routpoints = [const LatLng(-7.9467136, 112.6156684)];

  // Service
  final addLaporanServices = AddLaporanService();
  final homeService = HomeService();

  // Data Sementara
  String tipeKerusakan = '';
  String jenisKerusakan = '';
  List<String> image = [];
  List<FotoModel> fotoModel = [];

  // Form Key
  final formKey = GlobalKey<FormState>();

  // Long lat
  double? latitude;
  double? longitude;

  // Index untuk Halaman
  int currentIndex = 0;

  MapController mapController = MapController();

  // Polyline yang berwarna biasa
  List<TaggedPolyline> polylines = [];

  // Polyline yang berwarna gelap
  List<TaggedPolyline> activePolylines = [];

  // Polyline yang tidak aktif
  List<Polyline> deactivePolyline = [];

  // Id Polyline yang telah diselect
  List<String> selectedPolylines = [];

  // Data Show  untuk menampilkan informasi indexing dari tahap pelaporan
  List<Map<String, dynamic>> data = [
    {
      'icon': FeatherIcons.mapPin,
      'title': 'Titik Lokasi',
      'description':
          'Pilih segmen jalan dari draft foto yang telah diambil sebelumnya',
    },
    {
      'icon': FeatherIcons.fileText,
      'title': 'Lengkapi Data Laporan',
      'description': 'Isikan keterangan keadaan jalan sekarang ',
    },
  ];

  // Data isian segmen yang dapat tampil
  List<SegmenModel> listSegmen = [];

  // State untuk foto loading
  MyState fotoState = MyState.initial;

  // Deklarasi Laporan Model
  LaporanModel laporan = LaporanModel();

  // Text Controller dari inputan keterangan
  final TextEditingController keteranganController = TextEditingController();

  // Fungsi untuk update index tahapan laporan
  void updateIndex(int index) {
    currentIndex = index;

    notifyListeners();
  }

  // Fungsi untuk melakukan add laporan kedalam database
  Future<bool> addLaporan({
    required BuildContext context,
    required index,
  }) async {
    state = MyState.loading;
    notifyListeners();

    try {
      await addLaporanServices.addLaporan(
        keteranganController.text,
        listSegmen,
      );

      if (context.mounted) {
        deleteDraft(index);

        refreshSegmen();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(
                  FeatherIcons.checkCircle,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(child: Text('Sukses, laporan berhasil ditambahkan.')),
              ],
            ),
            backgroundColor: AppColors.success500,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      state = MyState.loaded;
      notifyListeners();

      return true;
    } catch (e) {
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(
                FeatherIcons.xCircle,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  'Maaf, terjadi kesalahan saat menambahkan laporan.',
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.error500,
          behavior: SnackBarBehavior.floating,
        ),
      );

      state = MyState.failed;
      notifyListeners();

      return false;
    }
  }

  // -------------------------------- Set Data Segmen
  // Fungso untuk mengeset seluruh polyline
  Future<void> setPolyline(
    BuildContext context,
    int index,
  ) async {
    state = MyState.loading;
    notifyListeners();

    polylines.clear();
    activePolylines.clear();
    deactivePolyline.clear();

    try {
      await getLocationData(
          double.tryParse(lat[index])!, double.tryParse(lng[index])!);
      await setFirstPolyline();
      await setActivePolyline();
      await setDeactivePolyline();

      state = MyState.loaded;
      notifyListeners();
    } catch (e) {
      state = MyState.failed;
      notifyListeners();
    }
  }

  // Fungsi untuk mengeset polyline secara keseluruhan
  Future<void> setFirstPolyline() async {
    try {
      // final segmenData = await addLaporanServices.getSegmen(); // Get All Segmen
      final segmenData = await homeService.getSegmenDraftWithLatLong(
        latitude!,
        longitude!,
      ); // Get Segmen with radius

      List<TaggedPolyline> polylinesList = [];

      for (var segmen in segmenData) {
        String geoJsonString = segmen.geojson!;

        // Mendekode geojson menjadi objek GeoJsonModel
        GeoJsonModel geoJsonModel = geoJsonModelFromJson(geoJsonString);

        try {
          // Pengecekan apakah geoJsonModel memiliki tipe LineString
          if (geoJsonModel.type == "LineString") {
            if (segmen.report == null ||
                segmen.report!.report == null ||
                segmen.report!.report!.statusId == 'DONE' ||
                segmen.report!.report!.statusId == 'RJT') {
              // Mengambil koordinat dari geoJsonModel
              List<LatLng> points = [];
              List<List<double>> coordinates = geoJsonModel.coordinates;

              // Membentuk daftar titik LatLng
              for (List<double> coordinate in coordinates) {
                double lat = coordinate[1];
                double lng = coordinate[0];
                points.add(LatLng(lat, lng));
              }

              // Membuat TaggedPolyline dengan informasi yang sesuai
              TaggedPolyline polyline = TaggedPolyline(
                tag: '${segmen.id}+${segmen.name}',
                points: points,
                color: AppColors.primary500.withOpacity(0.3),
                borderColor: AppColors.primary500,
                strokeWidth: 6,
                borderStrokeWidth: 2,
              );

              polylinesList.add(polyline);
            }
          }
        } catch (e) {
          rethrow;
          // state = MyState.failed;
          // notifyListeners();
        }
      }

      polylines = polylinesList;
    } catch (e) {
      rethrow;
      // state = MyState.failed;
      // notifyListeners();
    }
  }

  // Fungsi untuk menambahkan segmen yang sedang aktif dan dapat dipilih
  Future<void> setActivePolyline() async {
    try {
      // final segmenData = await addLaporanServices.getSegmen(); // Get All Segmen
      final segmenData = await homeService.getSegmenDraftWithLatLong(
        latitude!,
        longitude!,
      ); // Get Segmen with radius

      List<TaggedPolyline> polylinesList = [];

      for (var segmen in segmenData) {
        String geoJsonString = segmen.geojson!;

        // Mendekode geojson menjadi objek GeoJsonModel
        GeoJsonModel geoJsonModel = geoJsonModelFromJson(geoJsonString);

        try {
          // Pengecekan apakah geoJsonModel memiliki tipe LineString
          if (geoJsonModel.type == "LineString") {
            if (segmen.report == null ||
                segmen.report!.report == null ||
                segmen.report!.report!.statusId == 'DONE' ||
                segmen.report!.report!.statusId == 'RJT') {
              // Mengambil koordinat dari geoJsonModel
              List<LatLng> points = [];
              List<List<double>> coordinates = geoJsonModel.coordinates;

              // Membentuk daftar titik LatLng
              for (List<double> coordinate in coordinates) {
                double lat = coordinate[1];
                double lng = coordinate[0];
                points.add(LatLng(lat, lng));
              }

              // Membuat TaggedPolyline dengan informasi yang sesuai
              TaggedPolyline polyline = TaggedPolyline(
                tag: '${segmen.id}+${segmen.name}',
                points: points,
                color: AppColors.primary500,
                borderColor: AppColors.primary500,
                strokeWidth: 6,
                borderStrokeWidth: 2,
              );

              polylinesList.add(polyline);
            }
          }
        } catch (e) {
          rethrow;
          // state = MyState.failed;
          // notifyListeners();
        }
      }
      activePolylines = polylinesList;
    } catch (e) {
      rethrow;
      // state = MyState.failed;
      // notifyListeners();
    }
  }

  // Fungsi untuk menambahkan segmen yang tidak aktif dan tidak dapat dipilih
  Future<void> setDeactivePolyline() async {
    try {
      // final segmenData = await addLaporanServices.getSegmen(); // Get All Segmen
      final segmenData = await homeService.getSegmenDraftWithLatLong(
        latitude!,
        longitude!,
      ); // Get Segmen with radius

      List<Polyline> polylinesList = [];

      for (var segmen in segmenData) {
        String geoJsonString = segmen.geojson!;

        // Mendekode geojson menjadi objek GeoJsonModel
        GeoJsonModel geoJsonModel = geoJsonModelFromJson(geoJsonString);

        try {
          // Pengecekan apakah geoJsonModel memiliki tipe LineString
          if (geoJsonModel.type == "LineString") {
            if (segmen.report != null) {
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

                  Polyline polyline = Polyline(
                    points: points,
                    borderStrokeWidth: 2,
                    borderColor: Colors.grey,
                    color: Colors.grey.withOpacity(0.6),
                    strokeWidth: 6,
                  );

                  polylinesList.add(polyline);
                }
              }
            }
          }
        } catch (e) {
          rethrow;
          // state = MyState.failed;
          // notifyListeners();
        }
      }

      deactivePolyline = polylinesList;
    } catch (e) {
      rethrow;
      // state = MyState.failed;
      // notifyListeners();
    }
  }

  // Fungsi untuk mengeset location data center (dari gambar)
  Future<void> getLocationData(double lat, double long) async {
    latitude = lat;
    longitude = long;

    notifyListeners();
  }

  // Fungsi delete polyline yang dipilih
  Future<void> deleteSelectedPolyline(String idPolyline) async {
    selectedPolylines.remove(idPolyline);

    listSegmen.removeWhere((segmen) => segmen.id == idPolyline);

    notifyListeners();
  }

  // Fungsi untuk menambahkan selected polyline
  void addSelectedPolyline(String idPolyline) {
    if (!selectedPolylines.contains(idPolyline)) {
      selectedPolylines.add(idPolyline);
    } else {
      selectedPolylines.remove(idPolyline);
    }

    notifyListeners();
  }

  // Fungsi untuk melakukan refresh dari seluruh data segmen
  void refreshSegmen() {
    image.clear();
    fotoModel.clear();
    jenisKerusakan = '';
    tipeKerusakan = '';
    selectedPolylines.clear();

    listSegmen.clear();
    keteranganController.clear();

    notifyListeners();
  }

  // Fungsi untuk menambahkan data sementara segmen
  Future<void> addSegmen(
    String idPolyline,
    String namaJalan,
    String jenisKerusakan,
    String tipeKerusakan,
    List<String> fotoJalan,
    List<FotoModel> fotoModel,
  ) async {
    SegmenModel segmen = SegmenModel();

    segmen.id = idPolyline;
    segmen.namaJalan = namaJalan;
    segmen.jenisKerusakan = '-';
    segmen.tipeKerusakan = '-';
    segmen.foto!.addAll(fotoJalan);
    segmen.fotoModel!.addAll(fotoModel);

    listSegmen.add(segmen);

    image.clear();
    fotoModel.clear();
    this.jenisKerusakan = '';
    this.tipeKerusakan = '';

    notifyListeners();
  }

  // Fungsi untuk menambahkan gambar kedalam database
  Future<void> addImage(BuildContext context, File imageFile) async {
    fotoState = MyState.loading;
    notifyListeners();

    try {
      final File finishedFile = await compressImage(imageFile);

      final imageResponse =
          await addLaporanServices.uploadImage(finishedFile.path);

      image.add(finishedFile.path);

      fotoModel.add(
        FotoModel(
          filename: imageResponse.data!.filename!,
          absPath: imageResponse.data!.absPath!,
          fileDumpId: imageResponse.data!.id!,
        ),
      );

      fotoState = MyState.loaded;
      notifyListeners();
    } catch (e) {
      fotoState = MyState.initial;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(
                FeatherIcons.xCircle,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  'Maaf, terjadi kesalahan saat menambahkan gambar.',
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.error500,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    notifyListeners();
  }

  // Fungsi validasi isian input keterangan
  String? validateKeterangan(String? value) {
    if (value!.isEmpty) {
      return 'Keterangan tidak boleh kosong';
    }

    return null;
  }

  // Fungsi untuk melakukan compress image
  Future<File> compressImage(File croppedFile) async {
    var fileFromImage = File(croppedFile.path);
    var basename = path.basenameWithoutExtension(fileFromImage.path);
    var pathString =
        fileFromImage.path.split(path.basename(fileFromImage.path))[0];

    var pathStringWithExtension = "$pathString${basename}_image.jpg";

    int maxFileSizeInBytes = 1000000; // 2 MB
    int currentFileSize = await croppedFile.length();
    int quality = 90;

    File compressedFiles;

    compressedFiles = croppedFile;

    while (currentFileSize > maxFileSizeInBytes) {
      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        croppedFile.absolute.path,
        pathStringWithExtension,
        quality: quality,
      );

      currentFileSize = await compressedFile!.length();
      quality -= 10; // Decrease quality by 10 each iteration (adjust as needed)

      compressedFiles = File(compressedFile.path);
    }

    return compressedFiles;
  }
}
