import 'package:get/get.dart';
import 'package:mobileapp_roadreport/core/controller/network_controller.dart';

class DependencyInjection {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}
