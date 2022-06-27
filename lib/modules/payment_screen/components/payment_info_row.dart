import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class PaymentInfoRow extends StatelessWidget {
  final String title;
  final String info;
  final Color? titleColor;
  const PaymentInfoRow({ Key? key, required this.title, required this.info, this.titleColor }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 1.2.h),
      child: Row(
        children: [
          AppText(title,fontWeight: FontWeight.w600,),
         const Spacer(),
          AppText(info,fontWeight: FontWeight.w600,color: titleColor??AppUi.colors.subTitleColor,)
        ],
      ),
    );
  }
}