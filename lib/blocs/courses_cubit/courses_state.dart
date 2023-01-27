part of 'courses_cubit.dart';

@immutable
abstract class CoursesState {}

class CoursesInitial extends CoursesState {}
class ChangeTabIndexState extends CoursesState{}
class ChangeExpandedState extends CoursesState{}
class ChangeCourseProgressState extends CoursesState{}
class ChangeSearchState extends CoursesState{}

class LoadingPaginationCoursesState extends CoursesState{}

//==============categories states=================
class GetCategoriesLoadingState extends CoursesState {}
class GetCategoriesLoadedState extends  CoursesState {}
class GetCategoriesErrorState extends   CoursesState {}

//==================courses states=================
class GetAllCoursesLoadingState extends CoursesState {}
class GetAllCoursesLoadedState extends  CoursesState {}
class GetAllCoursesErrorState extends   CoursesState {}

//=====================course content state===============
class GetCourseContentLoadingState extends CoursesState {}
class GetCourseContentLoadedState extends  CoursesState {}
class GetCourseContentErrorState extends   CoursesState {}


//===================Subscribed courses state=============
class GetSubscribedCourseLoadingState extends CoursesState {}
class GetSubscribedCourseLoadedState extends  CoursesState {}
class GetSubscribedCourseErrorState extends   CoursesState {}

//==================single course state=============
class GetSingleCourseLoadingState extends CoursesState {}
class GetSingleCourseLoadedState extends  CoursesState {}
class GetSingleCourseErrorState extends   CoursesState {}

//=====================add course to progress state================
class AddCourseToProgressLoadingState extends CoursesState {}
class AddCourseToProgressLoadedState extends  CoursesState {}
class AddCourseToProgressErrorState extends   CoursesState {}


class ChangeIsViewedState extends   CoursesState {}
//=======================attachment stats======================

class GetCourseAttachmentLoadingState extends CoursesState {}
class GetCourseAttachmentLoadedState extends  CoursesState {}
class GetCourseAttachmentErrorState extends   CoursesState {}

//==================get searched course state=============
class GetSearchedCourseLoadingState extends CoursesState {}
class GetSearchedCourseLoadedState extends  CoursesState {}
class GetSearchedCourseErrorState extends   CoursesState {}



//===================check subscription states========================
class CheckCourseSubscribtionLoadingState extends CoursesState {}
class CheckCourseSubscribtionLoadedState extends  CoursesState {}
class CheckCourseSubscribtionErrorState extends   CoursesState {}

//===================add rate states========================
class AddRateLoadingState extends CoursesState {}
class AddRateLoadedState extends  CoursesState {}
class AddRateErrorState extends   CoursesState {}

//===================update rate states========================
class UpdateRateLoadingState extends CoursesState {}
class UpdateRateLoadedState extends  CoursesState {}
class UpdateRateErrorState extends   CoursesState {}


//==================get course units state=============
class GetCourseUnitsLoadingState extends CoursesState {}
class GetCourseUnitsLoadedState extends  CoursesState {}
class GetCourseUnitsErrorState extends   CoursesState {}