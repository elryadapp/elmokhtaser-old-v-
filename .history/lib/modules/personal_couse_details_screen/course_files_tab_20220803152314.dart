import 'package:buildcondition/buildcondition.dart';
import 'package:elmoktaser_elshamel/blocs/courses_cubit/courses_cubit.dart';
import 'package:elmoktaser_elshamel/layout/_exports.dart';
import 'package:elmoktaser_elshamel/modules/personal_couse_details_screen/components/attachement_item.dart';
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
    return BlocBuilder<CoursesCubit, CoursesState>(
      builder: (context, state) {
        var cubit = CoursesCubit.get(context);
        return BuildCondition(
            condition: state is GetCourseAttachmentLoadingState,
            builder: (context) => AppUtil.appLoader(),
            fallback: (context) {
              return cubit.courseAttachmentItems.isEmpty? 
              SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
              children: [
                Lottie.asset(AppUi.assets.empty, height: 20.h),
                AppText('there_are_no_attachment_yet'.tr())
              ],
            ),
        )
              :Padding(
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
