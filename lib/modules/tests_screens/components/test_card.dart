import 'package:elmoktaser_elshamel/models/general_exams_model.dart';
import 'package:elmoktaser_elshamel/modules/tests_screens/components/text_icon.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:elmoktaser_elshamel/shared/utilities/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';
class TestCard extends StatelessWidget {
  final GeneralExams examItem;
  final GeneralExamsChilds childs; 
  const TestCard({Key? key, required this.examItem, required this.childs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Card(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 2.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         AppUtil.appCachedImage( imgUrl: AppUi.assets.networkImageBaseLink+childs.image!,
                width: 30.w,
                height: 10.h,),
            Expanded(
                child: Padding(
              padding: EdgeInsetsDirectional.only(start: 3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   AppText(
                     childs.title!
                    ,
                    fontWeight: FontWeight.w600,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    child: Row(
                      children: [
                       AppTextIcon(
                              title:examItem.attemps!>10? '${examItem.attemps}\t'+'attempt'.tr():'${examItem.attemps}\t'+'tries'.tr(),
                              icon: Icon(Icons.restart_alt_outlined,color: AppUi.colors.mainColor,)),
                      
                        SizedBox(
                          width: 2.w,
                        ),
                         AppTextIcon(
                          title: '${examItem.examTime}\t'+'minute'.tr(),
                          icon: Icon(
                            Icons.access_time_rounded,
                            size: 2.5.h,
                            color: AppUi.colors.mainColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppTextIcon(
                    icon:Icon(IconBroken.Document,color: AppUi.colors.mainColor,),
                    title:examItem.questionsNumber!<10?'${examItem.questionsNumber}\t'+'questions'.tr() :'${examItem.questionsNumber}\t'+'question'.tr(),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
