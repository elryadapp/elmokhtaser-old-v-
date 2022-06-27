import 'package:elmoktaser_elshamel/blocs/chat_cubit/chat_cubit.dart';
import 'package:elmoktaser_elshamel/modules/layout_screens/chat_screens/components/messages.dart';
import 'package:elmoktaser_elshamel/shared/components/animated_list_handler.dart';
import 'package:elmoktaser_elshamel/shared/components/app_app_bar.dart';
import 'package:elmoktaser_elshamel/shared/components/app_btn.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text_form.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:elmoktaser_elshamel/shared/utilities/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ChatDetailsScreen extends StatelessWidget {
  const ChatDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ChatCubit.get(context);
        return Scaffold(
          appBar: ElmoktaserAppbar(
            context,
            actions: const [],
            isLeading: true,
            isTitleCenterd: false,
            titleText: 'محمد السيد',
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: AnimatedListHandler(children: [
              ...cubit.messages
                  .map((e) => MessageItem(isSend: e.isSend, mess: e.mess))
            ]),
          ),
          bottomSheet: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 7.w),
            child: Row(
              children: [
                Expanded(
                    flex: 8,
                    child: AppTextFormFeild(
                      hint: 'اكتب هنا',
                      suffixIcon: SizedBox(
                        width: 8.w,
                        child: Row(
                          children: [
                            Icon(
                              Icons.attach_file_sharp,
                              color: AppUi.colors.subTitleColor.withOpacity(.8),
                            ),
                            Icon(
                              Icons.camera_alt_rounded,
                              color: AppUi.colors.subTitleColor.withOpacity(.8),
                            ),
                          ],
                        ),
                      ),
                      borderColor: AppUi.colors.borderColor.withOpacity(.4),
                      filledColor: AppUi.colors.whiteColor,
                    )),
                SizedBox(width: 2.w),
                Expanded(
                  flex: 2,
                  child: AppButton(
                      titleWidget: Icon(IconBroken.Send,color: AppUi.colors.whiteColor,)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
