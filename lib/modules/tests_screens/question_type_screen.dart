import 'dart:convert';

import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:elmoktaser_elshamel/blocs/tests_cubit/tests_cubit.dart';
import 'package:elmoktaser_elshamel/layout/_exports.dart';
import 'package:elmoktaser_elshamel/models/couse_exam.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text_form.dart';
import 'package:elmoktaser_elshamel/shared/components/question_card.dart';
import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';


class QuetionType extends StatefulWidget {
  final int index;
  final Widget? child;
  final List<MQuestion> quetions;
  const QuetionType(
      {Key? key, required this.index, required this.quetions, this.child})
      : super(key: key);

  @override
  State<QuetionType> createState() => _QuetionTypeState();
}

class _QuetionTypeState extends State<QuetionType> {
  List<DragAndDropList> content = [];
  Map<String, dynamic> answerList = {};

  @override
  void initState() {
    super.initState();

    content = [
      DragAndDropList(
          canDrag: true,
          children: List.generate(widget.quetions.length, (index) {
            List<MQuestion> q = TestsCubit.get(context).userAnswers!;
            return DragAndDropItem(
              canDrag: true,
              child: Container(
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
                        '${q.isNotEmpty ? q[index].an : widget.quetions[index].an!}',
                        color: AppUi.colors.whiteColor,
                      ),
                      backgroundColor: AppUi.colors.mainColor,
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    AppText(
                      q.isNotEmpty ? q[index].a! : widget.quetions[index].a!,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            );
          }))
    ];
    var cubit = TestsCubit.get(context);

    if (cubit.qusetionList[widget.index].type == 'multi_choice') {
      answerList.addAll({
        '1': cubit.qusetionList[widget.index].answer1.toString(),
        '2': cubit.qusetionList[widget.index].answer2.toString(),
        '3': cubit.qusetionList[widget.index].answer3.toString(),
        '4': cubit.qusetionList[widget.index].answer4.toString(),
      });
    } else {
      answerList.addAll({
        '1': cubit.qusetionList[widget.index].answer1.toString(),
        '0': cubit.qusetionList[widget.index].answer2.toString(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TestsCubit, TestsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TestsCubit.get(context);

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              QuestionCard(
                  question: cubit.qusetionList[widget.index],
                  questionNum: '${widget.index + 1}'),
              if (widget.child != null) widget.child!,
              if (cubit.qusetionList[widget.index].type == 'multi_choice' ||
                  cubit.qusetionList[widget.index].type == 'true_false')
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...answerList.entries.map(
                      (e) => RadioListTile(
                          title: Html(data: e.value),
                          value: e.key,
                          groupValue: cubit.selectedAns[cubit.currentPage!],
                          onChanged: (val) {
                            cubit.changeSelectedAns(val, cubit.currentPage!);
                          }),
                    ),
                  ],
                ),
              if (cubit.qusetionList[widget.index].type == 'textual')
                AppTextFormFeild(
                  maxLines: 8,
                  onChange: (ans) {
                    cubit.selectedAns[widget.index] = ans;
                    cubit.change();
                  },
                  filledColor: AppUi.colors.whiteColor,
                  hint: 'write_your_answer_here'.tr(),
                ),
              if (cubit.qusetionList[widget.index].type == 'matching')
                AppText(
                  'questions'.tr(),
                  color: AppUi.colors.mainColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              if (cubit.qusetionList[widget.index].type == 'matching')
                ...widget.quetions.asMap().entries.map((e) => Container(
                      margin: EdgeInsets.symmetric(vertical: .5.h),
                      padding: EdgeInsets.all(1.5.h),
                      decoration: BoxDecoration(
                          color: AppUi.colors.whiteColor,
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: AppUi.colors.borderColor)),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 3.w,
                            child: AppText(
                              '${e.value.qn!}',
                              color: AppUi.colors.whiteColor,
                            ),
                            backgroundColor: AppUi.colors.mainColor,
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          AppText(
                            e.value.q!,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    )),
              if (cubit.qusetionList[widget.index].type == 'matching')
                Padding(
                  padding: EdgeInsets.symmetric(vertical: .5.h),
                  child: AppText(
                    'answers'.tr(),
                    fontSize: 14.sp,
                    color: AppUi.colors.mainColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              if (cubit.qusetionList[widget.index].type == 'matching')
                SizedBox(
                  height: Constants.getHeight(context)*.4,
                  child: DragAndDropLists(
                    children: content,
                    onItemReorder: (int oldItemIndex, int oldListIndex,
                        int newItemIndex, int newListIndex) {
                      var movedItem = content[oldListIndex]
                          .children
                          .removeAt(oldItemIndex);
                      content[newListIndex]
                          .children
                          .insert(newItemIndex, movedItem);
                      var movedAnswer =
                          cubit.userAnswers!.removeAt(oldItemIndex);
                      cubit.userAnswers!.insert(newItemIndex, movedAnswer);
                    
                        
                      cubit.selectedAns[widget.index] =
                          json.encode(cubit.userAnswers);
                        
                      cubit.change();
                    },
                    onListReorder: (int oldListIndex, int newListIndex) {},
                  ),
                ),
                SizedBox(height: 5.h,)
            ],
          ),
        );
      },
    );
  }
}
