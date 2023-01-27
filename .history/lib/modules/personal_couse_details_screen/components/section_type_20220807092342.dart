import 'package:elmoktaser_elshamel/blocs/courses_cubit/courses_cubit.dart';
import 'package:elmoktaser_elshamel/models/course_content_model.dart';
import 'package:elmoktaser_elshamel/modules/course_details/components/custom_video.dart';
import 'package:elmoktaser_elshamel/routes/app_routes.dart';
import 'package:elmoktaser_elshamel/shared/components/app_btn.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:easy_localization/easy_localization.dart' as tr;

class SectionType extends StatelessWidget {
  final CourseContentChilds courseContent;
  final String image;
  const SectionType({
    Key? key,
    required this.courseContent,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return courseContent.type == 'video'
        ? CustomVideo(
            courseImage: image,
            courseId: courseContent.id,
            videoId: courseContent.videoUrl!.split('?').first,
          )
        : courseContent.type == 'exam'
            ? Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(AppUi.assets.examImg),
                        AppText(
                          courseContent.title!,
                          color: AppUi.colors.mainColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.h),
                          child: AppText(
                            '(' + 'exam'.tr() + ')',
                            fontSize: 14.sp,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: AppButton(
                              color: AppUi.colors.bgColor,
                              titleWidget: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppText(
                                    'question_count'.tr(),
                                    color: AppUi.colors.mainColor,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  AppText(
                                    '( ${courseContent.questionsNumber!} )',
                                  )
                                ],
                              ),
                            )),
                            SizedBox(
                              width: 3.w,
                            ),
                            Expanded(
                                child: AppButton(
                              color: AppUi.colors.bgColor,
                              titleWidget: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppText(
                                    'exam_time'.tr(),
                                    color: AppUi.colors.mainColor,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  AppText(
                                    '( ${courseContent.examTime} )',
                                  )
                                ],
                              ),
                            ))
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 2.h,
                          ),
                          child: Row(
                            children: [
                              if (courseContent.attemptsBefore != 0)
                                Expanded(
                                  child: AppButton(
                                    height: 5.5.h,
                                    title: 'show_trials'.tr(),
                                    fontSize: 1.8.h,
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.testTrial,
                                          arguments: [courseContent.id, null]);
                                    },
                                  ),
                                ),
                              SizedBox(
                                width: 3.w,
                              ),
                              if (courseContent.attemptsBefore! <
                                  courseContent.attemptsCount!)
                                Expanded(
                                  child: AppButton(
                                    fontSize: 1.8.h,
                                    height: 5.5.h,
                                    title: 'start_now'.tr(),
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.singleTest,
                                          arguments: [
                                            courseContent.id,
                                            courseContent.examTime
                                          ]);
                                    },
                                  ),
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : courseContent.type == 'homework'
                ? Card(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(AppUi.assets.examImg),
                            AppText(
                              courseContent.title!,
                              color: AppUi.colors.mainColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.h),
                              child: AppText(
                                '(' + 'homework'.tr() + ')',
                                fontSize: 14.sp,
                              ),
                            ),
                            AppButton(
                              width: 45.w,
                              color: AppUi.colors.bgColor,
                              titleWidget: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppText(
                                    'question_count'.tr(),
                                    color: AppUi.colors.mainColor,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  AppText(
                                    '( ${courseContent.questionsNumber} )',
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 2.h,
                              ),
                              child: Row(
                                children: [
                                if (courseContent.attemptsBefore != 0)   Expanded(
                                    child: AppButton(
                                      height: 5.5.h,
                                      title: 'show_trials'.tr(),
                                      fontSize: 1.8.h,
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, Routes.multiAttemptScreen,
                                            arguments:
                                              courseContent.id,
                                             );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                 if (courseContent.attemptsBefore! <
                                  courseContent.attemptsCount!)  Expanded(
                                    child: AppButton(
                                      title: 'start_now'.tr(),
                                      height: 5.5.h,
                                      fontSize: 1.8.h,
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, Routes.singleTest,
                                            arguments: [
                                              courseContent.id,
                                              null
                                            ]);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : courseContent.type == 'zoom'
                    ? Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 2.h,
                                ),
                                Image.asset(
                                  AppUi.assets.zoomIcon,
                                  width: 16.w,
                                  height: 8.h,
                                  fit: BoxFit.cover,
                                ),
                                Image.asset(
                                  AppUi.assets.zoom,
                                  width: 16.w,
                                  height: 8.h,
                                  fit: BoxFit.cover,
                                ),
                                AppText(
                                  courseContent.title!,
                                  fontWeight: FontWeight.w600,
                                ),
                                DateTime.parse(courseContent.zoomTime)
                                            .difference(DateTime.now())
                                            .inMinutes <=
                                        0
                                    ? BlocBuilder<CoursesCubit, CoursesState>(
                                        builder: (context, state) {
                                          return InkWell(
                                            onTap: () {
                                              CoursesCubit.get(context)
                                                  .addCourseToProgress(context,
                                                      courseContent.id);

                                              CoursesCubit.get(context)
                                                  .launchInBrowser(Uri.parse(
                                                      courseContent.liveUrl ??
                                                          courseContent
                                                              .recordedUrl));
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 2.h),
                                              child: AppText(
                                                courseContent.liveUrl ??
                                                    courseContent.recordedUrl,
                                                color: AppUi.colors.mainColor,
                                                textAlign: TextAlign.center,
                                                textDecoration:
                                                    TextDecoration.underline,
                                                decorationColor:
                                                    AppUi.colors.mainColor,
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.h),
                                        child: Directionality(
                                          textDirection: TextDirection.ltr,
                                          child: SlideCountdownSeparated(
                                              duration: DateTime.parse(
                                                      courseContent.zoomTime)
                                                  .difference(DateTime.now())),
                                        ),
                                      ),
                                SizedBox(
                                  height: 2.h,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : courseContent.type == 'note'
                        ? Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 10.h),
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 3.h),
                            decoration: BoxDecoration(
                                color: AppUi.colors.activeColor.withOpacity(.3),
                                borderRadius: BorderRadius.circular(8)),
                            child: AppText(
                              courseContent.desc ?? '',
                            ),
                          )
                        : Container();
  }
}
