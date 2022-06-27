import '_exports.dart';
import 'package:flutter/material.dart';


class VisitorScreen extends StatelessWidget {
  const VisitorScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText('login_alert'.tr()),
            SizedBox(
              height: 2.h,
            ),
            AppButton(
              title: 'Login'.tr(),
              onTap: () {
                Navigator.pushNamed(context, Routes.login);
              },
            )
          ],
        ),
      ),
    );
  }
}
