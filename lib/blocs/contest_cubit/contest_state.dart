part of 'contest_cubit.dart';

@immutable
abstract class ContestState {}

class ContestInitial extends ContestState {}
class ChangeSelectedAnsState extends ContestState {}
//==================contest states=================
class GetAllContestLoadingState extends ContestState {}
class GetAllContestLoadedState extends  ContestState {}
class GetAllContestErrorState extends   ContestState {}
//==================single contest states=================
class GetSingleContestLoadingState extends ContestState {}
class GetSingleContestLoadedState extends  ContestState {}
class GetSingleContestErrorState extends   ContestState {}



