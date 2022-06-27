part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

//==================cart states=================
class GetAllCartLoadingState extends CartState {}
class GetAllCartLoadedState extends  CartState {}
class GetAllCartErrorState extends   CartState {}

//==================delete cart states=================
class DeleteCartItemLoadingState extends CartState {}
class DeleteCartItemLoadedState extends  CartState {}
class DeleteCartItemErrorState extends   CartState {}

//==================add to cart states=================
class AddToCartLoadingState extends CartState {}
class AddToCartLoadedState extends  CartState {}
class AddToCartErrorState extends   CartState {}

//==================get searched course state=============
class SendCourseCouponLoadingState extends CartState {}
class SendCourseCouponLoadedState extends  CartState {}
class SendCourseCouponErrorState extends   CartState {}
