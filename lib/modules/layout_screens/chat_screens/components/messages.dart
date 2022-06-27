import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MessageItem extends StatelessWidget {
  final bool isSend;
  final String mess;
  const MessageItem({Key? key, required this.isSend, required this.mess})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isSend ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Padding(
              padding: EdgeInsets.symmetric(vertical: 1.3.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                              margin: EdgeInsets.symmetric(vertical: 1.h),

                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: !isSend
                            ? Colors.transparent
                            : AppUi.colors.borderColor.withOpacity(.4)),
                    borderRadius: BorderRadiusDirectional.only(
                      bottomEnd: const Radius.circular(5),
                      bottomStart: const Radius.circular(5),
                      topStart: !isSend
                          ? const Radius.circular(0)
                          : const Radius.circular(5),
                      topEnd: !isSend
                          ? const Radius.circular(5)
                          : const Radius.circular(0),
                    ),
                    color: !isSend
                        ? AppUi.colors.mainColor.withOpacity(.2)
                        : AppUi.colors.whiteColor),
                child: AppText(
                  mess,
                  fontWeight: FontWeight.w600,
                ),
              ),
              AppText(
                '01:10 AM',
                color: AppUi.colors.subTitleColor.withOpacity(.7),
                fontWeight: FontWeight.w600,
                fontSize: 10.sp,
              )
            ],
          ),
        ),
      ],
    );
  }
}
