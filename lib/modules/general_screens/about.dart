import 'package:buildcondition/buildcondition.dart';
import 'package:elmoktaser_elshamel/blocs/services/services_cubit.dart';
import 'package:elmoktaser_elshamel/modules/general_screens/components/team_work_card.dart';
import 'package:elmoktaser_elshamel/shared/components/animated_page.dart';
import 'package:elmoktaser_elshamel/shared/components/app_app_bar.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/constants.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  void initState() {
    ServicesCubit.get(context).getAboutData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServicesCubit, ServicesState>(
      listener: (context, state) {},
      builder: (context, state) {
        var servicesCubit = ServicesCubit.get(context);
        return Scaffold(
          appBar: ElmoktaserAppbar(
            context,
            titleText: 'about_us'.tr(),
          ),
          body: BuildCondition(
              condition: state is AboutLoadingState,
              builder: (context) => AppUtil.appLoader(),
              fallback: (context) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.all(3.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (ServicesCubit.get(context)
                                .aboutModel
                                ?.data
                                ?.image !=
                            null)
                          AppSlideAnimation(
                            verticalOffset: 0,
                            horizontalOffset: -80,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                    AppUi.assets.networkImageBaseLink +
                                        ServicesCubit.get(context)
                                            .aboutModel!
                                            .data!
                                            .image!,
                                            height:30.h,
                                            fit: BoxFit.cover,
                                            width: Constants.getwidth(context),
                                            )),
                          ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.h, horizontal: 2.w),
                          child: AppText(
                            'who_we_are'.tr(),
                            color: AppUi.colors.mainColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                        AppText(
                          ServicesCubit.get(context).aboutModel?.data?.about ??
                              '',
                          textAlign: TextAlign.start,
                          fontSize: 10.sp,
                          height: 2,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.h, horizontal: 2.w),
                          child: AppText(
                            'team_work'.tr(),
                            color: AppUi.colors.mainColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(
                          height: 32.h,
                          child: ListView.builder(
                              itemCount: servicesCubit.teamsList.length,
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: ((context, index) => TeamWorkCard(
                                    team: servicesCubit.teamsList[index],
                                  ))),
                        )
                      ],
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
