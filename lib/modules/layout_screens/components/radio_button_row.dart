import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class RadioButtonRow extends StatelessWidget {
  final String title;
  final Color selectedColor;
  final Function()ontap;
  const RadioButtonRow({ Key? key, required this.title, required this.ontap, required this.selectedColor }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
        return InkWell(
          onTap: ontap,
          child: Row(
         children: [
           Container(
           padding: const EdgeInsets.all(2),
           child: CircleAvatar(
             backgroundColor: selectedColor,
           ),
           width: 4.w,
           height: 4.h,
          decoration: BoxDecoration(
            shape:BoxShape.circle,
            border: Border.all(color: AppUi.colors.borderColor)
          ),
           ),
          const SizedBox(width: 10,),
           AppText(title)
         ],
          ),
        
      
    );
  }
}