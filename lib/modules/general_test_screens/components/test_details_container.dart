
import 'package:flutter/material.dart';
import 'package:elmoktaser_elshamel/modules/general_test_screens/_exports.dart';

class TestDetailsContainer extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color color;
  const TestDetailsContainer(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AppText(
            title,
            fontWeight: FontWeight.w600,
            color: AppUi.colors.whiteColor,
          ),
          AppText(subTitle,
              fontWeight: FontWeight.w600, color: AppUi.colors.whiteColor)
        ],
      ),
      height: 12.h,
      decoration: BoxDecoration(
          color:color,
          borderRadius: BorderRadius.circular(8)),
    );
  }
}
