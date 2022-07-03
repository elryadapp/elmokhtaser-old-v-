import 'package:elmoktaser_elshamel/blocs/connectivity_bloc.dart/connectivity_bloc_cubit.dart';
import 'package:elmoktaser_elshamel/layout/lost_internet_connection.dart';
import 'package:flutter/material.dart';
import 'package:elmoktaser_elshamel/modules/courses_screens/_exports.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    var cubit = CoursesCubit.get(context);
    cubit.coursesList = [];
    cubit.getCourseCategories(context).then((value) => cubit
        .getAllCourses()
        .then((value) => cubit.tabController = TabController(
            length: cubit.categoriesList.length + 1, vsync: this)));
    var connection = ConnectivityCubit.get(context);
    connection.connectivitySubscription =
        connection.connectivity.onConnectivityChanged.listen((event) {
      connection.checkConnection(connectivity: connection.connectivity);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoursesCubit, CoursesState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CoursesCubit.get(context);
        return Scaffold(
            appBar: ElmoktaserAppbar(
              context,
              titleText: 'courses'.tr(),
            ),
            body: BlocBuilder<ConnectivityCubit, ConnectivityCubitState>(
              builder: (context, state) {
                var connectCubit=ConnectivityCubit.get(context);
                return !connectCubit.hasConnection? 
                const LostInternetConnection()
                :Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: BuildCondition(
                      condition: (state is GetCategoriesLoadingState &&
                              cubit.categoriesList.isEmpty) ||
                          state is GetAllCoursesLoadingState ||
                          state is GetSearchedCourseLoadingState,
                      builder: (context) => AppUtil.appLoader(),
                      fallback: (context) {
                        return cubit.coursesList.isEmpty
                            ? Column(
                                children: [
                                  AppUtil.emptyLottie(),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  AppText(
                                      'No_courses_have_been_added_to_this_category'
                                          .tr())
                                ],
                              )
                            : Column(
                                children: [
                                  AppTextFormFeild(
                                    suffixIcon: AppButton(
                                      title: 'search'.tr(),
                                      width: 22.w,
                                      height: 5.8.h,
                                      onTap: () {
                                        cubit.getSearchedCourse(
                                            cubit.coursesSearchController.text,
                                            context);
                                      },
                                    ),
                                    controller: cubit.coursesSearchController,
                                    filledColor: AppUi.colors.whiteColor,
                                    hint: 'search_in_courses'.tr(),
                                    onSubmitted: (val) {
                                      cubit.getSearchedCourse(val, context);
                                    },
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: AppUi.colors.subTitleColor
                                          .withOpacity(.5),
                                    ),
                                  ),
                                  CustomTabBar(
                                      tabController: cubit.tabController!,
                                      ontap: () {
                                        if (cubit.tabController!.index == 0) {
                                          cubit.getAllCourses();
                                        } else {
                                          cubit.categoryCoursesList = [];
                                          cubit.page = 1;
                                          cubit.getCoursesByCategory(
                                              cubit
                                                  .categoriesList[cubit
                                                          .tabController!
                                                          .index -
                                                      1]
                                                  .id,
                                              context);
                                        }
                                      },
                                      tabTitlesList: cubit.tabs),
                                  Expanded(
                                    child: TabBarView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children: List.generate(
                                        cubit.tabController!.length,
                                        (index) {
                                          if (index == 0) {
                                            return cubit.coursesList.isEmpty &&
                                                    state
                                                        is GetAllCoursesLoadedState
                                                ? Column(
                                                    children: [
                                                      AppUtil.emptyLottie(),
                                                      SizedBox(
                                                        height: 2.h,
                                                      ),
                                                      AppText(
                                                          'No_courses_have_been_added_to_this_category'
                                                              .tr())
                                                    ],
                                                  )
                                                : state
                                                        is GetSearchedCourseLoadedState
                                                    ? cubit.searchedCoursesList
                                                            .isNotEmpty
                                                        ? SingleChildScrollView(
                                                            physics:
                                                                const BouncingScrollPhysics(),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      cubit
                                                                          .changeSearchState();
                                                                    },
                                                                    icon: Icon(
                                                                      Icons
                                                                          .close_rounded,
                                                                      color: AppUi
                                                                          .colors
                                                                          .subTitleColor,
                                                                    )),
                                                                AppList(
                                                                    index: 0,
                                                                    coursesList:
                                                                        cubit
                                                                            .searchedCoursesList),
                                                              ],
                                                            ),
                                                          )
                                                        : SingleChildScrollView(
                                                            physics:
                                                                const BouncingScrollPhysics(),
                                                            child: Column(
                                                              children: [
                                                                AppUtil
                                                                    .emptyLottie(),
                                                                SizedBox(
                                                                  height: 2.h,
                                                                ),
                                                                AppText(
                                                                  'searched_couses_alert'
                                                                      .tr(),
                                                                  fontSize:
                                                                      14.sp,
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                    : AppList(
                                                        index: 0,
                                                        coursesList:
                                                            cubit.coursesList);
                                          } else {
                                            return cubit
                                                    .categoryCoursesList.isEmpty
                                                ? Column(
                                                    children: [
                                                      AppUtil.emptyLottie(),
                                                      SizedBox(
                                                        height: 2.h,
                                                      ),
                                                      AppText(
                                                        'No_courses_have_been_added_to_this_category'
                                                            .tr(),
                                                        fontSize: 14.sp,
                                                      )
                                                    ],
                                                  )
                                                : state
                                                        is GetSearchedCourseLoadedState
                                                    ? cubit.searchedCoursesList
                                                            .isNotEmpty
                                                        ? SingleChildScrollView(
                                                            physics:
                                                                const BouncingScrollPhysics(),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      cubit
                                                                          .changeSearchState();
                                                                    },
                                                                    icon: Icon(
                                                                      Icons
                                                                          .close_rounded,
                                                                      color: AppUi
                                                                          .colors
                                                                          .subTitleColor,
                                                                    )),
                                                                AppList(
                                                                    index: 0,
                                                                    coursesList:
                                                                        cubit
                                                                            .searchedCoursesList),
                                                              ],
                                                            ),
                                                          )
                                                        : SingleChildScrollView(
                                                            physics:
                                                                const BouncingScrollPhysics(),
                                                            child: Column(
                                                              children: [
                                                                AppUtil
                                                                    .emptyLottie(),
                                                                SizedBox(
                                                                  height: 2.h,
                                                                ),
                                                                AppText(
                                                                  'searched_couses_alert'
                                                                      .tr(),
                                                                  fontSize:
                                                                      14.sp,
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                    : AppList(
                                                        catId: cubit
                                                            .categoriesList[cubit
                                                                            .tabController!
                                                                            .index -
                                                                        1 <
                                                                    0
                                                                ? cubit
                                                                    .tabController!
                                                                    .index
                                                                : cubit.tabController!
                                                                        .index -
                                                                    1]
                                                            .id,
                                                        index: index,
                                                        coursesList: cubit
                                                            .categoryCoursesList);
                                          }
                                        },
                                      ),
                                      controller: cubit.tabController,
                                    ),
                                  )
                                ],
                              );
                      }),
                );
              },
            ));
      },
    );
  }
}
