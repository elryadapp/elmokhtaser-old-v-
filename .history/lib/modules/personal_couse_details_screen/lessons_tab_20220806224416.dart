import 'package:elmoktaser_elshamel/blocs/courses_cubit/courses_cubit.dart';
import 'package:elmoktaser_elshamel/models/course_content_model.dart';
import 'package:elmoktaser_elshamel/shared/components/app_list_tile.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:elmoktaser_elshamel/shared/utilities/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';
class LessonTab extends StatelessWidget {
  final List<CourseContentSection> courseContent;
  const LessonTab({Key? key, required this.courseContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoursesCubit, CoursesState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CoursesCubit.get(context);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: cubit.singleCourseContentItem!.isNotEmpty? Column(
              children: [
                SizedBox(
                  height: 3.h,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: courseContent.length,
                    itemBuilder: (context, index) {
                      return AppListTile(
                          title: courseContent[index].title!,
                          content: Column(
                            children: List.generate(
                                courseContent[index].childs!.length,
                                (childIndex) => Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 1.h),
                                      child: InkWell(
                                        onTap: () {
                                          cubit.changeColorOnTab(
                                              childIndex, index);
                                        },
                                        child: Row(
                                          children: [
                                            childIndex == cubit.currentIndex
                                                ? Icon(IconBroken.Play,color: AppUi.colors.mainColor,)
                                                : Icon(IconBroken.Document, color:courseContent[index]
                                                          .childs![childIndex]
                                                          .progressable !=
                                                      0? AppUi.colors.mainColor:AppUi
                                                        .colors.subTitleColor
                                                        .withOpacity(.7),),
                                            SizedBox(width: 3.w),
                                            AppText(
                                              courseContent[index]
                                                  .childs![childIndex]
                                                  .title!,
                                              height: 2,
                                              color: childIndex ==
                                                      cubit.currentIndex
                                                  ? AppUi.colors.mainColor
                                                  : AppUi.colors.subTitleColor
                                                      .withOpacity(.7),
                                            ),
                                            const Spacer(),
                                            Icon(
                                              courseContent[index]
                                                          .childs![childIndex]
                                                          .progressable !=
                                                      0
                                                  ? Icons
                                                      .check_circle_outline_rounded
                                                  : IconBroken.Lock,
                                              color: courseContent[index]
                                                          .childs![childIndex]
                                                          .progressable !=
                                                      0
                                                  ? AppUi.colors.mainColor
                                                  : AppUi.colors.subTitleColor
                                                      .withOpacity(.5),
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                          ));
                    }),
              ],
            ):Column(
                        children: [
                          AppUtil.emptyLottie(padding: 10),
                          SizedBox(
                            height: 2.h,
                          ),
                          AppText(
                              'there_are_no_content_added_to_this_course_yet'
                                  .tr()),
                                  SizedBox(height: 10.h,)
                        ],
                      ),
          ),
        );
      },
    );
  }
}
