import 'package:elmoktaser_elshamel/models/contest_model.dart';
import 'package:elmoktaser_elshamel/modules/general_screens/components/row_btn.dart';
import 'package:elmoktaser_elshamel/routes/app_routes.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

class ContestItemCard extends StatelessWidget {
  final ContestItemModel contestItemModel;
  const ContestItemCard({Key? key, required this.contestItemModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
         Navigator.pushNamed(context,Routes.singleContest,arguments:contestItemModel.id);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.5.h),
        margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.2.h),
        decoration: BoxDecoration(
            color: AppUi.colors.whiteColor,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(blurRadius: 5, color: AppUi.colors.borderColor)
            ]),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  AppUi.assets.contest,
                  height: 12.h,
                  width: 34.w,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        '${contestItemModel.mainCat} (${contestItemModel.level})',
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w600,
                        fontSize: 11.sp,
                      ),
                      SizedBox(
                        height: 1.2.h,
                      ),
                      AppText(
                        'question_number'.tr() +
                            ' : ${contestItemModel.questionsNumber}',
                        textAlign: TextAlign.start,
                        fontSize: 10.sp,
                        color: AppUi.colors.subTitleColor,
                      ),
                         SizedBox(
                        height: 1.2.h,
                      ),
                      AppText(
                        'exam_time'.tr() + ' : ${contestItemModel.examTime}',
                        textAlign: TextAlign.start,
                        fontSize: 10.sp,
                        color: AppUi.colors.subTitleColor,
                      ),
                      SizedBox(
                        height: 1.2.h,
                      ),
                      RowBtn(route: Routes.singleContest,args: contestItemModel.id ,title: 'roll_in_contest'.tr())
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
