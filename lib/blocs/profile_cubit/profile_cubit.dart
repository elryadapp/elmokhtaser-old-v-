import 'dart:io';
import 'dart:typed_data';
import 'package:elmoktaser_elshamel/blocs/cart_cubit/cart_cubit.dart';
import 'package:elmoktaser_elshamel/modules/certificates_screens/components/certificate_image.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:elmoktaser_elshamel/blocs/layout_cubit/layout_cubit.dart';
import 'package:elmoktaser_elshamel/models/account_model.dart';
import 'package:elmoktaser_elshamel/models/auth_models/error_model.dart';
import 'package:elmoktaser_elshamel/models/auth_models/user_certificates_model.dart';
import 'package:elmoktaser_elshamel/models/auth_models/user_model.dart';
import 'package:elmoktaser_elshamel/models/coupons_model.dart';
import 'package:elmoktaser_elshamel/models/password_editing_model.dart';
import 'package:elmoktaser_elshamel/models/profile_error_model.dart';
import 'package:elmoktaser_elshamel/repos/auth_repo.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';
import 'package:elmoktaser_elshamel/routes/app_routes.dart';
import 'package:elmoktaser_elshamel/shared/constants.dart';
import 'package:elmoktaser_elshamel/shared/network/local/cache_helper.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);
  //==========================main profile =======================================
  bool? isLangExpanded = false;
  final formKey = GlobalKey<FormState>();

  void changeLangExpanedState(val) {
    isLangExpanded = val;
    emit(ChangeLangExpandedState());
  }



  //=============================account Statemanagement===================

  List<AccountModel> billDetailsList = [
    AccountModel(
        describtion: 'الربح من التسويق بالعمولة',
        date: DateTime.now(),
        type: 'سحب',
        state: 'مؤكد',
        price: '100 ريال'),
    AccountModel(
        describtion: 'الربح من التسويق بالعمولة',
        date: DateTime.now(),
        type: 'سحب',
        state: 'مؤكد',
        price: '100 ريال')
  ];

//===================user Logout==================

  Future<void> userLogout(context) async {
    emit(LogoutLoadingState());

    try {
      var res = await AuthRepositories.userLogOut();
      if (res['data'] != null) {
        CacheHelper.clearCache(key: 'jwt');
        CacheHelper.clearCache(key: 'user_name');
        profileImage=null;
        CartCubit.get(context).cartItemList=[];
        Constants.token = '';
        Constants.userName = '';
        LayoutCubit.get(context).changeCurrentPageIndex(0);
        Navigator.pushReplacementNamed(context, Routes.login);
        emit(LogoutLoadedState());
      }
    } catch (error) {
      emit(LogoutErrorState());
    }
  }

//==================update user=================

  Future<void> updateUser(context) async {
    UserData updateUserModel = UserData()
      ..method = 'PUT'
      ..name = userNameController.text
      ..phone = userPhoneNumberController.text
      ..email = userEmailController.text;

    emit(UpdateUserLoadingState());
    try {
      if (userNameController.text != '' &&
          userPhoneNumberController.text != '' &&
          userEmailController.text != '') {
        var res = await AuthRepositories.updateUserData(profileImage,
            query: updateUserModel.toJson());
        if (res['status'] < 300) {
          AppUtil.flushbarNotification( 'updated_successfuly'.tr());
          CacheHelper.clearCache(key: 'user_name');
          CacheHelper.assignData(
              key: 'user_name', value: userNameController.text);
          Constants.userName = userNameController.text;
          LayoutCubit.get(context).changeCurrentPageIndex(0);
          Navigator.pushReplacementNamed(
            context,
            Routes.layout,
          );
          emit(UpdateUserLoadedState());
        } else {
          ErrorModel errorModel = ErrorModel.fromJson(res);
          if (errorModel.data?.email != null) {
            AppUtil.flushbarNotification( errorModel.data?.email![0]);
          } else if (errorModel.data?.name != null) {
            AppUtil.flushbarNotification( errorModel.data?.name![0]);
          } else if (errorModel.data?.password != null) {
            AppUtil.flushbarNotification(
                 errorModel.data?.password![0]);
          } else if (errorModel.data?.phone != null) {
            AppUtil.flushbarNotification( errorModel.data?.phone![0]);
          }
          emit(UpdateUserErrorState());
        }
      } else {
        AppUtil.flushbarNotification( 'info_alert'.tr());
        emit(UpdateUserErrorState());
      }
    } catch (error) {
      emit(UpdateUserErrorState());
    }
  }

