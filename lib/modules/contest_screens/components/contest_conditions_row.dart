import 'package:elmoktaser_elshamel/modules/contest_screens/_exports.dart';

import 'package:flutter/material.dart';

class ContestConditionsRow extends StatelessWidget {
  final String title;
  const ContestConditionsRow({ Key? key, required this.title }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical:1.h ),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: AppUi.colors.mainColor,radius: 1.w,),
          SizedBox(width: 3.w,)
          ,Expanded(child: AppText(title,maxLines: 2,fontSize: 10.sp,))
        ],
      ),
    );
  }
}