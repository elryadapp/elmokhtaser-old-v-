
import 'package:flutter/material.dart';
import 'package:elmoktaser_elshamel/modules/general_screens/_exports.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  @override
  void initState() {
    ServicesCubit.get(context).getPrivacyData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var privacyCubit = ServicesCubit.get(context);
    return BlocConsumer<ServicesCubit, ServicesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: ElmoktaserAppbar(
            context,
            titleText: 'privacy_policy'.tr(),
          ),
          body: BuildCondition(
              condition: state is TermesLoadingState,
              builder: (context) => AppUtil.appLoader(),
              fallback: (context) {
                return AppSlideAnimation(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 3.h, horizontal: 4.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...privacyCubit.privacyList.map((e) => Column(
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
                                  HtmlWidget(e.content!),
                                  SizedBox(height: 1.2.h,)
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
