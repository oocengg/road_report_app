import 'package:dio/dio.dart';
import 'package:mobileapp_roadreport/core/constants/app_constant.dart';
import 'package:mobileapp_roadreport/core/interceptor/dio_interceptor.dart';

class DioWithInterceptor {
  late final Dio dioWithInterceptor;

  DioWithInterceptor() {
    dioWithInterceptor = Dio(
      BaseOptions(
        baseUrl: AppConstant.baseUrl,
      ),
    );

    dioWithInterceptor.interceptors.add(DioInterceptor());
  }
}
