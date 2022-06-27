import 'package:elmoktaser_elshamel/blocs/courses_cubit/courses_cubit.dart';
import 'package:elmoktaser_elshamel/shared/components/app_btn.dart';
import 'package:elmoktaser_elshamel/shared/constants.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';
class TableTab extends StatelessWidget {
  const TableTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesCubit, CoursesState>(
      builder: (context, state) {
        var cubit = CoursesCubit.get(context);

        return Padding(
                padding: EdgeInsets.all(3.h),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        AppUi.assets.homeFake1,
                        fit: BoxFit.cover,
                        height: 27.h,
                        width: Constants.getwidth(context),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      height: 27.h,
                      width: Constants.getwidth(context),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black38),
                      child: Center(
                        child: AppButton(
                          onTap: () {
                            cubit.changeIsTableViewed();
                          },
                          title: 'show_table'.tr(),
                        ),
                      ),
                    )
                  ],
                ),
              );
      },
    );
  }
}
