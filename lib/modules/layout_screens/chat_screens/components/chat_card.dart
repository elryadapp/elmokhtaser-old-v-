import 'package:elmoktaser_elshamel/routes/app_routes.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, Routes.chatDetails);
        },
        
        title: const AppText('محمد السيد', fontWeight: FontWeight.w600,),
        subtitle: AppText(
          'هنا يكتب جزء من نص الرسالة',
          height: 2,
          fontSize: 11.sp,
          color: AppUi.colors.subTitleColor.withOpacity(.5),
        ),
        trailing:  AppText(
          
          '12:18 PM',
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
