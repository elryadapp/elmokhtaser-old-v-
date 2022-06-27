
import 'package:flutter/material.dart';
import 'package:elmoktaser_elshamel/modules/courses_screens/_exports.dart';


class CoursePublicBagTab extends StatelessWidget {
  final CoursesItem coursesItem;
  const CoursePublicBagTab({Key? key, required this.coursesItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesCubit, CoursesState>(
      builder: (context, state) {
        return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Stack(
              children: [
                Html(
                  data: coursesItem.courseBag!,
                ),
                InkWell(
                  onTap:  (){
                CoursesCubit.get(context).launchInBrowser(
                      Uri.parse('https://emary.azq1.com/Mo5tsr/bag/${coursesItem.id}'));
              },
                  child: Container(
                    height: Constants.getHeight(context)*.6,
                  ),
                )
                     
              ],
            ));
      },
    );
  }
}
