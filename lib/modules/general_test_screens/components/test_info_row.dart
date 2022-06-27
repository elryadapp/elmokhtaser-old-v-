import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:flutter/material.dart';

class TestInfoRow extends StatelessWidget {
  final String title;
  final String subTitle;
  final String count;
  const TestInfoRow(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppText(
          title,
          fontWeight: FontWeight.w600,
        ),
        const Spacer(),
        AppText(count,
            color: AppUi.colors.mainColor, fontWeight: FontWeight.w600),
        AppText(subTitle, fontWeight: FontWeight.w600)
      ],
    );
  }
}
