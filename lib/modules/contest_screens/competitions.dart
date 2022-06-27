import '_exports.dart';
import 'package:flutter/material.dart';


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
