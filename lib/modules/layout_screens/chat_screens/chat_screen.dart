import 'package:elmoktaser_elshamel/modules/layout_screens/chat_screens/components/chat_card.dart';
import 'package:elmoktaser_elshamel/shared/components/animated_list_handler.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.h),
      child: const AnimatedListHandler(children: [
        ChatCard(),
        ChatCard(),
        ChatCard(),
        ChatCard(),
        ChatCard(),
        ChatCard(),
        ChatCard(),
        ChatCard(),
      ]),
    );
  }
}
