import 'package:elmoktaser_elshamel/models/courses_model.dart';
import 'package:elmoktaser_elshamel/modules/layout_screens/personal_courses_screens/components/progress_course_card.dart';
import 'package:elmoktaser_elshamel/shared/components/animated_list_handler.dart';
import 'package:elmoktaser_elshamel/shared/components/animated_page.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
class FinishedCourses extends StatelessWidget {
  final List<CoursesItem> finishedCourseList;
  const FinishedCourses({Key? key, required this.finishedCourseList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return finishedCourseList.isEmpty? 
    Column(
      children: [
           AppSlideAnimation(
             verticalOffset: -150,
             horizontalOffset: 0,
      child: AppUtil.emptyLottie(),
    ),
       AppSlideAnimation(
       verticalOffset: 150,
                    horizontalOffset: 0,

      child: AppText('finished_couses_alert'.tr()),
    )
      ],
    )
    :AnimatedListHandler(
        children: List.generate(
            finishedCourseList.length,
            (index) => ProgressCourseCard(
                  coursesItem: finishedCourseList[index],
                )));
  }
}
