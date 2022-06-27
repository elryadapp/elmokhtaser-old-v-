
import 'package:flutter/material.dart';
import 'package:elmoktaser_elshamel/modules/general_screens/_exports.dart';


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
