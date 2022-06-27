import 'dart:convert';
import 'package:buildcondition/buildcondition.dart';
import 'package:elmoktaser_elshamel/blocs/tests_cubit/tests_cubit.dart';
import 'package:elmoktaser_elshamel/models/couse_exam.dart';
import 'package:elmoktaser_elshamel/modules/tests_screens/components/next_prev_btn.dart';
import 'package:elmoktaser_elshamel/modules/tests_screens/question_type_screen.dart';
import 'package:elmoktaser_elshamel/routes/app_routes.dart';
import 'package:elmoktaser_elshamel/shared/components/app_app_bar.dart';
import 'package:elmoktaser_elshamel/shared/components/app_btn.dart';
import 'package:elmoktaser_elshamel/shared/components/app_list_tile.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';

import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart' as tr;
import 'package:slide_countdown/slide_countdown.dart';

class SingleTestScreen extends StatefulWidget {
  final dynamic contentChildId;
  const SingleTestScreen({Key? key, this.contentChildId}) : super(key: key);

  @override
  State<SingleTestScreen> createState() => _SingleTestScreenState();
}

class _SingleTestScreenState extends State<SingleTestScreen> {
  @override
  void initState() {
    var cubit = TestsCubit.get(context);

    if (widget.contentChildId.length == 3) {
      cubit.getContestExam(widget.contentChildId[0], context);
    } else {
      cubit.getCourseExam(context, widget.contentChildId);
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
            isLeading: true,
            leading: IconButton(
                onPressed: () {
                  if (cubit.currentPage != 0) {
                    cubit.pageController!.previousPage(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeInOut);
                    cubit.changeCurrentPage(cubit.currentPage! - 1);
                  } else {
                    Navigator.pop(context);
                  }
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: AppUi.colors.whiteColor,
                )),
            titleText: ' ',
            actions: const [],
          ),
          body: BuildCondition(
              condition: state is TestTimeEndedErrorState ||
                  state is GetCourseTestErrorState ||
                  state is GetContestExamErrorState,
              builder: (context) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppUi.assets.examImg),
                        widget.contentChildId.length == 3 &&
                                widget.contentChildId[2]
                            ? Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: AppButton(
                                    title: 'result_show'.tr(),
                                    onTap: () {
                                      Navigator.pushReplacementNamed(
                                          context, Routes.testTrial,
                                          arguments: [
                                            null,
                                            cubit.contestExamId
                                          ]);
                                    }),
                              )
                            : widget.contentChildId.length == 3 &&
                                    !widget.contentChildId[2]
                                ? Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.w),
                                    child: AppButton(
                                        title: cubit.generalExamErrorMsg,
                                        onTap: () {}),
                                  )
                                : Container(
                                    width: 75.w,
                                    padding: EdgeInsets.all(2.h),
                                    decoration: BoxDecoration(
                                        color: AppUi.colors.buttonColor
                                            .withOpacity(.5),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: AppText(
                                     cubit.errorCourseMsg??"",
                                      textAlign: TextAlign.center,
                                      color: AppUi.colors.whiteColor,
                                      fontWeight: FontWeight.w600,
                                    )),
                      ],
                    ),
                  ),
              fallback: (context) {
                return BuildCondition(
                    condition: state is GetCourseTestLoadingState ||
                        state is GetContestExamLoadingState,
                    builder: (context) => AppUtil.appLoader(),
                    fallback: (context) {
                      return Padding(
                        padding: EdgeInsets.all(3.h),
                        child: Column(
                          children: [
                            if (widget.contentChildId[1] != null)
                              Row(
                                children: [
                                  AppText(
                                    'Exam_time'.tr(),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  const Spacer(),
                                  if (cubit.contestExamModel != null ||
                                      cubit.courseExamModel != null)
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.h),
                                        child: Directionality(
                                          textDirection: TextDirection.ltr,
                                          child: SlideCountdownSeparated(
                                              onDone: () {
                                                if (widget.contentChildId
                                                        .length ==
                                                    3) {
                                                  cubit.submitContestExam(
                                                      context: context,
                                                      contestExamId: cubit
                                                          .contestExamModel!
                                                          .data!
                                                          .studentExamId,
                                                      qIds: cubit.qusetionList
                                                          .map((e) => e.id!)
                                                          .toList(),
                                                      answers:
                                                          cubit.selectedAns);
                                                } else {
                                                  cubit.submitTestAnswers(
                                                      context,
                                                      examId: cubit
                                                          .courseExamModel!
                                                          .data!
                                                          .studentExamId,
                                                      qIds: cubit.qusetionList
                                                          .map((e) => e.id!)
                                                          .toList(),
                                                      answers:
                                                          cubit.selectedAns);
                                                }
                                              },
                                              duration: Duration(
                                                  seconds: int.parse(
                                                      widget.contentChildId.length == 3
                                                          ? cubit
                                                              .contestExamModel!
                                                              .data!
                                                              .timer
                                                              .toString()
                                                              .split('.')
                                                              .last
                                                          : cubit
                                                              .courseExamModel!
                                                              .data!
                                                              .timer
                                                              .toString()
                                                              .split('.')
                                                              .last),
                                                  minutes: int.parse(
                                                      widget.contentChildId.length ==
                                                              3
                                                          ? cubit
                                                              .contestExamModel!
                                                              .data!
                                                              .timer
                                                              .toString()
                                                              .split('.')
                                                              .first
                                                          : cubit
                                                              .courseExamModel!
                                                              .data!
                                                              .timer
                                                              .toString()
                                                              .split('.')
                                                              .first))),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            Expanded(
                              child: PageView.builder(
                                  controller: cubit.pageController,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: cubit.qusetionList.length,
                                  itemBuilder: (context, index) {

                                    List<MQuestion> matchingQuestion = [];
                                    if (cubit.qusetionList[index].type ==
                                        'matching') {
                                      var j = json.decode(
                                          cubit.qusetionList[index].question!);
                                      for (var item in j) {
                                        matchingQuestion
                                            .add(MQuestion.fromJson(item));
                                      }
                                    }

                                    return SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      child: cubit.qusetionList[index].hint !=
                                          null?
                                       
                                      QuetionType(
                                          index: index,
                                          child:  Padding(
                                            padding:  EdgeInsets.only(bottom: 2.h),
                                            child: Card(
                                            child: AppListTile(
                                                title: 'explain_question'.tr(),
                                                content: Html(
                                                    data: cubit
                                                            .qusetionList[
                                                                index]
                                                            .hint ??
                                                        '')),
                                        ),
                                          ),
                                          quetions: matchingQuestion):
                                               QuetionType(
                                          index: index,
                                        
                                          quetions: matchingQuestion),
                                    );
                                  }),
                            ),
                            SizedBox(height: 2.h),
                          ],
                        ),
                      );
                    });
              }),
          bottomSheet: BuildCondition(
              condition: state is GetCourseTestLoadingState ||
                  cubit.selectedAns.isEmpty ||
                  state is TestTimeEndedErrorState ||
                  state is GetCourseTestErrorState ||
                  state is GetContestExamLoadingState,
              builder: (context) => Container(
                    height: 0.h,
                  ),
              fallback: (context) {
                return SizedBox(
                  height: 9.h,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (cubit.currentPage != 0)
                          NextPrevBtnRow(
                              onTap: () {
                                cubit.pageController!.previousPage(
                                    duration: const Duration(milliseconds: 600),
                                    curve: Curves.easeInOut);
                                cubit.changeCurrentPage(cubit.currentPage! - 1);
                              },
                              color: AppUi.colors.buttonColor,
                              title: 'perivious'.tr(),
                              icon: Icons.arrow_forward),
                        const Spacer(),
                        BuildCondition(
                            condition: state is SubmitCourseTestLoadingState ||
                                state is SubmitContestExamLoadingState,
                            builder: (context) => AppUtil.appLoader(),
                            fallback: (context) {
                              return NextPrevBtnRow(
                                  onTap: cubit.selectedAns[
                                              cubit.currentPage!] ==
                                          'not_answered'
                                      ? () {
                                          AppUtil.flushbarNotification(
                                              
                                              'please_choose_your_answer_first'
                                                  .tr());
                                        }
                                      : () {
                                          if (cubit.currentPage !=
                                              cubit.qusetionList.length - 1) {
                                            cubit.pageController!.nextPage(
                                                duration: const Duration(
                                                    milliseconds: 600),
                                                curve: Curves.easeInOut);
                                            cubit.changeCurrentPage(
                                                cubit.currentPage! + 1);
                                          } else {
                                            cubit.changeCurrentPage(0);
                                            if (widget.contentChildId.length ==
                                                3) {
                                              cubit.submitContestExam(
                                                  context: context,
                                                  contestExamId: cubit
                                                      .contestExamModel!
                                                      .data!
                                                      .studentExamId,
                                                  qIds: cubit.qusetionList
                                                      .map((e) => e.id!)
                                                      .toList(),
                                                  answers: cubit.selectedAns);
                                            } else {
                                              cubit.submitTestAnswers(context,
                                                  examId: cubit.courseExamModel!
                                                      .data!.studentExamId,
                                                  qIds: cubit.qusetionList
                                                      .map((e) => e.id!)
                                                      .toList(),
                                                  answers: cubit.selectedAns);
                                            }
                                          }
                                        },
                                  color:
                                      cubit.selectedAns[cubit.currentPage!] !=
                                                  'not_answered' ||
                                              cubit.currentPage ==
                                                  cubit.qusetionList.length - 1
                                          ? AppUi.colors.mainColor
                                          : AppUi.colors.borderColor,
                                  title: cubit.currentPage ==
                                          cubit.qusetionList.length - 1
                                      ? 'submit'.tr()
                                      : 'Next'.tr(),
                                  icon: Icons.arrow_forward);
                            }),
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
