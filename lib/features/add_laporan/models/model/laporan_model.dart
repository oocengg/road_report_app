import 'package:mobileapp_roadreport/features/add_laporan/models/model/segmen_model.dart';

class LaporanModel {
  String? id;
  String? keterangan;
  List<SegmenModel>? dataSegmen;

  LaporanModel() {
    id = null;
    keterangan = null;
    dataSegmen = [];
  }
}
