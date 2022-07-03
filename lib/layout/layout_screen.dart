import 'package:elmoktaser_elshamel/blocs/connectivity_bloc.dart/connectivity_bloc_cubit.dart';
import 'package:elmoktaser_elshamel/layout/lost_internet_connection.dart';
import 'package:elmoktaser_elshamel/layout/visitor_screen.dart';
import 'package:elmoktaser_elshamel/modules/layout_screens/home/home_screen.dart';
import 'package:elmoktaser_elshamel/modules/layout_screens/more_screen.dart';
import 'package:elmoktaser_elshamel/modules/layout_screens/personal_courses_screens/personal_courses_screen.dart';
import 'package:elmoktaser_elshamel/modules/layout_screens/profile_screens/profile_screen.dart';
import 'package:elmoktaser_elshamel/modules/notification_screen/notifications_screen.dart';

import '_exports.dart';
import 'package:flutter/material.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen>
    with SingleTickerProviderStateMixin {
  List<TitledNavigationBarItem> navBarItemList = [];
  List<String> pageTitlesList = [];
  List<Widget> pages = [];
  @override
  void initState() {
    pages = Constants.token == ''
        ? const [
            HomeScreen(),
            VisitorScreen(),
            VisitorScreen(),
            VisitorScreen(),
            MoreScreen()
          ]
        : const [
            HomeScreen(),
            PersonalCoursesScreen(),
            NotificationScreen(),
            ProfileScreen(),
            MoreScreen()
          ];
    navBarItemList = [
      TitledNavigationBarItem(
        title: 'Home'.tr(),
        icon: IconBroken.Home,
      ),
      TitledNavigationBarItem(
        title: 'My_courses'.tr(),
        icon: IconBroken.Bookmark,
      ),
      TitledNavigationBarItem(
        title: 'notification'.tr(),
        icon: IconBroken.Notification,
      ),
      TitledNavigationBarItem(
        title: 'profile'.tr(),
        icon: IconBroken.User,
      ),
      TitledNavigationBarItem(
        title: 'More'.tr(),
        icon: IconBroken.More_Circle,
      ),
    ];
    pageTitlesList = [
      Constants.userName != ''
          ? 'Hi'.tr() + '\t' + Constants.userName
          : AuthCubit.get(context).userLoginModel != null
              ? 'Hi'.tr() + '\t' + AuthCubit.get(context).userLoginModel?.name
              : 'Hi'.tr() +
                  '\t' +
                  (AuthCubit.get(context).userModel?.name ?? ''),
      'My_courses'.tr(),
      'notification'.tr(),
      'profile'.tr(),
      'More'.tr(),
    ];
    NotificationHelper.controller = AnimationController(vsync: this);
    var connection = ConnectivityCubit.get(context);
    connection.connectivitySubscription =
        connection.connectivity.onConnectivityChanged.listen((event) {
      connection.checkConnection(connectivity: connection.connectivity);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        return Scaffold(
            appBar: ElmoktaserAppbar(
              context,
              isTitleCenterd: cubit.currentPageIndex == 0 ? false : true,
              titleText: pageTitlesList[cubit.currentPageIndex],
              isLeading: false,
            ),
            body: BlocBuilder<ConnectivityCubit, ConnectivityCubitState>(
              builder: (context, state) {
                var connection=ConnectivityCubit.get(context);

                return !connection.hasConnection?const LostInternetConnection()
                 :WillPopScope(
                    child: pages[cubit.currentPageIndex],
                    onWillPop: () async {
                      if (cubit.currentPageIndex != 0) {
                        cubit.changeCurrentPageIndex(0);
                        return false;
                      } else {
                        var isConfirmed = false;
                        AppUtil.appDialoge(
                            context: context,
                            title: 'alert'.tr(),
                            content: Padding(
                              padding: EdgeInsets.all(2.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppText('do_you_want_to_exsit_app'.tr()),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                          child: AppButton(
                                        onTap: () {
                                          isConfirmed = false;
                                          Navigator.pop(context);
                                        },
                                        height: 4.h,
                                        color: AppUi.colors.buttonColor
                                            .withOpacity(.9),
                                        title: 'cancel'.tr(),
                                      )),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Expanded(
                                          child: AppButton(
                                        onTap: () {
                                          isConfirmed = true;
                                          SystemNavigator.pop();
                                        },
                                        color: AppUi.colors.activeColor
                                            .withOpacity(.9),
                                        height: 4.h,
                                        title: 'confirm'.tr(),
                                      ))
                                    ],
                                  )
                                ],
                              ),
                            ));
                        return isConfirmed;
                      }
                    });
              },
            ),
            bottomNavigationBar: TitledBottomNavigationBar(
                activeColor: AppUi.colors.mainColor,
                currentIndex: cubit.currentPageIndex,
                height: 8.h,
                onTap: (index) {
                  cubit.changeCurrentPageIndex(index);
                },
                items: List.generate(
                    navBarItemList.length, (index) => navBarItemList[index])));
      },
    );
  }
}
