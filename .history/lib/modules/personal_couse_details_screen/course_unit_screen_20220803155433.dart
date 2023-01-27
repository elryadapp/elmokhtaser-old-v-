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
        var cubit=CoursesCubit.get(context);
        return Scaffold(
          appBar: ElmoktaserAppbar(
            context,
            titleText: 'units'.tr(),
          ),
          body: BuildCondition(
            condition: state is GetCourseUnitsLoadingState,
            builder: (context)=>AppUtil.appLoader(),
            fallback: (context) {
              return Container();
            }
          ),
        );
      },
    );
  }
}
