import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppTextIcon extends StatelessWidget {
  final String title;
  final Widget icon;
  final FontWeight? fontWeight;
  const AppTextIcon(
      {Key? key, required this.title, required this.icon, this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        icon,
        SizedBox(
          width: 1.2.w,
        ),
        Expanded(
          child: AppText(
            title,
            fontWeight: fontWeight ?? FontWeight.normal,
          ),
        )
      ],
    );
  }
}
