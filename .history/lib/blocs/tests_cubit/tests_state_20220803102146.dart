part of 'tests_cubit.dart';

@immutable
abstract class TestsState {}

class TestInitial extends TestsState {}
class ChangeSelectedAnsState extends TestsState {}
class ChangeAttemptExpandedState extends TestsState{}
//================course content test states==============
class GetCourseTestLoadingState extends TestsState {}
class GetCourseTestLoadedState extends  TestsState {}
class GetCourseTestErrorState extends   TestsState {} 
class TestTimeEndedErrorState extends   TestsState {} 
//================submition states=====================
class SubmitCourseTestLoadingState extends TestsState {}
class SubmitCourseTestLoadedState extends  TestsState {}
class SubmitCourseTestErrorState extends   TestsState {} 

//================exam result states============================
class GetExameResultLoadingState extends TestsState {}
class GetExameResultLoadedState extends  TestsState {}
class GetExameResultErrorState extends   TestsState {}

//==================contest exam states=================
class GetContestExamLoadingState extends TestsState {}
class GetContestExamLoadedState extends  TestsState {}
class GetContestExamErrorState extends   TestsState {}
//==================submmit contest exam states=================
class SubmitContestExamLoadingState extends TestsState {}
class SubmitContestExamLoadedState extends  TestsState {}
class SubmitContestExamErrorState extends   TestsState {}


//==================contest exam results states=================
class GetContestExamResultLoadingState extends TestsState {}
class GetContestExamResultLoadedState extends  TestsState {}
class GetContestExamResultErrorState extends   TestsState {}


//===================get general exam categories===================
class GetGeneralExamCategoriesLoadingState extends TestsState {}
class GetGeneralExamCategoriesLoadedState extends  TestsState {}
class GetGeneralExamCategoriesErrorState extends   TestsState {}

//===================get general exam Attempets===================
class GetGeneralExamAttempetsLoadingState extends TestsState {}
class GetGeneralExamAttempetsLoadedState extends  TestsState {}
class GetGeneralExamAttempetsErrorState extends   TestsState {}


//===================get user exams ===================
class GetUserExamLoadingState extends TestsState {}
class GetUserExamLoadedState extends  TestsState {}
class GetUserExamErrorState extends   TestsState {}


