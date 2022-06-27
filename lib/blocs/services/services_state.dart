part of 'services_cubit.dart';

@immutable
abstract class ServicesState {}

class ServicesInitial extends ServicesState {}

class LangChangeState extends ServicesState {}
//===================about states============================
class AboutLoadingState extends ServicesState {}
class AboutLoadedState extends ServicesState {}
class AboutErrorState extends ServicesState {}

//=============================termes state==============================
class TermesLoadingState extends ServicesState {}
class TermesLoadedState extends ServicesState {}
class TermesErrorState extends ServicesState {}

//================================news state=======================
class NewsLoadingState extends ServicesState {}
class NewsLoadedState extends ServicesState {}
class NewsErrorState extends ServicesState {}
class PaginationLoadingState extends ServicesState {}

//=========lang states=============================
class ChangeLangExpandedState extends ServicesState {}
//=========connection states=============================
class ChangeConnectivityState extends ServicesState {}