import 'package:alert/alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class AppUtil {
  static final RegExp emailValidatorRegExp =
      RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-_]+\.[a-zA-Z0-9-.]+$)");
  static final RegExp phoneValidatorRegExp = RegExp(r'^\+[0-9]{10,}$');
  static Widget appLoader({height}) => Align(
        alignment: Alignment.center,
        child: Lottie.asset(AppUi.assets.loadingLottie, height:height?? 18.h),
      );
        static Widget emptyLottie({height}) => Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding:  EdgeInsets.only(top: 12.h),
          child: Lottie.asset(AppUi.assets.empty, height:height?? 30.h),
        ),
      );

  static bool isLtr(context) =>
      EasyLocalization.of(context)?.currentLocale == const Locale('en')
          ? true
          : false;

  static TextDirection textDirection(context) =>
      EasyLocalization.of(context)?.currentLocale == const Locale('en')
          ? TextDirection.LTR
          : TextDirection.RTL;

  static flushbarNotification( msg) {
    Alert(message: msg ?? '', shortDuration: false,)
        .show();
  }
static Future appDialoge({BuildContext? context,Widget? content,String? title}) async {
  return await showDialog(
      context: context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
     
          title: AppText(title!),
          content: content,
          
        );
      });
}

}
