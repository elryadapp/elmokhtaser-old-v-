import 'package:buildcondition/buildcondition.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elmoktaser_elshamel/blocs/profile_cubit/profile_cubit.dart';
import 'package:elmoktaser_elshamel/routes/app_routes.dart';
import 'package:elmoktaser_elshamel/shared/components/app_app_bar.dart';
import 'package:elmoktaser_elshamel/shared/components/app_btn.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text_form.dart';
import 'package:elmoktaser_elshamel/shared/components/custom_image.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:elmoktaser_elshamel/shared/utilities/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  @override
  void initState() {
ProfileCubit.get(context).getUserData(context);
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
            titleText: 'setting'.tr(),
          ),
          body: BuildCondition(
              condition: state is GetUserLoadingState,
              builder: (context) => AppUtil.appLoader(height: 18.h),
              fallback: (context) {
                return Padding(
                  padding: EdgeInsets.all(2.7.h),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Form(
                      key: cubit.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         const CustomeAppImage()
                         ,
                          Padding(
                            padding:
                                EdgeInsetsDirectional.only(top: 2.h, bottom: 1.h),
                            child:  AppText(
                              'Name'.tr(),
                            ),
                          ),
                        AppTextFormFeild(
                                filledColor: AppUi.colors.bgColor,
                                controller: cubit.userNameController,
                                isFilled: true,
                                                              suffixIcon: const Icon(IconBroken.Edit_Square),

                                hint: 'user_name'.tr(),
                                validation: true,
                                prefixIcon: Icon(
                                  IconBroken.User,
                                  color:
                                      AppUi.colors.subTitleColor.withOpacity(.5),
                                  size: 6.w,
                                ),
                              ),
                            
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 2.h,
                            ),
                            child:  AppText(
                              'E-mail'.tr(),
                            ),
                          ),
                          AppTextFormFeild(
                              filledColor: AppUi.colors.bgColor,
                              isFilled: true,
                              suffixIcon: const Icon(IconBroken.Edit_Square),
                              hint: 'example@gmail.com',
                              textInputType: TextInputType.emailAddress,
                              controller: cubit.userEmailController,
                              prefixIcon: Icon(
                                IconBroken.Message,
                                size: 6.w,
                                color: AppUi.colors.subTitleColor.withOpacity(.5),
                              ),
                            ),
                          
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 2.h,
                            ),
                            child:  AppText(
                              'Phone'.tr(),
                            ),
                          ),
                         AppTextFormFeild(
                              filledColor: AppUi.colors.bgColor,
                              isFilled: true,
                              hint: 'Phone'.tr(),
                              validator: (value) {
                                      if (value!.isEmpty) {
                      return 'this_field_is_required'.tr();
                                      }
                                     else if (value.length < 9||value.length > 9) {
                      return 'phone_error_msg'.tr();
                    }
                                      return null;
                                    },
                              suffixIcon: const Icon(IconBroken.Edit_Square),
                              controller: cubit.userPhoneNumberController,
                              textInputType: TextInputType.phone,
                              prefixIcon: Icon(
                                IconBroken.Call,
                                size: 6.w,
                                color: AppUi.colors.subTitleColor.withOpacity(.5),
                              ),
                            ),
                          
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 3.h),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.passwordEditing);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                 Icon(IconBroken.Lock,color: AppUi.colors.whiteColor,),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  AppText(
                                    'edit_password'.tr(),
                                    color: AppUi.colors.mainColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                            ),
                          ),
                           BuildCondition(
                             condition: state is UpdateUserLoadingState,
                             builder: (context)=>AppUtil.appLoader(height: 18.h),
                    
                    
                             fallback: (context) {
                               return AppButton(title: 'save'.tr(),
                               onTap: (){
                                if(cubit.formKey.currentState!.validate()){
                                   cubit.updateUser(context);
                                }
                              
                               },
                          
                          );
                             }
                           )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
