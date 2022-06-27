import 'package:elmoktaser_elshamel/routes/app_routes.dart';
import 'package:elmoktaser_elshamel/shared/components/app_btn.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sizer/sizer.dart';
class VisitorScreen extends StatelessWidget {
  const VisitorScreen({ Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText('login_alert'.tr()),
            SizedBox(height: 2.h,),
            AppButton(
              title: 'Login'.tr(),
              onTap: (){
           
Navigator.pushNamed(context, Routes.login);
             
              },
            )
          ],

        ),
      ),
    );
  }
}