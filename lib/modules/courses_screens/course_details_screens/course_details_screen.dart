import 'package:buildcondition/buildcondition.dart';
import 'package:elmoktaser_elshamel/blocs/cart_cubit/cart_cubit.dart';
import 'package:elmoktaser_elshamel/blocs/courses_cubit/courses_cubit.dart';
import 'package:elmoktaser_elshamel/modules/courses_screens/course_details_screens/coures_content_tab.dart';
import 'package:elmoktaser_elshamel/modules/courses_screens/course_details_screens/course_public_bag_tab.dart';
import 'package:elmoktaser_elshamel/modules/courses_screens/course_details_screens/description_tab.dart';
import 'package:elmoktaser_elshamel/modules/courses_screens/course_details_screens/question_answers_tab.dart';
import 'package:elmoktaser_elshamel/modules/courses_screens/course_details_screens/rating_tab.dart';
import 'package:elmoktaser_elshamel/modules/courses_screens/course_details_screens/custom_video.dart';
import 'package:elmoktaser_elshamel/routes/app_routes.dart';
import 'package:elmoktaser_elshamel/shared/components/app_app_bar.dart';
import 'package:elmoktaser_elshamel/shared/components/app_btn.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/constants.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

class CourseDetailsScreen extends StatefulWidget {
  final dynamic coursesItem;
  const CourseDetailsScreen({Key? key, required this.coursesItem})
      : super(key: key);

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    var cubit = CoursesCubit.get(context);
    cubit.checkCourseExitInSubscribe(widget.coursesItem.id, context);

    cubit.detailsTabController = TabController(length: 5, vsync: this);

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
            actions: const [],
            titleText: '',
          ),
          body: BuildCondition(
              condition: state is CheckCourseSubscribtionLoadingState,
              builder: (context) => AppUtil.appLoader(),
              fallback: (context) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                  child: Column(
                    children: [
                      CustomVideo(
                        videoId: widget.coursesItem.previewVideo,
                        courseImage: widget.coursesItem.image,
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

                                if(index==1){
                                 cubit.getCoursesContent(widget.coursesItem.id);
                                }
                              },
                              labelColor: AppUi.colors.mainColor,
                              isScrollable: true,
                              physics: const BouncingScrollPhysics(),
                              unselectedLabelColor:
                                  AppUi.colors.subTitleColor,
                              labelPadding: EdgeInsets.zero,
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.sp),
                              controller: cubit.detailsTabController,
                              tabs: [
                                ...cubit.courseDetailsTabList
                                    .asMap()
                                    .entries
                                    .map((e) => Padding(
                                          padding: const EdgeInsetsDirectional
                                              .only(start: 10, end: 10),
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
                            DescriptionTab(courseItem: widget.coursesItem),
                            const CouresContentTab(),
                            QuestionAndAnswersTab(
                                courseItem: widget.coursesItem),
                            CoursePublicBagTab(
                                coursesItem: widget.coursesItem),
                            RatingTab(
                              coursesItem: widget.coursesItem,
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                );
              }),
          bottomSheet: Constants.token != '' &&
                  state is! CheckCourseSubscribtionLoadingState
              ? Container(
                  height: 9.h,
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                      color: AppUi.colors.whiteColor,
                      boxShadow: [
                        BoxShadow(blurRadius: 4, color: AppUi.colors.shadeColor)
                      ]),
                  child: Row(
                    children: [
                      AppButton(
                        onTap: () async {
                          if (widget.coursesItem.subscribed &&
                              cubit.active == 1) {
                            Navigator.pushNamed(
                                context, Routes.personalCoursesDetails,
                                arguments: widget.coursesItem.id);
                          } else {
                            if (cubit.active == null &&
                                widget.coursesItem.subscribed) {
                              Navigator.pushNamed(context, Routes.card);
                            } else {
                              CartCubit.get(context).addToCartItem(
                                  widget.coursesItem.id, context);
                              Navigator.pushNamed(context, Routes.card);
                              // Navigator.pushNamedAndRemoveUntil(
                              //   context,
                              //   Routes.courseDetails,
                              //   ModalRoute.withName(Routes.layout),
                              //   arguments: widget.coursesItem,
                              // );}
                            }
                          }
                        },
                        width: 49.w,
                        height: 5.5.h,
                        color: cubit.active == null &&
                                widget.coursesItem.subscribed
                            ? AppUi.colors.titleColor
                            : AppUi.colors.buttonColor,
                        titleWidget: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 7.w),
                          child: Row(
                            children: [
                            Icon(Icons.shopping_cart_outlined,color: AppUi.colors.mainColor,),
                              const Spacer(),
                              cubit.active == null &&
                                      widget.coursesItem.subscribed
                                  ? AppText(
                                      'complete_purchase'.tr(),
                                      color: AppUi.colors.whiteColor,
                                    )
                                  : AppText(
                                      widget.coursesItem.subscribed
                                          ? 'go_to_course'.tr()
                                          : 'add_to_card'.tr(),
                                      color: AppUi.colors.whiteColor,
                                    ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (double.tryParse(
                              widget.coursesItem.price.toString()) !=
                          null)
                        AppText(
                          '${double.parse(widget.coursesItem.price.toString()).toStringAsFixed(2)}\t' +
                              'RS'.tr(),
                          color: AppUi.colors.buttonColor.withOpacity(.8),
                          fontWeight: FontWeight.w700,
                        ),
                    ],
                  ),
                )
              : Container(
                  height: 0,
                ),
        );
      },
    );
  }
}
