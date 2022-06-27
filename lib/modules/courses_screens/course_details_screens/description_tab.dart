
import 'package:flutter/material.dart';
import 'package:elmoktaser_elshamel/modules/courses_screens/_exports.dart';


class DescriptionTab extends StatelessWidget {
  final CoursesItem courseItem;
  const DescriptionTab({Key? key, required this.courseItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              courseItem.title!,
              fontWeight: FontWeight.bold,
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: HtmlWidget(courseItem.desc!)),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: AppText(
                'teachers'.tr() + ' :',
                fontWeight: FontWeight.w600,
              ),
            ),
            ExpandedList(listItem: courseItem.teachers!),
            if (Constants.token == '')
              if (double.tryParse(courseItem.price.toString()) != null)
                AppText(
                  '${double.parse(courseItem.price.toString()).toStringAsFixed(2)}\t' +
                      'RS'.tr(),
                  color: AppUi.colors.buttonColor.withOpacity(.8),
                  fontWeight: FontWeight.w700,
                ),
          ],
        ),
      ),
    );
  }
}
