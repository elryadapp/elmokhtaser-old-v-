import 'package:buildcondition/buildcondition.dart';
import 'package:elmoktaser_elshamel/blocs/tests_cubit/tests_cubit.dart';
import 'package:elmoktaser_elshamel/modules/general_test_screens/components/test_trial_expantion_tile.dart';
import 'package:elmoktaser_elshamel/shared/components/app_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class TestTrialScreen extends StatefulWidget {
  final dynamic contentChild;
  const TestTrialScreen({
    Key? key,
    this.contentChild,
  }) : super(key: key);

  @override
  State<TestTrialScreen> createState() => _TestTrialScreenState();
}

class _TestTrialScreenState extends State<TestTrialScreen> {
  @override
  void initState() {
    var cubit = TestsCubit.get(context);
    if (widget.contentChild[0] != null) {
      cubit.getCourseExam(context, widget.contentChild!).then((value) {
        if (cubit.examId != null) {
          cubit.getCoursesExamResult(cubit.examId, context);
        }
      });
    } else if (widget.contentChild[1] != null) {
      cubit.getContestExam(widget.contentChild[1], context,isTrial: true).then(
          (value) => cubit.getContestExamResult(cubit.contestExamId, context,istrial: true));
    }
 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TestsCubit, TestsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TestsCubit.get(context);
        return Scaffold(
          appBar: ElmoktaserAppbar(
            context,
            titleText: 'attempt_details'.tr(),
          ),
          body: BuildCondition(
              condition: state is GetCourseTestLoadingState ||
                  state is GetExameResultLoadingState ||
                  state is GetContestExamLoadingState ||
                  state is GetContestExamResultLoadingState,
              builder: (context) => AppUtil.appLoader(height: 18.h),
              fallback: (context) {
                return cubit.sutdentExamResultModel == null
                    ? Center(
                        child: Column(
                          children: [
                            AppUtil.emptyLottie(),
                            SizedBox(
                              height: 7.h,
                            ),
                            Card(
                              color: AppUi.colors.buttonColor.withOpacity(.7),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 1.5.h, horizontal: 18.w),
                                child: AppText(
                                  cubit.errorMsg ?? '',
                                  color: AppUi.colors.whiteColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child:
                           cubit.examId != null || cubit.contestExamId != null
                                ? TestTileExpantionTile(
                                    studentData: cubit.sutdentExamResultModel!)
                                : Container());
              }),
        );
      },
    );
  }
}
