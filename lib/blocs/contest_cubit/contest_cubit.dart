import 'package:elmoktaser_elshamel/models/contest_model.dart';
import 'package:elmoktaser_elshamel/repos/contest_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:easy_localization/easy_localization.dart';
part 'contest_state.dart';

class ContestCubit extends Cubit<ContestState> {
  ContestCubit() : super(ContestInitial());
  static ContestCubit get(context) => BlocProvider.of(context);

  List<String> contestConditionList = [
    'first_condition'.tr(),
   'second_condition'.tr(),
   'third_condition'.tr()
  ];

  //=====================get all contest====================
  ContestModel? contestModel;
  Future<void> getAllContest() async {
    emit(GetAllContestLoadingState());

    try {
      var res = await ContestRepositories.getAllContest();
      contestModel = ContestModel.fromJson(res);
      emit(GetAllContestLoadedState());
    } catch (error) {
      emit(GetAllContestErrorState());
    }
  }

  //================get single contest===================

  ContestItemModel? contestItemModel;
  Future<void> getSingleContest(contestId) async {
    emit(GetSingleContestLoadingState());

    try {
      var res = await ContestRepositories.getSingleContest(contestId);
      contestItemModel = ContestItemModel.fromJson(res['data']);
      emit(GetSingleContestLoadedState());
    } catch (error) {
      emit(GetSingleContestErrorState());
    }
  }

  




}
