import 'package:buildcondition/buildcondition.dart';
import 'package:elmoktaser_elshamel/blocs/courses_cubit/courses_cubit.dart';
import 'package:elmoktaser_elshamel/modules/personal_couse_details_screen/single_course_body.dart';
import 'package:elmoktaser_elshamel/shared/components/animated_page.dart';
import 'package:elmoktaser_elshamel/shared/components/app_btn.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/constants.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';


class PersonalCourseBody extends StatelessWidget {
  final int courseId;
  const PersonalCourseBody({Key? key, required this.courseId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesCubit, CoursesState>(
      builder: (context, state) {
        var cubit=CoursesCubit.get(context);
        return BuildCondition(
            condition: state is GetCourseContentLoadingState ||
                state is GetSingleCourseLoadingState,
            builder: (context) => AppUtil.appLoader(),
            fallback: (context) {
              return state is GetSingleCourseErrorState
                  ? Container()
                  : cubit.isTableViewed!
                      ? AppSlideAnimation(
                          verticalOffset: 200,
                          horizontalOffset: 0,
                          child: Stack(
                            children: [
                              Html(
                                data: cubit.singleCourse!.courseTable!,
                              ),
                              InkWell(
                                onTap: () {
                                  CoursesCubit.get(context).launchInBrowser(
                                      Uri.parse(
                                          'https://emary.azq1.com/Mo5tsr/table/${cubit.singleCourse!.id}'));
                                },
                                child: Container(
                                  height: Constants.getHeight(context) * .6,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    cubit.changeIsTableViewed();
                                  },
                                  icon: const Icon(Icons.close))
                            ],
                          ))
                      : cubit.singleCourseErrorMsg != null
                          ? Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: AppButton(
                                  title: cubit.singleCourseErrorMsg,
                                ),
                              ),
                            )
                          : cubit.singleCourseContentItem!.isNotEmpty
                              ? SingleCourseBody(courseId: courseId)
                              : Column(
                                  children: [
                                    AppUtil.emptyLottie(),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    AppText(
                                        'there_are_no_content_added_to_this_course_yet'
                                            .tr())
                                  ],
                                );
            });
      },
    );
  }
}
