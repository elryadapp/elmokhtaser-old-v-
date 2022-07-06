
import 'package:flutter/material.dart';
import 'package:elmoktaser_elshamel/modules/courses_screens/_exports.dart';

class AppList extends StatefulWidget {
  final List<CoursesItem> coursesList;
  final int? catId;
  final int? index;
  const AppList({Key? key, required this.coursesList, this.index, this.catId})
      : super(key: key);

  @override
  State<AppList> createState() => _AppListState();
}

class _AppListState extends State<AppList> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        fetchData();
      }
    });
    super.initState();
  }

  fetchData({name}) async {
    var cubit = CoursesCubit.get(context);

    cubit.page++;

    if (widget.index == 0) {
      cubit.getAllCourses(
        page: cubit.page,
      );
    }
    else{
      cubit.getCoursesByCategory(widget.catId, context,page: cubit.page);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoursesCubit, CoursesState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Stack(
          children: [
            ListView.builder(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.courseDetails,
                        arguments: widget.coursesList[index]);
                  },
                  child:
                      CourseContainer(coursesItem: widget.coursesList[index])),
              itemCount: widget.coursesList.length,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                color: CoursesCubit.get(context).coursesModel!.data!.isEmpty||
                  (CoursesCubit.get(context).categoryCoursesList.isEmpty&&widget.index!=0)?AppUi.colors.buttonColor.withOpacity(.8):Colors.transparent,

                ),
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                height: state is LoadingPaginationCoursesState ?CoursesCubit.get(context).coursesModel!.data!.isEmpty||
                  (CoursesCubit.get(context).categoryCoursesList.isEmpty&&widget.index!=0)? 50:100 : 0,
                width: double.infinity,
                child: Center(
                  child: CoursesCubit.get(context).coursesModel!.data!.isEmpty||
                  (CoursesCubit.get(context).categoryCoursesList.isEmpty&&widget.index!=0)
                      ? AppText('there_are_no_more_courses'.tr(),color: AppUi.colors.whiteColor,)
                      : AppUtil.appLoader(height: 30.h),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