//=================get user=====================
  UserModel? userModel;
  Future<void> getUserData(context) async {
    emit(GetUserLoadingState());
    try {
      var res = await AuthRepositories.getUserData();

      userModel = UserModel.fromJson(res);

      if (res['status'] == null) {
        userNameController.text = userModel!.data!.name;
        userEmailController.text = userModel!.data!.email;
        userPhoneNumberController.text = userModel!.data!.phone!;
        CacheHelper.assignData(key: 'user_name', value: userModel!.data!.name);
        emit(GetUserLoadedState());
      } else {
        AppUtil.flushbarNotification( res['status']);
        emit(GetUserErrorState());
      }
    } catch (error) {
      emit(GetUserErrorState());
    }
  }
  //====================update user password===============

  Future<void> updateUserPassword(context) async {
    emit(UpdateUserPasswordLoadingState());
    PasswordEditingModel passwordEditingModel = PasswordEditingModel()
      ..method = 'PUT'
      ..oldPassword = oldPasswordController.text
      ..newPassword = newPasswordController.text
      ..newPasswordConfirmation = newPasswordController.text;

    try {
      var res = await AuthRepositories.updateUserPassword(
          query: passwordEditingModel.toJson());
      if (res['status'] < 300) {
        AppUtil.flushbarNotification(
             'password_updated_successfully'.tr());
      } else {
        if(res['data'] is String){
AppUtil.flushbarNotification(
              res['data']);
        }
        else{
   ProfileErrorModel profileErrorModel =
            ProfileErrorModel.fromJson(res);
        if (profileErrorModel.data!.currentPassword != null) {
          AppUtil.flushbarNotification(
               profileErrorModel.data!.currentPassword![0]);
        } else if (profileErrorModel.data!.newPassword != null) {
          AppUtil.flushbarNotification(
               profileErrorModel.data!.newPassword![0]);
        } else if (profileErrorModel.data!.confirmPassword != null) {
          AppUtil.flushbarNotification(
               profileErrorModel.data!.confirmPassword![0]);
        }
        }
     
      }
      emit(UpdateUserPasswordLoadedState());
    } catch (error) {
      emit(UpdateUserPasswordErrorState());
    }
  }

  final passwordEditingFormKey = GlobalKey<FormState>();
//=================user account controllers=================
  final userNameController = TextEditingController();
  final userEmailController = TextEditingController();
  final userPhoneNumberController = TextEditingController();
  final newPasswordController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  File? profileImage;
  ImagePicker picker = ImagePicker();
  Future<void> changeImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(UploadProfileImageSuccessState());
    }
  }

  //================user certificate======================
  UserCertificatesModel? userCertificateModel;
  Future<void> getUserCertificates(context) async {
    emit(GetUserCertificatesLoadingState());
    try {
      var res = await AuthRepositories.getUserCertificate();

      userCertificateModel = UserCertificatesModel.fromJson(res);

      if (res['data'] != null) {
        emit(GetUserCertificatesLoadedState());
      } else {
        AppUtil.flushbarNotification( res['status']);
        emit(GetUserCertificatesErrorState());
      }
    } catch (error) {
      emit(GetUserCertificatesErrorState());
    }
  }

  List<bool> isNotVisable = List.generate(3, (index) => true);
  void changeVisability(index) {
    isNotVisable[index] = !isNotVisable[index];
    emit(ChangeVisibalityState());
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

  //=====================pdf dir===========================
       Uint8List? imageFile;
  ScreenshotController screenshotController = ScreenshotController();
   Future<void> takeImage(certificateItem) async {
    await screenshotController
        .captureFromWidget(
            CertificateImage(certificateItem:certificateItem))
        .then((capturedImage) {
      imageFile = capturedImage;
    });
  }
   Future<Uint8List> makeDir(imageFile) async {
    final pdf = pw.Document();
    final image = pw.MemoryImage(imageFile!);

    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Center(
        child: pw.Image(image),
      );
    }));
    return pdf.save();
  }
}
