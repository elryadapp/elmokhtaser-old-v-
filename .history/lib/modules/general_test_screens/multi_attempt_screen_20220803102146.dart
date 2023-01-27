import 'package:elmoktaser_elshamel/modules/general_test_screens/_exports.dart';

import 'package:flutter/material.dart';

class MultiAttemptScreen extends StatefulWidget {
  final dynamic attemptId;
  const MultiAttemptScreen({Key? key, required this.attemptId})
      : super(key: key);

  @override
  State<MultiAttemptScreen> createState() => _MultiAttemptScreenState();
}

class _MultiAttemptScreenState extends State<MultiAttemptScreen> {
  @override
  void initState() {
    TestsCubit.get(context).getGeneralExamAttempts(widget.attemptId);
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
              condition: state is GetGeneralExamAttempetsLoadingState,
              builder: (context) => AppUtil.appLoader(height: 18.h),
              fallback: (context) {
                return ListView.builder(
                  key:Key( cubit.selected.toString()),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => MultiExpandedTile(
                      singleAttempt: cubit.attemptsList[index],title:index),
                  itemCount: cubit.attemptsList.length,
                );
              }),
        );
      },
    );
  }
}
