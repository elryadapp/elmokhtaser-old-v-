import 'package:elmoktaser_elshamel/blocs/courses_cubit/courses_cubit.dart';
import 'package:elmoktaser_elshamel/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

class CourseBagTab extends StatelessWidget {
  const CourseBagTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    
    return BlocBuilder<CoursesCubit, CoursesState>(
      builder: (context, state) {
        var cubit=CoursesCubit.get(context);
        return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Stack(
              children: [
                Html(
                  data: cubit.singleCourse!.courseBag,
                ),
                InkWell(
                  onTap:  (){
                CoursesCubit.get(context).launchInBrowser(
                      Uri.parse('https://emary.azq1.com/Mo5tsr/bag/${ cubit.singleCourse!.id}'));
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
