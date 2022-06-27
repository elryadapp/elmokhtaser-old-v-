import 'package:elmoktaser_elshamel/modules/layout_screens/components/more_expansion_tile.dart';
import 'package:elmoktaser_elshamel/routes/app_routes.dart';
import 'package:elmoktaser_elshamel/shared/components/animated_list_handler.dart';
import 'package:elmoktaser_elshamel/shared/components/app_app_bar.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

class AnswersViewScreen extends StatelessWidget {
  final dynamic sutdentExamResultModel;
  const AnswersViewScreen({Key? key, required this.sutdentExamResultModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ElmoktaserAppbar(
        context,
        titleText: 'show_answers'.tr(),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 2.5.h),
          child: AnimatedListHandler(children: [
            ...sutdentExamResultModel.data!.answers!.asMap().entries.map(
                  (e) => MoreExpansionTile(
                      isExpanded: e.key == 5 ? false : true,
                      ontap: () {
                        Navigator.pushNamed(context, Routes.singleAnswerView,
                            arguments: e);
                      },
                      icon: CircleAvatar(
                        radius: 3.w,
                        backgroundColor: AppUi.colors.mainColor,
                        child: AppText(
                          e.key.toString(),
                          fontWeight: FontWeight.w500,
                          color: AppUi.colors.whiteColor,
                        ),
                      ),
                      title: 'answer_question_number'.tr()+' : (${e.key.toString()})'),
                ),
          ])),
    );
  }
}
