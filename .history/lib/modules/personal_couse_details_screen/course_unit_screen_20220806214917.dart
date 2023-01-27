import 'package:elmoktaser_elshamel/modules/auth/_exports.dart';
import 'package:elmoktaser_elshamel/modules/certificates_screens/_exports.dart';
import 'package:elmoktaser_elshamel/modules/courses_screens/_exports.dart';
import 'package:flutter/material.dart';

class CourseUnitScreen extends StatefulWidget {
  final dynamic courseId;
  const CourseUnitScreen({Key? key, required this.courseId}) : super(key: key);

  @override
  State<CourseUnitScreen> createState() => _CourseUnitScreenState();
}

class _CourseUnitScreenState extends State<CourseUnitScreen> {
  @override
  void initState() {
    CoursesCubit.get(context).getCourseUnits(widget.courseId, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesCubit, CoursesState>(
      builder: (context, state) {
        var cubit = CoursesCubit.get(context);
        return Scaffold(
          appBar: ElmoktaserAppbar(
            context,
            titleText: 'units'.tr(),
          ),
          body: BuildCondition(
              condition: state is GetCourseUnitsLoadingState,
              builder: (context) => AppUtil.appLoader(),
              fallback: (context) {
                return cubit.unitsList.isEmpty
                    ? Column(
                        children: [
                          AppSlideAnimation(
                            verticalOffset: -150,
                            horizontalOffset: 0,
                            child: AppUtil.emptyLottie(),
                          ),
                          AppSlideAnimation(
                            verticalOffset: 150,
                            horizontalOffset: 0,
                            child: AppText('there_is_no_units'.tr()),
                          )
                        ],
                      )
                    : AnimatedListHandler(
                        children: List.generate(
                        cubit.unitsList.length,
                        (index) => InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.personalCoursesDetails,
                                arguments: cubit.unitsList[index].id);
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                          
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppUi.colors.whiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                        color: AppUi.colors.shadeColor
                                            .withOpacity(.2),
                                        blurRadius: 5)
                                  ]),
                              child: Column(
                                children: [
                                  Image.asset(AppUi.assets.examImg),
                                  AppText(cubit.unitsList[index].title ?? '')
                                ],
                              )),
                        ),
                      ));
              }),
        );
      },
    );
  }
}
