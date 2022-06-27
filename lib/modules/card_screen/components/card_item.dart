import 'package:buildcondition/buildcondition.dart';
import 'package:elmoktaser_elshamel/blocs/cart_cubit/cart_cubit.dart';
import 'package:elmoktaser_elshamel/models/cart_model.dart';
import 'package:elmoktaser_elshamel/shared/components/app_btn.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text_form.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:elmoktaser_elshamel/shared/utilities/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

class CardItem extends StatelessWidget {
  final CartItemModel coursesItem;
  final int index;
  const CardItem({Key? key, required this.coursesItem, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CartCubit.get(context);
        return Card(
                child: Padding(
                  padding: EdgeInsets.all(2.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                  AppUi.assets.networkImageBaseLink +
                                      coursesItem.image!,
                                  fit: BoxFit.cover,
                                  width: 30.w,
                                  height: 10.h)),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    coursesItem.title!,
                                    maxLines: 2,
                                  ),
                                  SizedBox(height: 2.h),
                                  Row(
                                    children: [
                                      if (double.tryParse(
                                              coursesItem.price.toString()) !=
                                          null)
                                        AppText(
                                          double.parse(coursesItem.price
                                                      .toString())
                                                  .toStringAsFixed(2) +
                                              '\t' +
                                              'RS'.tr(),
                                          color: AppUi.colors.buttonColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      const Spacer(),
                                   Icon(IconBroken.Delete,color: AppUi.colors.mainColor,size: 15.sp,),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          AppUtil.appDialoge(
                                              context: context,
                                              title: 'alert'.tr(),
                                              content: Padding(
                                                padding: EdgeInsets.all(2.h),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    AppText(
                                                        'do_you_want_to_delete_this_item'
                                                            .tr()),
                                                    SizedBox(
                                                      height: 2.h,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Expanded(
                                                            child: AppButton(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          height: 4.h,
                                                          color: AppUi.colors
                                                              .buttonColor
                                                              .withOpacity(.9),
                                                          title: 'cancel'.tr(),
                                                        )),
                                                        SizedBox(
                                                          width: 3.w,
                                                        ),
                                                        Expanded(
                                                            child: AppButton(
                                                          onTap: () {
                                                           Navigator.pop(context);

   
                                                            cubit
                                                                .deleteCartItem(
                                                                    coursesItem
                                                                        .id,
                                                                    context);
                                                          },
                                                          color: AppUi.colors
                                                              .activeColor
                                                              .withOpacity(.9),
                                                          height: 4.h,
                                                          title: 'confirm'.tr(),
                                                        ))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ));
                                        },
                                        child: AppText(
                                          'delete'.tr(),
                                          color: AppUi.colors.mainColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      if (cubit.couponItemList![index] == null)
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.h, horizontal: 2.w),
                          child: Divider(
                            color: AppUi.colors.borderColor,
                            thickness: 1.5,
                          ),
                        ),
                      if (cubit.couponItemList![index] == null)
                        AppText('coupon'.tr()),
                      if (cubit.couponItemList![index] == null)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.h),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 5,
                                  child: SizedBox(
                                    height: 5.h,
                                    child: AppTextFormFeild(
                                      controller: cubit.couponController[index],
                                      filledColor: AppUi.colors.whiteColor,
                                    ),
                                  )),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: BuildCondition(
                                      condition: state
                                              is SendCourseCouponLoadingState &&
                                          cubit.couponController[index].text !=
                                              '',
                                      builder: (context) =>
                                          AppUtil.appLoader(height: 10.h),
                                      fallback: (context) {
                                        return AppButton(
                                          onTap: () {
                                            cubit.sendCoupons(
                                                coursesItem.courseId,
                                                cubit.couponController[index]
                                                    .text,
                                                index,
                                                context);
                                          },
                                          title: 'enter'.tr(),
                                          height: 5.h,
                                        );
                                      }))
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              );
           
      },
    );
  }
}
