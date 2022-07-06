import 'package:buildcondition/buildcondition.dart';
import 'package:elmoktaser_elshamel/blocs/courses_cubit/courses_cubit.dart';
import 'package:elmoktaser_elshamel/modules/courses_screens/components/sliver_list.dart';
import 'package:elmoktaser_elshamel/modules/general_screens/components/row_btn.dart';
import 'package:elmoktaser_elshamel/modules/layout_screens/home/courses_card.dart';
import 'package:elmoktaser_elshamel/modules/layout_screens/home/option_card.dart';
import 'package:elmoktaser_elshamel/routes/app_routes.dart';
import 'package:elmoktaser_elshamel/shared/components/animated_page.dart';
import 'package:elmoktaser_elshamel/shared/components/app_btn.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text_form.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    CoursesCubit.get(context).getAllCourses();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoursesCubit, CoursesState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CoursesCubit.get(context);
        return BuildCondition(
            condition: state is GetAllCoursesLoadingState ||
                state is GetSearchedCourseLoadingState,
            builder: (context) => AppUtil.appLoader(height: 18.h),
            fallback: (context) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Column(
                    children: [
                      AppTextFormFeild(
                        suffixIcon: AppButton(
                          title: 'search'.tr(),
                          width: 22.w,
                          height: 5.8.h,
                          onTap: () {
                            cubit.getSearchedCourse(
                                cubit.homeSearchController.text, context);
                          },
                        ),
                        controller: cubit.homeSearchController,
                        filledColor: AppUi.colors.whiteColor,
                        hint: 'search_in_courses'.tr(),
                        onSubmitted: (val) {
                          cubit.getSearchedCourse(val, context);
                        },
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppUi.colors.subTitleColor.withOpacity(.5),
                        ),
                      ),
                      state is GetSearchedCourseLoadedState
                          ? cubit.searchedCoursesList.isNotEmpty
                              ? Padding(
                                  padding: EdgeInsets.only(top: 2.h),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                           cubit.changeSearchState();
                                          },
                                          icon: Icon(
                                            Icons.close_rounded,
                                            color: AppUi.colors.subTitleColor,
                                          )),
                                      AppList(
                                          coursesList:
                                              cubit.searchedCoursesList),
                                    ],
                                  ),
                                )
                              : Column(
                                  children: [
                                    AppUtil.emptyLottie(),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    AppText(
                                      'searched_couses_alert'.tr(),
                                      fontSize: 14.sp,
                                    )
                                  ],
                                )
                          : Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.h),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: AppSlideAnimation(
                                        verticalOffset: 0,
                                        horizontalOffset: 80,
                                        child: OptionCard(
                                            onTab: () {
                                              Navigator.pushNamed(
                                                  context, Routes.courses);
                                            },
                                            title: 'courses'.tr(),
                                            img: AppUi.assets.couresImg),
                                      )),
                                      Expanded(
                                        child: AppSlideAnimation(
                                          verticalOffset: 0,
                                          horizontalOffset: -80,
                                          child: OptionCard(
                                              onTab: () {
                                                Navigator.pushNamed(
                                                    context, Routes.mainTests);
                                              },
                                              title: 'General_Exams'.tr(),
                                              img: AppUi.assets.testImg),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                    color: AppUi.colors.borderColor
                                        .withOpacity(.4),
                                    thickness: 3),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 4.h,
                                      bottom: 2.h,
                                      left: 2.w,
                                      right: 2.w),
                                  child: Row(
                                    children: [
                                      AppText('home_courses'.tr()),
                                      const Spacer(),
                                      RowBtn(
                                          route: Routes.courses,
                                          title: 'view_all'.tr(),
                                          isIos: true),
                                    ],
                                  ),
                                ),
                                AppSlideAnimation(
                                  horizontalOffset: 0,
                                  verticalOffset: 150,
                                  child: SizedBox(
                                    height: 30.h,
                                    child: ListView.separated(
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) =>
                                            CoursesCard(
                                                coursesItem:
                                                    cubit.coursesList[index]),
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(width: 5),
                                        itemCount: cubit.coursesList.length),
                                  ),
                                )
                              ],
                            )
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}
