import 'package:mobileapp_roadreport/features/add_laporan/models/model/foto_model.dart';

class SegmenModel {
  String? id;
  String? namaJalan;
  String? jenisKerusakan;
  String? tipeKerusakan;
  List<String>? foto;
  List<FotoModel>? fotoModel;

  SegmenModel() {
    id = null;
    namaJalan = null;
    jenisKerusakan = null;
    tipeKerusakan = null;
    foto = [];
    fotoModel = [];
  }
}
