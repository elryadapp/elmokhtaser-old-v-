
import 'package:flutter/material.dart';
import 'package:elmoktaser_elshamel/modules/courses_screens/_exports.dart';

class QuestionAndAnswersTab extends StatelessWidget {
  final CoursesItem courseItem;
  const QuestionAndAnswersTab({ Key? key, required this.courseItem }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoursesCubit, CoursesState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CoursesCubit.get(context);
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 3.h,
              ),
              ...cubit.queAndAnsList.map(
                (e) => AppListTile(
                 
                  title: e.question!,
                  content: AppText(e.answer!,
                    
                    )
                )
              )
            ],
          ),
        );
      },
    );
  }
}