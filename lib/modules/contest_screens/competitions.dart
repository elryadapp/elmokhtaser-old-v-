import 'package:buildcondition/buildcondition.dart';
import 'package:elmoktaser_elshamel/blocs/contest_cubit/contest_cubit.dart';
import 'package:elmoktaser_elshamel/modules/contest_screens/components/competition_item_card.dart';
import 'package:elmoktaser_elshamel/shared/components/animated_list_handler.dart';
import 'package:elmoktaser_elshamel/shared/components/app_app_bar.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ContestScreen extends StatelessWidget {
  const ContestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContestCubit, ContestState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ContestCubit.get(context);
        return Scaffold(
            backgroundColor: AppUi.colors.bgColor,
            appBar: ElmoktaserAppbar(
              context,
              titleText: 'Competitions'.tr(),
            ),
            body: BuildCondition(
                condition: state is GetAllContestLoadingState,
                builder: (context) => AppUtil.appLoader(height: 18.h),
                fallback: (context) {
                  return AnimatedListHandler(
                    children: [
                      ...cubit.contestModel!.data!.map(
                        (e) => ContestItemCard(contestItemModel: e),
                      )
                    ],
                  );
                }));
      },
    );
  }
}
