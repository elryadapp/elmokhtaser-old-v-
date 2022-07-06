import 'package:elmoktaser_elshamel/layout/_exports.dart';
import 'package:flutter/material.dart';

class EmptyCourseComponent extends StatelessWidget {
  const EmptyCourseComponent({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
                        children: [
                          AppUtil.emptyLottie(),
                          SizedBox(
                            height: 2.h,
                          ),
                          AppText('No_courses_have_been_added_to_this_category'
                              .tr())
                        ],
                      );
  }
}