import 'package:buildcondition/buildcondition.dart';
import 'package:elmoktaser_elshamel/blocs/cart_cubit/cart_cubit.dart';
import 'package:elmoktaser_elshamel/layout/visitor_screen.dart';
import 'package:elmoktaser_elshamel/modules/card_screen/components/card_item.dart';
import 'package:elmoktaser_elshamel/routes/app_routes.dart';
import 'package:elmoktaser_elshamel/shared/components/animated_page.dart';
import 'package:elmoktaser_elshamel/shared/components/app_app_bar.dart';
import 'package:elmoktaser_elshamel/shared/components/app_btn.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/constants.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  void initState() {
    var cubit = CartCubit.get(context);
if(Constants.token!=''){
    cubit.getAllCartItems(context);

}

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CartCubit.get(context);
        return Scaffold(
          appBar: ElmoktaserAppbar(
            context,

            actions:const [],
            titleText: 'card'.tr(),
          ),
          body: BuildCondition(
              condition:
                  state is GetAllCartLoadingState || state is DeleteCartItemLoadingState,
           
              builder: (context) =>AppUtil.appLoader(height: 18.h),
              fallback: (context) {
                return Constants.token==''?
                const VisitorScreen() 
                :cubit.cartItemList.isEmpty?
                 Column(
                    children: [
                      AppSlideAnimation(
                          horizontalOffset: 0,
                          verticalOffset: -100,
                          child: AppUtil.emptyLottie()),
                      SizedBox(
                        height: 2.h,
                      ),
                      AppSlideAnimation(
                          horizontalOffset: 0,
                          verticalOffset: 100,
                          child: AppText(
                            'empty_cart'.tr(),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ))
                    ],
                  )
                :Padding(
                    padding: EdgeInsets.all(1.7.h),
                    child: CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (context, index) => CardItem(
                                    coursesItem: cubit.cartItemList[index],
                                    index: index,
                                  ),
                              childCount: cubit.cartItemList.length),
                        ),
                        SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                children: [
                                  AppText(
                                    'total_cost'.tr() + ' : ',
                                  ),
                                  const Spacer(),

                                  AppText('${ cubit.cartModel!.total}\t' + 'RS'.tr(),
                                      fontWeight: FontWeight.w700)
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              AppButton(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.paymentScreen);
                                },
                                color: AppUi.colors.buttonColor,
                                title: 'purchase'.tr(),
                              )
                            ],
                          ),
                        )
                      ],
                    ));
              }),
        );
      },
    );
  }
}
