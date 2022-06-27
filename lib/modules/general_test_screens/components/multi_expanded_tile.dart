import 'package:buildcondition/buildcondition.dart';
import 'package:elmoktaser_elshamel/blocs/tests_cubit/tests_cubit.dart';
import 'package:elmoktaser_elshamel/models/attempts_model.dart';
import 'package:elmoktaser_elshamel/modules/general_test_screens/components/trial_details.dart';
import 'package:elmoktaser_elshamel/shared/components/app_btn.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';
class MultiExpandedTile extends StatelessWidget {
  final SingleAttempt? singleAttempt;
  final int? title;
  const MultiExpandedTile({Key? key, this.singleAttempt, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TestsCubit, TestsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TestsCubit.get(context);
        return Card(
          child: Padding(
              padding: EdgeInsets.all(1.2.h),
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                    initiallyExpanded: title == cubit.selected,
                    key: Key(title.toString()),
                    onExpansionChanged: (val) {
                      if (val) {
                        cubit.selected = title;
                        cubit.changeAttemptExpanedState();
                        cubit.getContestExamResult(singleAttempt!.id, context);
                      } else {
                        cubit.selected = -1;
                        cubit.changeAttemptExpanedState();
                      }
                    },
                    trailing: Transform.rotate(
                        angle: cubit.isAttemptExpanded![title!] ? 80 : 0,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: cubit.isAttemptExpanded![title!]
                              ? AppUi.colors.mainColor
                              : AppUi.colors.subTitleColor,
                          size: 2.h,
                        )),
                    title: AppText('attempt'.tr()+' (${title! + 1})'),
                    children: [
                      BuildCondition(
                          condition: state is GetContestExamResultLoadingState,
                          builder: (context) => AppUtil.appLoader(height: 13.h),
                          fallback: (context) {
                            if (state is GetContestExamResultLoadedState) {
                              return TrialDetails(
                                studentData: cubit.sutdentExamResultModel!,
                              );
                            } else {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 3.h),
                                child: Column(
                                  children: [
                                    Image.asset(AppUi.assets.examImg),
                                    AppButton(
                                        color: AppUi.colors.buttonColor
                                            .withOpacity(.8),
                                        title: cubit.errorMsg ?? ''),
                                  ],
                                ),
                              );
                            }
                          })
                    ]),
              )),
        );
      },
    );
  }
}
