
import 'package:flutter/material.dart';
import 'package:elmoktaser_elshamel/modules/courses_screens/_exports.dart';


class CouresContentTab extends StatelessWidget {
  const CouresContentTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoursesCubit, CoursesState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CoursesCubit.get(context);
        return BuildCondition(
            builder: (context) => AppUtil.appLoader(height: 14.h),
            condition: state is GetCourseContentLoadingState,
            fallback: (context) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    ListView.builder(
                      
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cubit.coursesContentList.length,
                        itemBuilder: (context, index) {
                          return AppListTile(
                             
                              title: cubit.coursesContentList[index].title!,
                              content: Column(
                                children: List.generate(
                                    cubit.coursesContentList[index].childs!
                                        .length,
                                    (childIndex) => Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 1.h),
                                          child: Row(
                                            children: [
                                              childIndex == 0&&index==0
                                                  ? Icon(IconBroken.Play,color: AppUi.colors.mainColor,)
                                                  :  Icon(IconBroken.Document,color: AppUi.colors.subTitleColor.withOpacity(.7),),
                                              SizedBox(width: 3.w),
                                              AppText(
                                                cubit
                                                    .coursesContentList[index]
                                                    .childs![childIndex]
                                                    .title!,
                                                height: 2,
                                                color: childIndex ==
                                                        0&& index==0
                                                    ? AppUi.colors.mainColor
                                                    : AppUi
                                                        .colors.subTitleColor
                                                        .withOpacity(.7),
                                              ),
                                              const Spacer(),
                                              if(childIndex != 0 || index!=0)
                                             Icon(IconBroken.Lock,color: AppUi.colors.subTitleColor.withOpacity(.7),)
                                            ],
                                          ),
                                        )),
                              ));
                        }),
                  ],
                ),
              );
            });
      },
    );
  }
}
