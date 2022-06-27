
import 'package:flutter/material.dart';
import 'package:elmoktaser_elshamel/modules/general_test_screens/_exports.dart';


class TrialDetails extends StatelessWidget {
  final SutdentExamResultModel studentData;
  const TrialDetails({Key? key, required this.studentData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TestsCubit, TestsState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit=TestsCubit.get(context);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.5.h, vertical: .5.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 35.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  child: GridView.builder(
                      itemCount: 4,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.5,
                          crossAxisSpacing: 3.w,
                          mainAxisSpacing: 2.h),
                      itemBuilder: (context, index) => TestDetailsContainer(
                            color: cubit.containerTitles[index].color,
                            subTitle: cubit.testTrialInfo[index],
                            title: cubit.containerTitles[index].title,
                          )),
                ),
              ),
             AppText(
                'analytical_result'.tr()+':',
                color: AppUi.colors.mainColor,
                fontWeight: FontWeight.w700,
                fontSize: 13.sp,
              ),
            
              
                if(cubit.badResultSubjectList.isNotEmpty) Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child:  AppText(
                  'Topics_that_need_review'.tr()+' : ',
                  fontWeight: FontWeight.w600,
                ),
              ),
              ...cubit.badResultSubjectList.map((e) => Row(
                    children: [
                      Icon(
                        Icons.remove,
                        color: AppUi.colors.mainColor,
                      ),
                      AppText(e)
                    ],
                  )),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 15.w),
                child: AppButton(
                  title: 'show_answers'.tr(),
                  onTap: () {
                     cubit.selected=-1;
                    Navigator.pushNamed(context, Routes.answersView,arguments: studentData);
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
