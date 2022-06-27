import 'package:elmoktaser_elshamel/blocs/tests_cubit/tests_cubit.dart';
import 'package:elmoktaser_elshamel/modules/courses_screens/course_details_screens/custom_video.dart';
import 'package:elmoktaser_elshamel/modules/general_test_screens/components/question_answers.dart';
import 'package:elmoktaser_elshamel/shared/components/app_app_bar.dart';
import 'package:elmoktaser_elshamel/shared/components/app_btn.dart';
import 'package:elmoktaser_elshamel/shared/components/app_list_tile.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/components/question_card.dart';
import 'package:elmoktaser_elshamel/shared/constants.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';
class SingleAnswerViewScreen extends StatelessWidget {
  final dynamic questionDetails;
  const SingleAnswerViewScreen({Key? key, required this.questionDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var q = TestsCubit.get(context)
        .sutdentExamResultModel!
        .data!
        .questions!
        .firstWhere(
            (element) => element.id == questionDetails.value.questionId);
    return BlocConsumer<TestsCubit, TestsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TestsCubit.get(context);
        return Scaffold(
          appBar: ElmoktaserAppbar(
            context,
            titleText: '',
          ),
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(3.h),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          AppText('degree'.tr(),
                              fontWeight: FontWeight.w600, fontSize: 14.sp),
                          SizedBox(
                            width: 4.w,
                          ),
                          AppText(
                              '${questionDetails.value.teacherDegree}/${cubit.sutdentExamResultModel!.data!.questions!.firstWhere((element) => element.id == questionDetails.value.questionId).degree}',
                              color: AppUi.colors.mainColor,
                              fontWeight: FontWeight.w600)
                        ],
                      ),
                      QuestionCard(
                          question: cubit
                              .sutdentExamResultModel!.data!.questions!
                              .firstWhere((element) =>
                                  element.id ==
                                  questionDetails.value.questionId),
                          questionNum: '${questionDetails.key + 1}'),
                      QuestionAnswer(
                        questionsResults: cubit
                            .sutdentExamResultModel!.data!.questions!
                            .firstWhere((element) =>
                                element.id == questionDetails.value.questionId),
                        answersResult: questionDetails.value,
                      ),
                      SizedBox(height: 2.h),
                      if(q.hint!=null||q.hintImage!=null||q.hintVideo!=null)
                      AppListTile(
                          title: 'answer_Explanation'.tr(),
                          content: Column(
                            children: [
                              if(q.hintImage!=null)
                              Image.network(AppUi.assets.networkImageBaseLink+q.hintImage),
                              if (q.hint != null)
                                Row(
                                  children: [
                                    AppText(
                                      'solution'.tr()+' :',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                    ),
                                    Expanded(child: Html(data: q.hint)),
                                  ],
                                ),
                              SizedBox(
                                height: 2.h,
                              ),
                              if (q.videoUrl != null)
                                AppButton(
                                  onTap: () {
                                    cubit.isVideo = true;
                                    cubit.change();
                                  },
                                  height: 5.5.h,
                                  width: 50.w,
                                  title: 'View_video_with_solution'.tr(),
                                )
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              if (cubit.isVideo)
                Container(
                  height: Constants.getHeight(context),
                  color: Colors.black38,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            cubit.isVideo = false;
                            cubit.change();
                          },
                          icon: const Icon(Icons.close_fullscreen_rounded)),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomVideo(
                        videoId: q.hintVideo!.split('?').first,
                      ),
                    ],
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
