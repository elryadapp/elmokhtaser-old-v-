part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
//===========================Single Answer View States=========================
class ChangeSelectedAnsState extends ProfileState {}
class UploadProfileImageSuccessState extends ProfileState{}
class ChangeVisibalityState extends ProfileState{}
//=================logout=================
class LogoutLoadingState extends ProfileState {}
class LogoutLoadedState extends ProfileState {}
class LogoutErrorState extends ProfileState {}

//==================get user states==============
class GetUserLoadingState extends ProfileState {}
class GetUserLoadedState extends ProfileState {}
class GetUserErrorState extends ProfileState {}

//================update User states==================
class UpdateUserLoadingState extends ProfileState {}
class UpdateUserLoadedState extends ProfileState {}
class UpdateUserErrorState extends ProfileState {}

//================user certificates state===============
class GetUserCertificatesLoadingState extends ProfileState {}
class GetUserCertificatesLoadedState extends ProfileState {}
class GetUserCertificatesErrorState extends ProfileState {}
class ChangeLangExpandedState extends ProfileState{}

//============update user password==============
class UpdateUserPasswordLoadingState extends ProfileState {}
class UpdateUserPasswordLoadedState extends ProfileState {}
class UpdateUserPasswordErrorState extends ProfileState {}

//==================Coupons states=================
class GetCouponsLoadingState extends ProfileState {}
class GetCouponsLoadedState extends  ProfileState {}
class GetCouponsErrorState extends   ProfileState {}