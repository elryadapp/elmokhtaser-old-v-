import 'package:buildcondition/buildcondition.dart';
import 'package:elmoktaser_elshamel/blocs/courses_cubit/courses_cubit.dart';
import 'package:elmoktaser_elshamel/modules/personal_couse_details_screen/attachement_item.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class CourseFilesTab extends StatefulWidget {
  final int courseId;
  const CourseFilesTab({Key? key, required this.courseId}) : super(key: key);

  @override
  State<CourseFilesTab> createState() => _CourseFilesTabState();
}

class _CourseFilesTabState extends State<CourseFilesTab> {
  @override
  void initState() {
    CoursesCubit.get(context).getCoursesAttachment(widget.courseId, context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoursesCubit, CoursesState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CoursesCubit.get(context);
        return BuildCondition(
            condition: state is GetCourseAttachmentLoadingState,
            builder: (context) => AppUtil.appLoader(),
            fallback: (context) {
              return Padding(
                padding: EdgeInsets.all(2.h),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .82,
                      crossAxisSpacing: 3.w,
                      mainAxisSpacing: 1.5.h),
                  itemBuilder: (context, index) => AttachementItemWidget(
                      attachmentItem: cubit.courseAttachmentItems[index]),
                  itemCount: cubit.courseAttachmentItems.length,
                ),
              );
            });
      },
    );
  }
}
