import 'package:elmoktaser_elshamel/blocs/services/services_cubit.dart';
import 'package:elmoktaser_elshamel/models/more_options_model.dart';
import 'package:elmoktaser_elshamel/modules/layout_screens/components/more_Expansion_tile.dart';
import 'package:elmoktaser_elshamel/modules/layout_screens/components/radio_button_row.dart';
import 'package:elmoktaser_elshamel/routes/app_routes.dart';
import 'package:elmoktaser_elshamel/shared/components/animated_list_handler.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/constants.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:elmoktaser_elshamel/shared/utilities/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MoreOptionsModel> optionsList = [
      MoreOptionsModel(
          title: 'about_us'.tr(),
          icon: Icon(IconBroken.Info_Circle,color: AppUi.colors.mainColor,),
          route: Routes.about),
      MoreOptionsModel(
          title: 'Competitions'.tr(),
          icon:Icon(Icons.card_giftcard_rounded,color: AppUi.colors.mainColor,),
          route: Routes.competitions),
      MoreOptionsModel(
          title: 'latest_news'.tr(),
 icon:Icon(IconBroken.Document,color: AppUi.colors.mainColor,),
           route: Routes.news),
      MoreOptionsModel(
          title: 'privacy_policy'.tr(),
          icon: Icon(IconBroken.Shield_Done,color: AppUi.colors.mainColor,),
          route: Routes.privacy),
      MoreOptionsModel(
          title: 'Terms_and_Condtions'.tr(),
          icon: Icon(
            Icons.gavel_rounded,
            color: AppUi.colors.mainColor,
          ),
          route: Routes.termsAndConditions)
    ];
    return BlocBuilder<ServicesCubit, ServicesState>(
      builder: (context, state) {
        var cubit = ServicesCubit.get(context);
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 2.5.h),
            child: AnimatedListHandler(children: [
              ...optionsList.map(
                (e) => MoreExpansionTile(
                    ontap: () {
                      Navigator.pushNamed(context, e.route);
                    },
                    icon: e.icon,
                    title: e.title),
              ),
              Container(
                  decoration: BoxDecoration(
                    color: AppUi.colors.whiteColor,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: AppUi.colors.borderColor.withOpacity(.3),
                          blurRadius: 2)
                    ],
                  ),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      onExpansionChanged: (val) {
                        cubit.changeLangExpanedState(val);
                      },
                      title: Row(
                        children: [
                          SizedBox(
                            width: 2.w,
                          ),
                                                 Icon(Icons.public_outlined,color: AppUi.colors.mainColor,),

                          const SizedBox(
                            width: 15,
                          ),
                          AppText('change_language'.tr()),
                        ],
                      ),
                      trailing: Transform.rotate(
                          angle: cubit.isLangExpanded! ? 80 : 0,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: cubit.isLangExpanded!
                                ? AppUi.colors.mainColor
                                : AppUi.colors.subTitleColor,
                            size: 2.h,
                          )),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RadioButtonRow(
                                title: 'arabic'.tr(),
                                selectedColor: Constants.lang == 'ar'
                                    ? AppUi.colors.mainColor
                                    : AppUi.colors.whiteColor,
                                ontap: () {
                                  cubit.changeLang('ar', context);
                                  cubit.changeLangExpanedState(false);
                                },
                              ),
                              RadioButtonRow(
                                title: 'English'.tr(),
                                selectedColor: Constants.lang == 'en'
                                    ? AppUi.colors.mainColor
                                    : AppUi.colors.whiteColor,
                                ontap: () {
                                  cubit.changeLang('en', context);
                                  cubit.changeLangExpanedState(false);
                                },
                              ),
                              SizedBox(
                                height: 1.2.h,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
            ]));
      },
    );
  }
}
