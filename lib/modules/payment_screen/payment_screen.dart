import 'package:buildcondition/buildcondition.dart';
import 'package:elmoktaser_elshamel/blocs/cart_cubit/cart_cubit.dart';
import 'package:elmoktaser_elshamel/blocs/payment_cubit/payment_cubit.dart';
import 'package:elmoktaser_elshamel/modules/payment_screen/components/payment_info_row.dart';
import 'package:elmoktaser_elshamel/shared/components/animated_page.dart';
import 'package:elmoktaser_elshamel/shared/components/app_app_bar.dart';
import 'package:elmoktaser_elshamel/shared/components/app_btn.dart';
import 'package:elmoktaser_elshamel/shared/components/app_list_tile.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text_form.dart';
import 'package:elmoktaser_elshamel/shared/components/custom_app_dia.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:elmoktaser_elshamel/shared/utilities/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    PaymentCubit.get(context).getBanksData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = PaymentCubit.get(context);
        return Scaffold(
          appBar: ElmoktaserAppbar(
            context,
            titleText: 'payment'.tr(),
          ),
          body: Form(
            key: cubit.paymentFormKey,
            child: BuildCondition(
                condition: state is GetBanksDataLoadingState,
                builder: (context) => AppUtil.appLoader(height: 18.h),
                fallback: (context) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 2.h),
                            child: SizedBox(
                              height: 5.5.h,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: AppButton(
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(30),
                                            bottomRight: Radius.circular(30)),
                                        onTap: () {
                                          cubit.changeIndex(0);
                                        },
                                        title: 'bank_transfer'.tr()),
                                  ),
                                  Expanded(
                                    child: AppButton(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          bottomLeft: Radius.circular(30)),
                                      onTap: () {
                                        cubit.changeIndex(1);
                                      },
                                      titleWidget: Row(
                                        children: [
                                          const Spacer(),
                                          Expanded(
                                              child: Image.asset(
                                            AppUi.assets.visaLogo,
                                            height: 3.5.h,
                                          )),
                                          SizedBox(
                                            width: 1.w,
                                          ),
                                          Expanded(
                                              child: Image.asset(
                                            AppUi.assets.madaLogo,
                                            height: 3.5.h,
                                          )),
                                          const Spacer(),
                                        ],
                                      ),
                                      color: AppUi.colors.whiteColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          cubit.currentIndex == 0
                              ? AppSlideAnimation(
                                  verticalOffset: 100,
                                  child: Card(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4.w, vertical: 2.h),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ...cubit.banksList.map(
                                            (e) => AppListTile(
                                              title: e.name!,
                                              content: Column(
                                                children: [
                                                  PaymentInfoRow(
                                                      title: 'bank_name'.tr(),
                                                      info: e.name!),
                                                  PaymentInfoRow(
                                                      title: 'account_number'.tr(),
                                                      info: e.accountNumber!),
                                                  PaymentInfoRow(
                                                      title: 'iban_number'.tr(),
                                                      info: e.iban!),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const Divider(
                                            thickness: 1.1,
                                          ),
                                          PaymentInfoRow(
                                            title: 'total_cost'.tr(),
                                            info:
                                                '${CartCubit.get(context).cartModel!.total}\t' +
                                                    'RS'.tr(),
                                            titleColor: AppUi.colors.buttonColor
                                                .withOpacity(.8),
                                          ),
                                          const Divider(
                                            thickness: 1.1,
                                          ),
                                          SizedBox(height: 2.h),
                                           AppText(
                                            'bank_account_owner_name'.tr(),
                                            fontWeight: FontWeight.w600,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 2.h),
                                            child: AppTextFormFeild(
                                              prefixIcon:
                                                  const Icon(IconBroken.User),
                                              validation: true,
                                              controller: cubit
                                                  .bankAccountNameController,
                                              isFilled: false,
                                            ),
                                          ),
                                           AppText(
                                            'bank_name'.tr(),
                                            fontWeight: FontWeight.w600,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 2.h),
                                            child: InkWell(
                                              onTap: () {
                                                AppUtil.appDialoge(
                                                        context: context,
                                                        title: 'choose_bank'.tr(),
                                                        content: CustomAppDia(
                                                          errorMsg: 'please_select_bank_name'.tr(),
                                                            contentList: cubit
                                                                .banksList
                                                                .map((e) =>
                                                                    e.name!)
                                                                .toList()))
                                                    .then((value) {
                                                  cubit.bankNameController
                                                      .text = value ?? '';
                                                });
                                              },
                                              child: AppTextFormFeild(
                                                isFilled: false,
                                                prefixIcon: const Icon(
                                                    IconBroken.Location),
                                                validation: true,
                                                isEnable: false,
                                                controller:
                                                    cubit.bankNameController,
                                              ),
                                            ),
                                          ),
                                           AppText(
                                            'transfer_date'.tr(),
                                            fontWeight: FontWeight.w600,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 2.h),
                                            child: InkWell(
                                              onTap: () async {
                                                await showDatePicker(
                                                        locale: context.locale,
                                                        builder:
                                                            (context, child) {
                                                          return Theme(
                                                            data: Theme.of(
                                                                    context)
                                                                .copyWith(
                                                              colorScheme:
                                                                  ColorScheme
                                                                      .light(
                                                                primary: AppUi.colors.mainColor, 
                                                                onPrimary: AppUi.colors.whiteColor, 
                                                                onSurface: AppUi.colors.subTitleColor, 
                                                              ),
                                                              textButtonTheme:
                                                                  TextButtonThemeData(
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  primary: AppUi.colors.mainColor 
                                                                ),
                                                              ),
                                                            ),
                                                            child: child!,
                                                          );
                                                        },
                                                        context: context,
                                                        initialDate: DateTime(
                                                          DateTime.now().year,
                                                          DateTime.now().month,
                                                          DateTime.now().day 
                                                              ,
                                                        ),
                                                        lastDate: DateTime(
                                                          DateTime.now().year,
                                                          DateTime.now().month,
                                                          DateTime.now().day 
                                                              ,
                                                        ),
                                                        firstDate:
                                                            DateTime(2020))
                                                    .then((value) {
                                               
                                                    cubit.transferingDateController
                                                            .text =
                                                        value
                                                            .toString()
                                                            .substring(0, 10);
                                                 
                                                });
                                              },
                                              child: AppTextFormFeild(
                                                prefixIcon: const Icon(
                                                    IconBroken.Calendar),
                                                isEnable: false,
                                                validation: true,
                                                controller: cubit
                                                    .transferingDateController,
                                                isFilled: false,
                                              ),
                                            ),
                                          ),
                                           AppText(
                                            'image'.tr(),
                                            fontWeight: FontWeight.w600,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 2.h),
                                            child: InkWell(
                                              onTap: () {
                                                cubit.uploadBankTransfer();
                                              },
                                              child: AppTextFormFeild(
                                                hint: cubit.bankTransferImage
                                                        ?.path ??
                                                    'choose_bill_image'.tr(),
                                                isFilled: false,
                                                isEnable: false,
                                                suffixIcon: const Icon(
                                                    IconBroken.Camera),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          BuildCondition(
                                              condition: state
                                                  is BankTransferLoadingState,
                                              builder: (context) =>
                                                  AppUtil.appLoader(
                                                      height: 18.h),
                                              fallback: (context) {
                                                return AppButton(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    onTap: () {
                                                      if (cubit
                                                              .bankTransferImage ==
                                                          null) {
                                                        AppUtil.flushbarNotification(
                                                            
                                                            'please_choose_image_first'.tr());
                                                      }
                                                      if (cubit.paymentFormKey
                                                          .currentState!
                                                          .validate()) {
                                                        cubit.bankTransfer(
                                                            context);
                                                      }
                                                      cubit.bankTransfer(
                                                          context);
                                                    },
                                                    title: 'confirm_payment_process'.tr(),
                                                    color: AppUi
                                                        .colors.buttonColor);
                                              })
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : AppSlideAnimation(
                                  verticalOffset: 100,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 30.h, right: 5.w, left: 5.w),
                                    child: AppButton(
                                      color: AppUi.colors.buttonColor
                                          .withOpacity(.9),
                                      title: 'this_service_will_be_avaliable_soon'.tr(),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        );
      },
    );
  }
}
