import 'package:buildcondition/buildcondition.dart';
import 'package:elmoktaser_elshamel/blocs/layout_cubit/layout_cubit.dart';
import 'package:elmoktaser_elshamel/blocs/notification_cubit/notification_cubit.dart';
import 'package:elmoktaser_elshamel/modules/notification_screen/components/empty_notification.dart';
import 'package:elmoktaser_elshamel/modules/notification_screen/components/notification_item.dart';
import 'package:elmoktaser_elshamel/routes/app_routes.dart';
import 'package:elmoktaser_elshamel/shared/components/animated_list_handler.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
FirebaseMessaging messaging = FirebaseMessaging.instance;


  @override
  void initState() {
NotificationCubit.get(context).getUserNotification(context);



    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationCubit, NotificationState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NotificationCubit.get(context);
        return BuildCondition(
          condition: state is GetUserNotificationLoadingState,
          builder: (context) => AppUtil.appLoader(height: 18.h),
          fallback: (context) => cubit.notificationsList.isEmpty
              ? const EmptyNotification()
              : AnimatedListHandler(
                  children: List.generate(
                      cubit.notificationsList.length,
                      (index) => InkWell(
                            onTap: () {
                              cubit.markNotificationAsReaded( cubit.notificationsList[index],context);
                              if (cubit.notificationsList[index].type!
                                      .split('_')
                                      .last ==
                                  'certificate') {
                                Navigator.pushNamed(
                                    context, Routes.certificate);
                              } else {
                                LayoutCubit.get(context)
                                    .changeCurrentPageIndex(1);

                                Navigator.pushNamedAndRemoveUntil(context, Routes.layout, ModalRoute.withName( Routes.layout));
                              }
                            },
                            child: NotificationItem(
                              notificationItemModel:
                                  cubit.notificationsList[index],
                            ),
                          ))),
        );
      },
    );
  }
}
