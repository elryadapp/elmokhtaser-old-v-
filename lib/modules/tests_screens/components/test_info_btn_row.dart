import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TestInfoBtnRow extends StatelessWidget {
  final String title;
  final String info;
  final String secTitle;
  final String secInfo;
  const TestInfoBtnRow(
      {Key? key,
      required this.title,
      required this.info,
      required this.secTitle,
      required this.secInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Card(
          color: AppUi.colors.whiteColor,
          child: Padding(
            padding: EdgeInsets.all(2.h),
            child: Row(
              children: [
                AppText('$title : '),
                AppText(
                  info,
                  textOverflow: TextOverflow.ellipsis,
                  color: AppUi.colors.mainColor,
                )
              ],
            ),
          ),
        )),
        SizedBox(
          width: 3.w,
        ),
        Expanded(
            child: Card(
          child: Padding(
            padding: EdgeInsets.all(2.h),
            child: Row(
              children: [
                AppText('$secTitle : '),
                AppText(
                  secInfo,
                  color: AppUi.colors.mainColor,
                )
              ],
            ),
          ),
        ))
      ],
    );
  }
}
