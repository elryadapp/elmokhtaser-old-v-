import 'package:elmoktaser_elshamel/blocs/profile_cubit/profile_cubit.dart';
import 'package:elmoktaser_elshamel/modules/layout_screens/profile_screens/account_statemanagement_screens/account_card.dart';
import 'package:elmoktaser_elshamel/shared/components/app_app_bar.dart';
import 'package:elmoktaser_elshamel/shared/components/app_btn.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/constants.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:elmoktaser_elshamel/shared/utilities/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart'as tr;
class AccountStatementScreen extends StatelessWidget {
  const AccountStatementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        return Scaffold(
            appBar: ElmoktaserAppbar(
              context,
              titleText: 'Account_statement'.tr(),
            ),
            body: Padding(
              padding: EdgeInsets.all(2.5.h),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: Constants.getHeight(context) * .27,
                            width: Constants.getwidth(context),
                            decoration: BoxDecoration(
                                color: AppUi.colors.whiteColor,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 3,
                                      color: AppUi.colors.shadeColor)
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                AppText(
                                  'profits'.tr(),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                AppButton(
                                  width: 30.w,
                                  height: 5.5.h,
                                  title: '100 '+'RS'.tr(),
                                  color: AppUi.colors.borderColor,
                                  onTap: () {},
                                ),
                                AppButton(
                                  height: 5.5.h,
                                  color: AppUi.colors.buttonColor,
                                  title: 'profit_withdrawal'.tr(),
                                  width: 30.w,
                                  onTap: () {},
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.h),
                            child: AppText(
                              'Financial_transactions'.tr()+' : ',
                              textAlign: TextAlign.start,
                              color: AppUi.colors.mainColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(IconBroken.Filter,color: AppUi.colors.mainColor,),
                              SizedBox(
                                width: 3.w,
                              ),
                               AppText(
                                'Filter_by_date'.tr(),
                                fontWeight: FontWeight.w600,
                              )
                            ],
                          ),
                      
                          Padding(
                            padding:  EdgeInsets.symmetric(vertical: 2.h),
                            child: Row(
                              children: [
                                Expanded(
                                    child: AppButton(
                                  border: Border.all(
                                      color: AppUi.colors.borderColor
                                          .withOpacity(.5)),
                                  color: AppUi.colors.whiteColor,
                                  titleWidget: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.w),
                                    child: Row(
                                      children: [
                                        const AppText('ابريل'),
                                        const Spacer(),
                                        Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: AppUi.colors.subTitleColor,
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Expanded(
                                    child: AppButton(
                                        border: Border.all(
                                            color: AppUi.colors.borderColor
                                                .withOpacity(.5)),
                                        color: AppUi.colors.whiteColor,
                                        titleWidget: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.w),
                                          child: Row(
                                            children: [
                                              const AppText('2022'),
                                              const Spacer(),
                                              Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                  color:
                                                      AppUi.colors.subTitleColor)
                                            ],
                                          ),
                                        )))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (context, index) => AccountCard(
                              accountModel: cubit.billDetailsList[index]),
                          childCount: cubit.billDetailsList.length),
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}
