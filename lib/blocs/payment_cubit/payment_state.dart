part of 'payment_cubit.dart';

@immutable
abstract class PaymentState {}

class PaymentInitial extends PaymentState {}
class ChangeIndexState extends PaymentState {}
class UploadBnakImageSuccessState extends PaymentState{}

//===================bank transfer states========================
class BankTransferLoadingState extends PaymentState {}
class BankTransferLoadedState extends  PaymentState {}
class BankTransferErrorState extends   PaymentState {}

//==================Coupons states=================
class GetCouponsLoadingState extends PaymentState {}
class GetCouponsLoadedState extends  PaymentState {}
class GetCouponsErrorState extends   PaymentState {}

//==================bank data states=================
class GetBanksDataLoadingState extends PaymentState {}
class GetBanksDataLoadedState extends  PaymentState {}
class GetBanksDataErrorState extends   PaymentState {}