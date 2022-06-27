import 'package:buildcondition/buildcondition.dart';
import 'package:elmoktaser_elshamel/blocs/tests_cubit/tests_cubit.dart';
import 'package:elmoktaser_elshamel/modules/tests_screens/components/general_test_list.dart';
import 'package:elmoktaser_elshamel/shared/components/app_app_bar.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/components/custom_tab_bar.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

class MainTestsScreen extends StatefulWidget {
  const MainTestsScreen({Key? key}) : super(key: key);

  @override
  State<MainTestsScreen> createState() => _MainTestsScreenState();
}

class _MainTestsScreenState extends State<MainTestsScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    var cubit = TestsCubit.get(context);

    cubit.getGeneralExamCategories().then((value) => cubit.testsTabController =
        TabController(length: cubit.testsTabTitlesList.length, vsync: this));
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
            titleText: 'General_Exams'.tr(),
          ),
          body: BuildCondition(
              condition: state is GetGeneralExamCategoriesLoadingState,
              builder: (context) => AppUtil.appLoader(height: 18.h),
              fallback: (context) {
                return cubit.categoriesList.isEmpty? 
                       Column(
                                          children: [
                                            AppUtil.emptyLottie(),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                             AppText(
                                               'there_are_no_exams'.tr())
                                          ],
                                        )
                :Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Column(children: [
                    CustomTabBar(
                      tabController: cubit.testsTabController!,
                      tabTitlesList: cubit.testsTabTitlesList,
                    
                    ),
                    Expanded(
                        child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: cubit.testsTabController,
                            children: List.generate(
                                cubit.categoriesList.length,
                                (index) =>cubit.categoriesList[index].childs!.isEmpty? 
                                Column(
                                  children: [
                                    AppUtil.emptyLottie(),
                                    SizedBox(height: 3.h,)
                                    ,AppText('there_are_no_exams'.tr())
                                  ],
                                )
                                : GeneralTestList(
                                    childList: cubit.categoriesList[index]))))
                  ]),
                );
              }),
        );
      },
    );
  }
}
