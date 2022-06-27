import 'package:elmoktaser_elshamel/modules/tests_screens/components/test_info_btn_row.dart';
import 'package:elmoktaser_elshamel/modules/tests_screens/components/text_icon.dart';
import 'package:elmoktaser_elshamel/routes/app_routes.dart';
import 'package:elmoktaser_elshamel/shared/components/app_app_bar.dart';
import 'package:elmoktaser_elshamel/shared/components/app_btn.dart';
import 'package:elmoktaser_elshamel/shared/constants.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:elmoktaser_elshamel/shared/utilities/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sizer/sizer.dart';

class SingleTestInfoScreen extends StatelessWidget {
  final dynamic childList;

  const SingleTestInfoScreen({Key? key, required this.childList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ElmoktaserAppbar(
        context,
        isLeading: true,
        titleText: ' ',
        actions: const [],
      ),
      body: Padding(
        padding: EdgeInsets.all(2.h),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                AppUi.assets.fakeCourseImg,
                height: Constants.getHeight(context) * .25,
                width: Constants.getwidth(context),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: AppTextIcon(
                  title: childList.title!,
                  fontWeight: FontWeight.w600,
                  icon: Icon(IconBroken.Document,color: AppUi.colors.mainColor,)),
            ),
            TestInfoBtnRow(
                title: 'department'.tr(),
                info: childList.parent!.titleAr!,
                secTitle: 'question_count'.tr(),
                secInfo: '${childList.exams![0].questionsNumber}'),
            TestInfoBtnRow(
                title: 'Exam_time'.tr(),
                info: '${childList.exams![0].examTime} د ',
                secTitle: 'tries_count'.tr(),
                secInfo: '${childList.exams![0].attemps}'),
            SizedBox(
              height: 2.h,
            ),
            AppButton(
              title: 'start_now'.tr(),
              onTap: () {
                Navigator.pushNamed(context, Routes.singleTest, arguments: [
                  childList.exams![0].id,
                  childList.exams![0].examTime,
                  false
                ]);
              },
            )
          ],
        ),
      ),
    );
  }
}
