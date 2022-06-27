import 'package:elmoktaser_elshamel/models/user_exam_model.dart';
import 'package:elmoktaser_elshamel/modules/general_test_screens/components/test_info_row.dart';
import 'package:elmoktaser_elshamel/routes/app_routes.dart';
import 'package:elmoktaser_elshamel/shared/components/app_btn.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

class GeneralTestCard extends StatelessWidget {
  final UserExamItem generalExamItem;
  const GeneralTestCard({Key? key, required this.generalExamItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(3.h),
        child: Column(
          children: [
            AppText(
              '${generalExamItem.mainCat}',
              color: AppUi.colors.mainColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              height: 2,
            ),
            AppText(
              '(${generalExamItem.level})',
              color: AppUi.colors.mainColor,
              fontSize: 12.sp,
              height: 2,
              fontWeight: FontWeight.w700,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Divider(
                thickness: 2,
                color: AppUi.colors.borderColor.withOpacity(.4),
              ),
            ),
            TestInfoRow(
              count: '${generalExamItem.attemps}\t',
              subTitle: 'tries'.tr(),
              title: 'tries_count'.tr(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: TestInfoRow(
                count: '${generalExamItem.rest}',
                subTitle: 'attempt'.tr(),
                title: 'Attempts_left'.tr(),
              ),
            ),
            Row(
              children: [
                AppText(
                  'Exam_time'.tr(),
                  fontWeight: FontWeight.w600,
                ),
                const Spacer(),
                AppButton(
                  width: 20.w,
                  height: 4.h,
                  color: AppUi.colors.borderColor.withOpacity(.4),
                  title: '${generalExamItem.examTime} '+'m'.tr(),
                  titleColor: AppUi.colors.mainColor,
                )
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              children: [
              if(generalExamItem.rest>0)
                Expanded(
                    child: AppButton(
                      onTap: (){
                         Navigator.pushNamed(context, Routes.singleTest,
                        arguments: [generalExamItem.id,generalExamItem.examTime,true]);
                      },
                  height: 5.h,
                  title: 'make_an_attempt'.tr(),
                )),
                SizedBox(
                  width: 3.w,
                ),
                Expanded(
                    child: AppButton(
                  onTap: () {
                    if(generalExamItem.type=='contest'){
                    Navigator.pushNamed(context, Routes.testTrial,
                        arguments: [null,generalExamItem.id]);
                    }
                    else{
                       Navigator.pushNamed(context, Routes.multiAttemptScreen,
                        arguments: generalExamItem.id);
                    }
                  },
                  height: 5.h,
                  color: AppUi.colors.whiteColor,
                  titleColor: AppUi.colors.mainColor,
                  title: 'attempt_details'.tr(),
                  border: Border.all(color: AppUi.colors.mainColor),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
