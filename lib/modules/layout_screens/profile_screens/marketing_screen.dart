import 'package:buildcondition/buildcondition.dart';
import 'package:elmoktaser_elshamel/blocs/profile_cubit/profile_cubit.dart';
import 'package:elmoktaser_elshamel/shared/components/app_app_bar.dart';
import 'package:elmoktaser_elshamel/shared/components/app_btn.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

class MarketingScreen extends StatefulWidget {
  const MarketingScreen({Key? key}) : super(key: key);

  @override
  State<MarketingScreen> createState() => _MarketingScreenState();
}

class _MarketingScreenState extends State<MarketingScreen> {
  @override
  void initState() {
    ProfileCubit.get(context).getAllCoupons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        return Scaffold(
          appBar: ElmoktaserAppbar(
            context,
            titleText: 'Affiliate_Marketing'.tr(),
          ),
          body: BuildCondition(
              condition: state is GetCouponsLoadingState,
              builder: (context) => AppUtil.appLoader(height: 18.h),
              fallback: (context) {
                return   cubit.couponItemList.isEmpty? 
                Column(
                  children: [
                    AppUtil.emptyLottie(),
                    SizedBox(height: 5.h,),
                    AppText('there_are_no_Affiliate_Marketing_yet'.tr())
                  ],
                )
                :Padding(
                    padding: EdgeInsets.all(2.5.h),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => Card(
                        child: Padding(
                          padding: EdgeInsets.all(2.h),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  AppText(
                                    'discount_percentage'.tr() + ' : ',
                                  ),
                                  Expanded(
                                    child: AppButton(
                                      height: 4.h,
                                      color: AppUi.colors.bgColor,
                                      titleColor:AppUi.colors.mainColor ,
                                     title:  '${cubit.couponItemList[index].discount}%',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              Row(
                                children: [
                                  AppText(
                                    'discount_code'.tr() + ' : ',
                                  ),

                                    Expanded(
                                    child: AppButton(
                                      height: 4.h,
                                      color: AppUi.colors.bgColor,
                                      titleColor:AppUi.colors.mainColor ,
                                     title:  '${cubit.couponItemList[index].coupon}',
                                    ),
                                  ),
                              
                                ],
                              ),
                              SizedBox(
                                height: 1.5.h,
                              ),
                               Row(
                                children: [
                                   AppText(
                                    'use_Frequency'.tr()+' : ',
                                  ),
                                      Expanded(
                                    child: AppButton(
                                      height: 4.h,
                                      color: AppUi.colors.bgColor,
                                      titleColor:AppUi.colors.mainColor ,
                                     title:  '${cubit.couponItemList[index].useNumber}',
                                    ),
                                  ),
                                  
                                 
                                ],
                              ),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              Row(
                                children: [
                                   AppText(
                                    'course_name'.tr()+' : ',
                                  ),

                                    Expanded(
                                    child: AppButton(
                                      height: 4.h,
                                      color: AppUi.colors.bgColor,
                                      titleWidget:     AppText(
                                    '${cubit.couponItemList[index].course}',
                                  ),
                                    ),
                                  ),
                                  
                              
                                ],
                              ),
                              
                             
                            ],
                          ),
                        ),
                      ),
                      itemCount: cubit.couponItemList.length,
                    )

                   
                    );
              }),
        );
      },
    );
  }
}
