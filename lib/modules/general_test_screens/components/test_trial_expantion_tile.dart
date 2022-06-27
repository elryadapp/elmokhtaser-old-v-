import 'package:elmoktaser_elshamel/models/sudent_exam_result_model.dart';
import 'package:elmoktaser_elshamel/modules/general_test_screens/components/trial_details.dart';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TestTileExpantionTile extends StatelessWidget {
    final SutdentExamResultModel? studentData;

  const TestTileExpantionTile({Key? key,  this.studentData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.5.h, vertical: .5.h),
          child: Card(
            child: TrialDetails(studentData:studentData! ,)
          )
        );
    
  }
}
