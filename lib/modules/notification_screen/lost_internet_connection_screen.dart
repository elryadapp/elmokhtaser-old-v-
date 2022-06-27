import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

class LostInernetConnectionScreen extends StatelessWidget {
  const LostInernetConnectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppUtil.emptyLottie(),
            SizedBox(
              height: 2.h,
            ),
            AppText('There_is_no_internet_Connection'.tr())
          ],
        ),
      ),
    );
  }
}
