import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tappable_polyline/flutter_map_tappable_polyline.dart';
import 'package:image/image.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobileapp_roadreport/core/keys/navigator_key.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/services/location_service.dart';
import 'package:mobileapp_roadreport/core/state/finite_state.dart';
import 'package:mobileapp_roadreport/features/add_laporan/models/model/foto_model.dart';
import 'package:mobileapp_roadreport/features/add_laporan/models/model/geojson_model.dart';
import 'package:mobileapp_roadreport/features/add_laporan/models/model/laporan_model.dart';
import 'package:mobileapp_roadreport/features/add_laporan/models/model/segmen_model.dart';
import 'package:mobileapp_roadreport/features/add_laporan/models/service/add_laporan_service.dart';
import 'package:mobileapp_roadreport/features/history/provider/history_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class AddLaporanProvider with ChangeNotifier {
  // Form Key
  final formKey = GlobalKey<FormState>();

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

  // State
  MyState state = MyState.loading;
  MyState stateAI = MyState.initial;

  // Long lat
  double? latitude;
  double? longitude;

  //Randomize
  String? jenisRandom;
  String? tingkatRandom;
  Random random = Random();

  // Service Location
  final serviceLocation = LocationService();

  bool locationOn = false;

  // RoutePoint
  List<LatLng> routpoints = [const LatLng(-7.9467136, 112.6156684)];

  final TextEditingController keteranganController = TextEditingController();

  // Data Sementara
  String tipeKerusakan = '';
  String jenisKerusakan = '';
  List<String> image = [];
  List<FotoModel> fotoModel = [];

  // Data Sementara
  bool isCropped = false;

  // Service
  final addLaporanServices = AddLaporanService();

  // Data Bar diatas Add Laporan
  List<Map<String, dynamic>> data = [
    {
      'icon': FeatherIcons.mapPin,
      'title': 'Titik Lokasi',
      'description':
          'Anda bisa memilih beberapa segmen jalan, dengan upload data pada setiap segmen nantinya. Jika sudah bisa klik “Lanjutkan”',
    },
    {
      'icon': FeatherIcons.fileText,
      'title': 'Lengkapi Data Laporan',
      'description': 'Isikan keterangan keadaan jalan sekarang ',
    },
  ];

  List<SegmenModel> listSegmen = [];

  LaporanModel laporan = LaporanModel();
  // -------------------------------- AI Checker
  // -------------------------------- Test AI Service
  CancelToken cancelToken = CancelToken();
  String buah = '';

  // Fungsi untuk resize gambar
  Future<File> resizeImage(File file) async {
    var image = decodeImage(file.readAsBytesSync());

    // Resize gambar ke 224x224
    var resizedImage = copyResize(image!, width: 224, height: 224);

    // Menyimpan gambar yang sudah diresize ke direktori yang sama
    File resizedFile = File(file.path)
      ..writeAsBytesSync(encodeJpg(resizedImage));

    return resizedFile;
  }

  // AI Kerusakan (Tidak Dipakai)

  // Randomize Jenis Kerusakan
  String randomizeJenisKerusakan(List<String> jenisKerusakan) {
    // Memilih secara acak jenis kerusakan dan tingkat kerusakan
    String randomJenis = jenisKerusakan[random.nextInt(jenisKerusakan.length)];

    // Mengembalikan hasil dalam format yang diinginkan
    return randomJenis;
  }

  String randomizeTingkaiKerusakan(List<String> tingkatKerusakan) {
    String randomTingkat =
        tingkatKerusakan[random.nextInt(tingkatKerusakan.length)];

    // Mengembalikan hasil dalam format yang diinginkan
    return randomTingkat;
  }

  Future<void> checkAIKerusakan() async {
    stateAI = MyState.loading;
    notifyListeners();

    jenisRandom = '';
    tingkatRandom = '';

    try {
      // Randomize
      List<String> jenisKerusakan = [
        'Bergelombang',
        'Berlubang',
        'Retak',
        'Terkelupas',
      ];
      List<String> tingkatKerusakan = [
        'Parah',
        'Sedang',
        'Ringan',
      ];

      jenisRandom = randomizeJenisKerusakan(jenisKerusakan);
      tingkatRandom = randomizeJenisKerusakan(tingkatKerusakan);

      await Future.delayed(const Duration(seconds: 3));

      stateAI = MyState.loaded;
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
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
                  'Maaf, terjadi kesalahan saat memulai AI.',
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.error500,
          behavior: SnackBarBehavior.floating,
        ),
      );
      stateAI = MyState.failed;
      notifyListeners();
    }
  }

  void setSkalaKerusakan() {
    jenisKerusakan = jenisRandom ?? '-';
    tipeKerusakan = tingkatRandom ?? '-';

    notifyListeners();
  }

  // -------------------------------- Set Data Segmen
  Future<void> setPolyline(BuildContext context) async {
    state = MyState.loading;
    notifyListeners();

    polylines.clear();
    activePolylines.clear();
    deactivePolyline.clear();

    try {
      await getLocationData(context: context);
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

  Future<void> setFirstPolyline() async {
    try {
      // final segmenData = await addLaporanServices.getSegmen(); // Get All Segmen
      final segmenData = await addLaporanServices.getSegmenWithLatLong(
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
        }
      }

      polylines = polylinesList;
    } catch (e) {
      rethrow;
    }
  }

  // Setting Polyline yang Aktif dan dapat dipilih untuk dilaporkan
  Future<void> setActivePolyline() async {
    try {
      // final segmenData = await addLaporanServices.getSegmen(); // Get All Segmen
      final segmenData = await addLaporanServices.getSegmenWithLatLong(
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

  // Setting Polyline yang tidak aktif disable tidak dapat dilaporkan
  Future<void> setDeactivePolyline() async {
    try {
      // final segmenData = await addLaporanServices.getSegmen(); // Get All Segmen
      final segmenData = await addLaporanServices.getSegmenWithLatLong(
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
        }
      }

      deactivePolyline = polylinesList;
    } catch (e) {
      rethrow;
    }
  }

  // -------------------------------- Other Function

  // Set Status Crop Image done or not
  void cropImage() {
    isCropped = !isCropped;
    notifyListeners();
  }

  // Hit Service untuk menambahkan laporan ke database
  Future<bool> addLaporan({
    required BuildContext context,
  }) async {
    state = MyState.loading;
    notifyListeners();

    try {
      await addLaporanServices.addLaporan(
        keteranganController.text,
        listSegmen,
      );

      if (context.mounted) {
        refreshSegmen();

        context.read<HistoryProvider>().resetCurrentPage();

        context.read<HistoryProvider>().getData(context);

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

  // Function untuk menambahkan segmen kedalam provider menjadi segmen yang terpilih
  void addSegmen(
    String idPolyline,
    String namaJalan,
    String jenisKerusakan,
    String tipeKerusakan,
    List<String> fotoJalan,
    List<FotoModel> fotoModel,
  ) {
    SegmenModel segmen = SegmenModel();

    segmen.id = idPolyline;
    segmen.namaJalan = namaJalan;
    segmen.jenisKerusakan = jenisKerusakan;
    segmen.tipeKerusakan = tipeKerusakan;
    segmen.foto!.addAll(fotoJalan);
    segmen.fotoModel!.addAll(fotoModel);

    listSegmen.add(segmen);

    image.clear();
    fotoModel.clear();
    this.jenisKerusakan = '';
    this.tipeKerusakan = '';

    notifyListeners();
  }

  // Function untuk mereset seluruh segmen yang terpilih
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

  // Menambahkan Polyline yang telah di select
  void addSelectedPolyline(String idPolyline) {
    if (!selectedPolylines.contains(idPolyline)) {
      selectedPolylines.add(idPolyline);
    } else {
      selectedPolylines.remove(idPolyline);
    }

    notifyListeners();
  }

  // Menghapus Polyline yang telah di select
  Future<void> deleteSelectedPolyline(String idPolyline) async {
    selectedPolylines.remove(idPolyline);

    listSegmen.removeWhere((segmen) => segmen.id == idPolyline);

    notifyListeners();
  }

  // Mengedit Laporan yang telah dibuat sebelum di submit
  Future<void> editLaporan(int index) async {
    listSegmen[index].foto!.clear();
    listSegmen[index].fotoModel!.clear();

    listSegmen[index].foto!.addAll(image);
    listSegmen[index].fotoModel!.addAll(fotoModel);
    listSegmen[index].jenisKerusakan = jenisKerusakan;
    listSegmen[index].tipeKerusakan = tipeKerusakan;

    notifyListeners();
  }

  // Function get lokasi device
  Future<void> getLocationData({required BuildContext context}) async {
    locationOn = false;

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
        locationOn = true;
        updateRoutePoint(location.latitude, location.longitude);

        await setFirstPolyline();
        await setActivePolyline();
        await setDeactivePolyline();

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

  // Fungsi update route point awal saat halaman dibuka
  void updateRoutePoint(double latitude, double longitude) {
    routpoints.clear();

    routpoints.add(LatLng(latitude, longitude));
  }

  void setJenisKerusakan(String value) {
    jenisKerusakan = value;

    notifyListeners();
  }

  void setTipeKerusakan(String value) {
    tipeKerusakan = value;

    notifyListeners();
  }

  // Fungsi update index saat melaporkan
  void updateIndex(int index) {
    currentIndex = index;

    notifyListeners();
  }

  // Fungsi untuk menambahkan gambar kedalam database
  Future<void> addImage(BuildContext context, File imageFile) async {
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
    } catch (e) {
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

  // AI pengecekan apakah itu gambar atau bukan
  Future<String> checkImageRoad(BuildContext context, File imageFile) async {
    try {
      final File finishedFile = await compressImage(imageFile);

      final imageResponse =
          await addLaporanServices.checkAiRoadChecker(finishedFile.path);

      String roadTest = '';

      print('AI ----------------------- ${imageResponse.predictedLabel}');

      if (context.mounted) {
        imageResponse.predictedLabel == 'ROAD'
            ? roadTest = 'road'
            : roadTest = 'not-road';
      }

      return roadTest;
    } catch (e) {
      return 'error';
    }
  }

  // Function untuk menghapus image yang telah ditambahkan
  void removeImage(int index) {
    if (index >= 0 && index < image.length) {
      image.removeAt(index);
      fotoModel.removeAt(index);
      notifyListeners();
    }
  }

  // Function validasi keterangan pada inputan
  String? validateKeterangan(String? value) {
    if (value!.isEmpty) {
      return 'Keterangan tidak boleh kosong';
    }

    return null;
  }
}

// Compresser image
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
