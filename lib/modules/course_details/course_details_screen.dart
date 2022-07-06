import 'package:elmoktaser_elshamel/blocs/connectivity_bloc.dart/connectivity_bloc_cubit.dart';
import 'package:elmoktaser_elshamel/layout/lost_internet_connection.dart';
import 'package:elmoktaser_elshamel/modules/course_details/components/course_details_body.dart';
import 'package:flutter/material.dart';
import 'package:elmoktaser_elshamel/modules/courses_screens/_exports.dart';

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
    if (Constants.token != '') {
      cubit.checkCourseExitInSubscribe(widget.coursesItem.id, context);
    }

    cubit.detailsTabController = TabController(length: 5, vsync: this);
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
            titleText: '',
          ),
          body: BlocBuilder<ConnectivityCubit, ConnectivityCubitState>(
            builder: (context, state) {
      
              return !ConnectivityCubit.get(context).hasConnection? 
              const LostInternetConnection()
              : CourseDetailsBody(coursesItem: widget.coursesItem,);
            },
          ),
          bottomSheet: Constants.token != '' &&
                  state is ! CheckCourseSubscribtionLoadingState
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
                              Icon(
                                Icons.shopping_cart_outlined,
                                color: AppUi.colors.whiteColor,
                              ),
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
              : state is CheckCourseSubscribtionLoadingState? 
              AppUtil.appLoader(height: 12.h)
              :Container(
                  height: 0,
                ),
        );
      },
    );
  }
}
