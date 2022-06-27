
import 'package:flutter/material.dart';
import 'package:elmoktaser_elshamel/modules/general_test_screens/_exports.dart';


class GeneralTestScreen extends StatefulWidget {
  const GeneralTestScreen({Key? key}) : super(key: key);

  @override
  State<GeneralTestScreen> createState() => _GeneralTestScreenState();
}

class _GeneralTestScreenState extends State<GeneralTestScreen> {
  @override
  void initState() {
 TestsCubit.get(context).getUserExams(context);

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
            titleText: 'General_Exams'.tr(),
          ),
          body: BuildCondition(
              condition: state is GetUserExamLoadingState ||
                  state is GetGeneralExamCategoriesLoadingState,
              builder: (context) => AppUtil.appLoader(height: 18.h),
              fallback: (context) {
                return cubit.userExamsList.isEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: 7.h,
                          ),
                          AppUtil.emptyLottie(),
                          SizedBox(
                            height: 4.h,
                          ),
                           AppText('You_have_no'.tr())
                        ],
                      )
                    : Padding(
                        padding: EdgeInsets.all(2.h),
                        child: AnimatedListHandler(
                            children: List.generate(
                                cubit.userExamsList.length,
                                (index) => GeneralTestCard(
                                      generalExamItem:
                                          cubit.userExamsList[index],
                                    ))),
                      );
              }),
        );
      },
    );
  }
}
