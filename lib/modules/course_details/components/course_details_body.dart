import 'package:buildcondition/buildcondition.dart';
import 'package:elmoktaser_elshamel/blocs/courses_cubit/courses_cubit.dart';
import 'package:elmoktaser_elshamel/layout/_exports.dart';
import 'package:elmoktaser_elshamel/modules/course_details/components/custom_video.dart';
import 'package:elmoktaser_elshamel/modules/course_details/coures_content_tab.dart';
import 'package:elmoktaser_elshamel/modules/course_details/course_public_bag_tab.dart';
import 'package:elmoktaser_elshamel/modules/course_details/description_tab.dart';
import 'package:elmoktaser_elshamel/modules/course_details/question_answers_tab.dart';
import 'package:elmoktaser_elshamel/modules/course_details/rating_tab.dart';
import 'package:flutter/material.dart';

class CourseDetailsBody extends StatelessWidget {
   final dynamic coursesItem;
  const CourseDetailsBody({Key? key, this.coursesItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesCubit, CoursesState>(
      builder: (context, state) {
        var cubit=CoursesCubit.get(context);
        return BuildCondition(
            condition: state is CheckCourseSubscribtionLoadingState,
            builder: (context) => AppUtil.appLoader(),
            fallback: (context) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                child: Column(
                  children: [
                    CustomVideo(
                      videoId: coursesItem.previewVideo,
                      courseImage: coursesItem.image,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: TabBar(
                            onTap: (index) {
                              cubit.tabIndexChanged();

                              if (index == 1) {
                                cubit.getCoursesContent(coursesItem.id);
                              }
                            },
                            labelColor: AppUi.colors.mainColor,
                            isScrollable: true,
                            physics: const BouncingScrollPhysics(),
                            unselectedLabelColor: AppUi.colors.subTitleColor,
                            labelPadding: EdgeInsets.zero,
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 12.sp),
                            controller: cubit.detailsTabController,
                            tabs: [
                              ...cubit.courseDetailsTabList
                                  .asMap()
                                  .entries
                                  .map((e) => Padding(
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                                start: 10, end: 10),
                                        child: Tab(
                                          text: e.value,
                                        ),
                                      ))
                            ]),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(bottom: 6.h),
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: cubit.detailsTabController,
                        children: [
                          DescriptionTab(courseItem: coursesItem),
                          const CouresContentTab(),
                          QuestionAndAnswersTab(courseItem: coursesItem),
                          CoursePublicBagTab(coursesItem: coursesItem),
                          RatingTab(
                            coursesItem: coursesItem,
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              );
            });
      },
    );
  }
}
