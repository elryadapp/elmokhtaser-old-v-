import 'package:elmoktaser_elshamel/models/general_exams_model.dart';
import 'package:elmoktaser_elshamel/modules/tests_screens/components/test_card.dart';
import 'package:elmoktaser_elshamel/routes/app_routes.dart';
import 'package:flutter/material.dart';

class GeneralTestList extends StatelessWidget {
  final GeneralExamItem childList;

  const GeneralTestList({
    Key? key,
    required this.childList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => InkWell(
        onTap: (){
          Navigator.pushNamed(context, Routes.singleTestInfo,arguments: childList.childs![index]);
        },
        child: TestCard(
          childs: childList.childs![index],
          examItem: childList.childs![index].exams![0],
        ),
      ),
      itemCount: childList.childs?.length ?? 0,
    );
  }
}
