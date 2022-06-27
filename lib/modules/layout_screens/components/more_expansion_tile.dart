import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MoreExpansionTile extends StatelessWidget {
  final Function() ontap;
  final bool isExpanded;
  final Widget icon;
  final String title;
  const MoreExpansionTile(
      {Key? key, required this.ontap, required this.icon, required this.title, this.isExpanded=true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.only(bottom: 1.h),
        padding: EdgeInsets.all(3.h),
        decoration: BoxDecoration(
            color: AppUi.colors.whiteColor,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(color: AppUi.colors.borderColor.withOpacity(.3),
              blurRadius: 2
             )
            ],
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            icon,
            const SizedBox(
              width: 20,
            ),
               AppText(title,fontWeight: FontWeight.w600,),
            
          
        
         
          ],
        ),
      ),
    );
  }
}
