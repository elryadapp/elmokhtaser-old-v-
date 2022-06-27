import 'package:elmoktaser_elshamel/blocs/courses_cubit/courses_cubit.dart';
import 'package:elmoktaser_elshamel/models/courses_model.dart';
import 'package:elmoktaser_elshamel/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

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
