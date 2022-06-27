
import 'package:dio/dio.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:easy_localization/easy_localization.dart';
class InternetCheckerInterceptor extends Interceptor {

 @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if(err.response?.statusCode==null){
  AppUtil.flushbarNotification('There_is_no_internet_Connection'.tr());
    }

    super.onError(err, handler);
  }
 
}