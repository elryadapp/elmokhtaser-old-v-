import 'package:elmoktaser_elshamel/models/cart_model.dart';
import 'package:elmoktaser_elshamel/models/coupons_model.dart';
import 'package:elmoktaser_elshamel/repos/cart_repo.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  static CartCubit get(context) => BlocProvider.of(context);

  //=====================get all cart items====================
  CartModel? cartModel;
  List<CartItemModel> cartItemList = [];
  Future<void> getAllCartItems(context) async {
    emit(GetAllCartLoadingState());
    try {
      var res = await CartRepositories.getCartItems();
      if (res['status'] < 300) {
        cartModel = CartModel.fromJson(res);
        cartItemList = cartModel?.data ?? [];
              couponItemList=List.generate(cartItemList.length,(index)=>null);
              
couponController=List.generate(cartItemList.length,(index)=>TextEditingController());

        emit(GetAllCartLoadedState());
      } else {
        AppUtil.flushbarNotification(res['data']);
        emit(GetAllCartErrorState());
      }
    } catch (error) {
      emit(GetAllCartErrorState());
    }
  }


  //=====================delete cart item=====================
  Future<void> deleteCartItem(cartItemId, context) async {
    emit(DeleteCartItemLoadingState());
    try {
      var res = await CartRepositories.deleteCartItems(cartItemId);
      if (res['status'] < 300) {
        AppUtil.flushbarNotification(res['data']);
        getAllCartItems(context);

        emit(DeleteCartItemLoadedState());
      } else {
        AppUtil.flushbarNotification(res['data']);
        emit(DeleteCartItemErrorState());
      }
    } catch (error) {
      emit(DeleteCartItemErrorState());
    }
  }

  //============add to cart================

  Future<void> addToCartItem(courseId, context) async {
    emit(AddToCartLoadingState());
    try {
      var res = await CartRepositories.addToCart(courseId);
      if (res['status'] < 300) {
        AppUtil.flushbarNotification(res['data']);
        getAllCartItems(context);

        emit(AddToCartLoadedState());
      } else {
        AppUtil.flushbarNotification(res['data']);

        emit(AddToCartErrorState());
      }
    } catch (error) {
      emit(AddToCartErrorState());
    }
  }

  //=======================send coupons=================
  List<TextEditingController> couponController = [];

  List<dynamic>? couponItemList = [];
  Future<void> sendCoupons(courseId, couponCode, index, context) async {
    emit(SendCourseCouponLoadingState());
    try {
      var res = await CartRepositories.sendCoupons(courseId, couponCode);
      if (res['status'] < 300) {
        couponItemList![index] = CouponItem.fromJson(res['data']);

        AppUtil.flushbarNotification('coupone'.tr());

        emit(SendCourseCouponLoadedState());
      } else {
        AppUtil.flushbarNotification(res['data']);
        couponItemList![index] = res['data'];

        emit(SendCourseCouponErrorState());
      }
    } catch (error) {
      emit(SendCourseCouponErrorState());
    }
  }
}
