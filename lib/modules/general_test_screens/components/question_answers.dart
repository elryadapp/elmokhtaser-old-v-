
import 'package:flutter/material.dart';
import 'package:elmoktaser_elshamel/modules/general_test_screens/_exports.dart';

class QuestionAnswer extends StatelessWidget {
  final QuestionsResults questionsResults;
  final AnswersResult answersResult;
  const QuestionAnswer(
      {Key? key, required this.questionsResults, required this.answersResult})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, String> answerList = {};
    if (questionsResults.type == 'multi_choice') {
      answerList.addAll({
        '1': questionsResults.answer1.toString(),
        '2': questionsResults.answer2.toString(),
        '3': questionsResults.answer3.toString(),
        '4': questionsResults.answer4.toString(),
      });
    } else {
      answerList.addAll({
        '1': questionsResults.answer1.toString(),
        '0': questionsResults.answer2.toString(),
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (questionsResults.type == 'multi_choice' ||
            questionsResults.type == 'true_false')
          ...answerList.entries.map(
            (e) => Container(
              padding: EdgeInsets.all(2.h),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(.6.w),
                    width: 4.w,
                    height: 4.w,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: AppUi.colors.borderColor,
                        ),
                        shape: BoxShape.circle),
                    child: CircleAvatar(
                        backgroundColor: answersResult.type == '0' &&
                                e.key == answersResult.studentAnswer
                            ? AppUi.colors.buttonColor.withOpacity(.8)
                            : e.key == questionsResults.trueAnswer
                                ? AppUi.colors.activeColor
                                : AppUi.colors.whiteColor),
                  ),
                  SizedBox(
                    width: 2.5.w,
                  ),
                  AppText(e.value)
                ],
              ),
              margin: EdgeInsets.symmetric(vertical: 1.h),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: answersResult.type == '0' &&
                              e.key == answersResult.studentAnswer
                          ? AppUi.colors.buttonColor
                          : e.key == questionsResults.trueAnswer
                              ? AppUi.colors.activeColor
                              : AppUi.colors.whiteColor),
                  borderRadius: BorderRadius.circular(5),
                  color: AppUi.colors.whiteColor,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2,
                        color: AppUi.colors.shadeColor.withOpacity(.3))
                  ]),
            ),
          ),
        if (questionsResults.type == 'textual' && answersResult.type == '0')
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                width: Constants.getwidth(context),
                padding: EdgeInsets.all(2.h),
                child: AppText(answersResult.studentAnswer!),
                margin: EdgeInsets.symmetric(vertical: 1.h),
                decoration: BoxDecoration(
                    border: Border.all(color: AppUi.colors.buttonColor),
                    borderRadius: BorderRadius.circular(5),
                    color: AppUi.colors.whiteColor,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2,
                          color: AppUi.colors.shadeColor.withOpacity(.3))
                    ]),
              ),
              PositionedDirectional(
                end: 1.5.w,
                child: CircleAvatar(
                  backgroundColor: AppUi.colors.buttonColor,
                  radius: 4.w,
                  child: Icon(
                    Icons.cancel_outlined,
                    color: AppUi.colors.whiteColor,
                  ),
                ),
              )
            ],
          ),
        if (questionsResults.type == 'textual' && answersResult.type == '1')
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                width: Constants.getwidth(context),
                padding: EdgeInsets.all(2.h),
                child: AppText(answersResult.studentAnswer!),
                margin: EdgeInsets.symmetric(vertical: 1.h),
                decoration: BoxDecoration(
                    border: Border.all(color: AppUi.colors.activeColor),
                    borderRadius: BorderRadius.circular(5),
                    color: AppUi.colors.whiteColor,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2,
                          color: AppUi.colors.shadeColor.withOpacity(.3))
                    ]),
              ),
              PositionedDirectional(
                end: 1.5.w,
                child: CircleAvatar(
                  backgroundColor: AppUi.colors.activeColor,
                  radius: 4.w,
                  child: Icon(
                    Icons.check_circle_outline_rounded,
                    color: AppUi.colors.whiteColor,
                  ),
                ),
              )
            ],
          ),
        if (questionsResults.type == 'textual' && answersResult.type == '2')
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                width: Constants.getwidth(context),
                padding: EdgeInsets.all(2.h),
                child: AppText(answersResult.studentAnswer!),
                margin: EdgeInsets.symmetric(vertical: 1.h),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.amber),
                    borderRadius: BorderRadius.circular(5),
                    color: AppUi.colors.whiteColor,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2,
                          color: AppUi.colors.shadeColor.withOpacity(.3))
                    ]),
              ),
              PositionedDirectional(
                end: 1.5.w,
                child: CircleAvatar(
                  backgroundColor: Colors.amber,
                  radius: 4.w,
                  child: Icon(
                    Icons.error_outline_rounded,
                    color: AppUi.colors.whiteColor,
                  ),
                ),
              )
            ],
          ),
        if (questionsResults.type == 'matching')
          Builder(builder: (context) {
            List<MQuestion> matchingQuestion = [];

            var j = json.decode(questionsResults.question!);
            for (var item in j) {
              matchingQuestion.add(MQuestion.fromJson(item));
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  'questions'.tr(),
                  color: AppUi.colors.mainColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
                ...matchingQuestion.map((e) => Container(
                      margin: EdgeInsets.symmetric(vertical: .5.h),
                      padding: EdgeInsets.all(1.5.h),
                      decoration: BoxDecoration(
                          color: AppUi.colors.whiteColor,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: AppUi.colors.borderColor)),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 3.w,
                            child: AppText(
                              '${e.qn!}',
                              color: AppUi.colors.whiteColor,
                            ),
                            backgroundColor: AppUi.colors.mainColor,
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          AppText(
                            e.q!,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 2.h,
                ),
                AppText(
                  'answers'.tr(),
                  color: AppUi.colors.mainColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
                ...matchingQuestion.map((e) => Container(
                      margin: EdgeInsets.symmetric(vertical: .5.h),
                      padding: EdgeInsets.all(1.5.h),
                      decoration: BoxDecoration(
                          color: AppUi.colors.whiteColor,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: answersResult.type == '0'
                                  ? AppUi.colors.buttonColor
                                  : AppUi.colors.activeColor)),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 3.w,
                            child: AppText(
                              '${e.an!}',
                              color: AppUi.colors.whiteColor,
                            ),
                            backgroundColor: answersResult.type == '0'
                                ? AppUi.colors.buttonColor
                                : AppUi.colors.activeColor,
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          AppText(
                            e.a!,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ))
              ],
            );
          })
      ],
    );
  }
}
