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
  @override
  void initState() {
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
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.card);
                  },
                  child: Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      Image.asset(
                        AppUi.assets.cardIcon,
                      ),
                      CircleAvatar(
                        radius: 2.5.w,
                        child: AppText(
                          '${CartCubit.get(context).cartItemList.length}',
                          fontSize: 8.sp,
                          textAlign: TextAlign.center,
                          color: CartCubit.get(context).cartItemList.isNotEmpty
                              ? AppUi.colors.whiteColor
                              : Colors.transparent,
                          fontWeight: FontWeight.w600,
                        ),
                        backgroundColor:
                            CartCubit.get(context).cartItemList.isNotEmpty
                                ? AppUi.colors.buttonColor
                                : Colors.transparent,
                      )
                    ],
                  ),
                ),
                if (cubit.currentPageIndex != 2)
                  InkWell(
                    onTap: () {
                      cubit.changeCurrentPageIndex(2);
                      Navigator.pushNamed(context, Routes.layout);
                    },
                    child: Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: [
                        Lottie.asset(
                          AppUi.assets.lottieNotification,
                          height: 6.h,
                          controller: NotificationHelper.controller,
                          onLoaded: (composition) {
                            NotificationHelper.controller!.duration =
                                const Duration(milliseconds: 500);
                          },
                        ),
                        PositionedDirectional(
                          start: 1.5.w,
                          top: .5.h,
                          child: CircleAvatar(
                            radius: 2.5.w,
                            child: AppText(
                              '${NotificationCubit.get(context).unreadedNotification.length}',
                              fontSize: 8.sp,
                              textAlign: TextAlign.center,
                              color: NotificationCubit.get(context)
                                      .unreadedNotification
                                      .isNotEmpty
                                  ? AppUi.colors.whiteColor
                                  : Colors.transparent,
                              fontWeight: FontWeight.w600,
                            ),
                            backgroundColor: NotificationCubit.get(context)
                                    .unreadedNotification
                                    .isNotEmpty
                                ? AppUi.colors.buttonColor
                                : Colors.transparent,
                          ),
                        )
                      ],
                    ),
                  ),
              ],
              isTitleCenterd: cubit.currentPageIndex == 0 ? false : true,
              titleText: pageTitlesList[cubit.currentPageIndex],
              isLeading: false,
            ),
            body: WillPopScope(
                child: cubit.pages[cubit.currentPageIndex],
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
                }),
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
