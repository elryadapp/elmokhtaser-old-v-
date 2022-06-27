import 'package:elmoktaser_elshamel/shared/components/app_btn.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/constants.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart'as tr;

class NextPrevBtnRow extends StatelessWidget {
  final Function() onTap;
  final Color color;
  final String title;
  final IconData icon;
  const NextPrevBtnRow(
      {Key? key,
      required this.onTap,
      required this.color,
      required this.title,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onTap: onTap,
      

      height: 6.h,
      width: 42.w,
      color: color,
     
      titleWidget: Directionality(
textDirection:title=='perivious'.tr() &&Constants.lang=='ar'?TextDirection.ltr:TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              title,
              color: AppUi.colors.whiteColor,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              width: 2.w,
            ),
            Icon(
              icon,
              color: AppUi.colors.whiteColor,
              size: 2.5.h,
            )
          ],
        ),
      ),
    );
  }
}
