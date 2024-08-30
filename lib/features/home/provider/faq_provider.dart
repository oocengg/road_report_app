import 'package:flutter/material.dart';
import 'package:mobileapp_roadreport/core/state/finite_state.dart';
import 'package:mobileapp_roadreport/features/home/model/models/faq_response_model.dart';
import 'package:mobileapp_roadreport/features/home/model/service/home_service.dart';

class FaqProvider with ChangeNotifier {
  bool isOpen = false;

  MyState state = MyState.loading;

  List<FaqResponseModel> faqData = [];

  HomeService homeService = HomeService();

  // Eksekusi fungsi dari home service untuk ambil FAQ
  void getFaqData({required BuildContext context}) async {
    try {
      state = MyState.loading;
      notifyListeners();

      faqData = await homeService.getFaq();

      state = MyState.loaded;
      notifyListeners();
    } catch (e) {
      state = MyState.failed;
      notifyListeners();
    }
  }

  void updateIsOpen() {
    isOpen = !isOpen;

    notifyListeners();
  }
}
