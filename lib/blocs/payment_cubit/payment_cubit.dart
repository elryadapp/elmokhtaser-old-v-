import 'dart:io';
import 'package:elmoktaser_elshamel/blocs/cart_cubit/cart_cubit.dart';
import 'package:elmoktaser_elshamel/models/banks_model.dart';
import 'package:elmoktaser_elshamel/models/coupons_model.dart';
import 'package:elmoktaser_elshamel/models/payment_error_model.dart';
import 'package:elmoktaser_elshamel/models/sent_cart_model.dart';
import 'package:elmoktaser_elshamel/repos/auth_repo.dart';
import 'package:elmoktaser_elshamel/repos/payment_repo.dart';
import 'package:elmoktaser_elshamel/routes/app_routes.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());
  static PaymentCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  void changeIndex(index) {
    currentIndex = index;
    emit(ChangeIndexState());
  }

  //==========================bank transfer paper================
  File? bankTransferImage;
  ImagePicker picker = ImagePicker();
  Future<void> uploadBankTransfer() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      bankTransferImage = File(pickedFile.path);
      emit(UploadBnakImageSuccessState());
    }
  }

//=========================get all coupons==================

  CouponsModel? couponsModel;
  List<CouponItem> couponItemList = [];
  Future<void> getAllCoupons() async {
    emit(GetCouponsLoadingState());
    try {
      var res = await AuthRepositories.getCoupons();

      if (res['status'] < 300) {
        couponsModel = CouponsModel.fromJson(res);
        couponItemList = couponsModel?.data ?? [];
        emit(GetCouponsLoadedState());
      } else {
        AppUtil.appLoader(height: 18.h);
        emit(GetCouponsErrorState());
      }
    } catch (error) {
      emit(GetCouponsErrorState());
    }
  }

  //=======================get banks data=============
  BanksModel? banksModel;
  List<SingleBankData> banksList = [];
  Future<void> getBanksData() async {
    emit(GetBanksDataLoadingState());
    try {
      var res = await PaymentRepositories.getBanksData();
      if (res['status'] < 300) {
        banksModel = BanksModel.fromJson(res);
        banksList = banksModel?.data ?? [];
        emit(GetBanksDataLoadedState());
      } else {
        emit(GetBanksDataErrorState());
      }
    } catch (error) {
      emit(GetBanksDataErrorState());
    }
  }

  //=============================bank payment==========================
  final paymentFormKey = GlobalKey<FormState>();
  final bankAccountNameController = TextEditingController();
  final bankNameController = TextEditingController();
  final transferingDateController = TextEditingController();
  Future<void> bankTransfer(context) async {
    emit(BankTransferLoadingState());
    try {
     
      List<int> courseIds =
          CartCubit.get(context).cartItemList.map((e) => e.courseId!).toList();
      List<dynamic> coupon =
          CartCubit.get(context).cartItemList.map((e) => e.coupon).toList();
      List<dynamic> differences = CartCubit.get(context)
          .cartItemList
          .map((e) => e.difference)
          .toList();
      List<dynamic> prices =
          CartCubit.get(context).cartItemList.map((e) => e.price).toList();
      SendCartModel? sendCartModel = SendCartModel()
        ..bankName = bankNameController.text
        ..transferDate = transferingDateController.text
        ..type = 'by_check'
        ..userAccountName = bankAccountNameController.text
        ..courses = courseIds
        ..coupons = coupon
        ..differences = differences
        ..prices = prices;

      var res = await PaymentRepositories.bankPaymentMethod(
          query: sendCartModel.toJson(courseIds.length),
          image: bankTransferImage);
      if (res['status'] < 300) {
        AppUtil.flushbarNotification( res['data']);
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.courses, ModalRoute.withName(Routes.layout));
        bankNameController.text = '';
        transferingDateController.text = '';
        bankAccountNameController.text = '';
        bankTransferImage = null;
        emit(BankTransferLoadedState());
      } else {
        PaymentErrorClass model = PaymentErrorClass.fromJson(res['data']);
        if (model.data!.userAccountName != null) {
          AppUtil.flushbarNotification( model.data!.userAccountName);
        } else if (model.data!.bankName != null) {
          AppUtil.flushbarNotification( model.data!.bankName);
        } else if (model.data!.transferDate != null) {
          AppUtil.flushbarNotification( model.data!.transferDate);
        }

        emit(BankTransferErrorState());
      }
    } catch (error) {
      emit(BankTransferErrorState());
    }
  }
}
