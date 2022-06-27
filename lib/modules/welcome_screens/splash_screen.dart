import 'package:buildcondition/buildcondition.dart';
import 'package:elmoktaser_elshamel/blocs/cart_cubit/cart_cubit.dart';
import 'package:elmoktaser_elshamel/blocs/courses_cubit/courses_cubit.dart';
import 'package:elmoktaser_elshamel/blocs/notification_cubit/notification_cubit.dart';
import 'package:elmoktaser_elshamel/routes/app_routes.dart';
import 'package:elmoktaser_elshamel/shared/constants.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
        const Duration(
          milliseconds: 2000,
        ), () async {
      if (Constants.token.isNotEmpty || Constants.token != '') {
        await CartCubit.get(context).getAllCartItems(context);
        await NotificationCubit.get(context).getUserNotification(context);
        Navigator.pushReplacementNamed(context, Routes.layout);
      } else {
        Navigator.pushReplacementNamed(context, Routes.onBoarding);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [AppUi.colors.shadeColor, AppUi.colors.bgColor])),
            child: AnimationLimiter(
              child: AnimationConfiguration.staggeredList(
                position: 5,
                duration: const Duration(milliseconds: 1000),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SlideAnimation(
                        horizontalOffset: 100.0,
                        child: FadeInAnimation(
                            child: Center(
                          child: Image.asset(AppUi.assets.logo),
                        )),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      SlideAnimation(
                        verticalOffset: 100.0,
                        child: FadeInAnimation(
                            child: Center(
                          child: Image.asset(AppUi.assets.logoName),
                        )),
                      ),
                     
                      SizedBox(
                        height: 7.h,
                      ),
                       BuildCondition(
                        condition: state is GetAllCartLoadingState||state is GetUserNotificationLoadingState,
                        fallback: (context)=>Container(),
                        builder: (context) {
                          return AppUtil.appLoader(height: 14.h);
                        }
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
