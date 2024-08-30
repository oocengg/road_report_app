import 'package:flutter/material.dart';
import 'package:mobileapp_roadreport/features/history/models/service/history_service.dart';

import '../../../core/state/finite_state.dart';
import '../models/model/history_response.dart';

class HistoryProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController searchController = TextEditingController();
  int currentPage = 1;
  bool filtered = false;
  String id = "";
  int totalItem = 0;

  MyState state = MyState.initial;
  // Inisiasi variabel
  List<Datum> history = [];
  List<Photo> segmen = [];

  // Fungsi fungsi untuk mengedit variabel
  void resetCurrentPage() {
    currentPage = 1;
    notifyListeners();
  }

  void addCurrentPage() {
    currentPage++;
    notifyListeners();
  }

  void setFiltered(bool cek) {
    filtered = cek;
    notifyListeners();
  }

  void setId(String setid) {
    id = setid;
    notifyListeners();
  }

  // Fungsi untuk mengambil list dari history laporan user
  Future<void> getData(BuildContext context) async {
    if (currentPage == 1) {
      state = MyState.loading;
      notifyListeners();
    }

    try {
      searchController.clear();

      final response = await HistoryService().historyEndPoint(currentPage);

      totalItem = HistoryResponse.fromJson(response).total!;

      // Cek apakah data sudah limit
      if (currentPage == 1) {
        history = HistoryResponse.fromJson(response).data!;
      } else {
        List<Datum> historyResponse = HistoryResponse.fromJson(response).data!;

        history.addAll(historyResponse);
      }

      state = MyState.loaded;
      notifyListeners();
    } catch (e) {
      state = MyState.failed;
      notifyListeners();
    }
  }

  // Fungsi untuk mengambil list history laporan sesuai dengan pencarian user
  Future<void> search(BuildContext context) async {
    state = MyState.loading;
    notifyListeners();

    resetCurrentPage();

    try {
      final response = await HistoryService()
          .historySearchEndPoint(searchController.text, currentPage);

      history = HistoryResponse.fromJson(response).data!;

      state = MyState.loaded;
      notifyListeners();
    } catch (e) {
      state = MyState.failed;
      notifyListeners();
    }
  }

  // Fungsi untuk memfilter list history laporan user berdasarkan status laporan
  Future<void> filter(BuildContext context) async {
    if (currentPage == 1) {
      state = MyState.loading;
      notifyListeners();
    }

    try {
      final response =
          await HistoryService().historyFilterEndPoint(id, currentPage);

      totalItem = HistoryResponse.fromJson(response).total!;

      if (currentPage == 1) {
        history = HistoryResponse.fromJson(response).data!;
      } else {
        List<Datum> historyResponse = HistoryResponse.fromJson(response).data!;

        history.addAll(historyResponse);
      }

      state = MyState.loaded;
      notifyListeners();
    } catch (e) {
      state = MyState.failed;
      notifyListeners();
    }
  }
}
