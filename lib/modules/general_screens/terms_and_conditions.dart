import 'package:buildcondition/buildcondition.dart';
import 'package:elmoktaser_elshamel/blocs/services/services_cubit.dart';
import 'package:elmoktaser_elshamel/shared/components/animated_page.dart';
import 'package:elmoktaser_elshamel/shared/components/app_app_bar.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:easy_localization/easy_localization.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  void initState() {
    ServicesCubit.get(context).getTermesData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var termsCubit = ServicesCubit.get(context);
    return BlocConsumer<ServicesCubit, ServicesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: ElmoktaserAppbar(
            context,
            titleText: 'Terms_and_Condtions'.tr(),
          ),
          body: BuildCondition(
              condition: state is TermesLoadingState,
              builder: (context) => AppUtil.appLoader(),
              fallback: (context) {
                return AppSlideAnimation(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 3.h, horizontal: 4.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...termsCubit.termesList.map((e) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    e.title ?? '',
                                    color: AppUi.colors.mainColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                 HtmlWidget(e.content!)
                                ],
                              ))
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
