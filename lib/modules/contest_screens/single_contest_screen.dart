import 'package:buildcondition/buildcondition.dart';
import 'package:elmoktaser_elshamel/blocs/contest_cubit/contest_cubit.dart';
import 'package:elmoktaser_elshamel/blocs/tests_cubit/tests_cubit.dart';
import 'package:elmoktaser_elshamel/modules/contest_screens/components/contest_conditions_row.dart';
import 'package:elmoktaser_elshamel/routes/app_routes.dart';
import 'package:elmoktaser_elshamel/shared/components/app_app_bar.dart';
import 'package:elmoktaser_elshamel/shared/components/app_btn.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class SingleContestScreen extends StatefulWidget {
  final dynamic contestId;
  const SingleContestScreen({Key? key, required this.contestId})
      : super(key: key);

  @override
  State<SingleContestScreen> createState() => _SingleContestScreenState();
}

class _SingleContestScreenState extends State<SingleContestScreen> {
  @override
  void initState() {
    ContestCubit.get(context).getSingleContest(widget.contestId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContestCubit, ContestState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ContestCubit.get(context);
        return Scaffold(
            backgroundColor: AppUi.colors.bgColor,
            appBar: ElmoktaserAppbar(
              context,
              titleText: 'contest_details'.tr(),
            ),
            body: BuildCondition(
                condition: state is GetSingleContestLoadingState||state is GetContestExamLoadingState ,
                builder: (context) => AppUtil.appLoader(height: 18.h),
                fallback: (context) {
                  return Padding(
                    padding: EdgeInsets.all(2.h),
                    child: Card(
                        child: Padding(
                      padding: EdgeInsets.all(2.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                           Center(
                            child: AppText(
                              'Contest_titled'.tr(),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 1.2.h),
                              child: AppText(
                                '(${cubit.contestItemModel!.mainCat!})',
                                color: AppUi.colors.mainColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.h),
                            child: AppText(
                              'hint_condition'.tr(),
                              fontSize: 11.sp,
                              height: 2,
                              color: AppUi.colors.subTitleColor.withOpacity(.7),
                            ),
                          ),
                          AppText(
                            'conditions'.tr(),
                            color: AppUi.colors.mainColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.sp,
                          ),
                          SizedBox(
                            height: 2.5.h,
                          ),
                          ...cubit.contestConditionList.asMap().entries.map(
                              (e) => ContestConditionsRow(
                                  title:  e.value)),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 2.5.h),
                            child: AppButton(
                              title: 'enter_contest'.tr(),
                              onTap: () {
                                Navigator.pushNamed(context, Routes.singleTest,
                                    arguments: [
                                      widget.contestId,
                                      cubit.contestItemModel!.examTime,
                                      true
                                    ]);
                              },
                              height: 5.7.h,
                            ),
                          )
                        ],
                      ),
                    )),
                  );
                }));
      },
    );
  }
}
