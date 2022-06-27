
import 'package:elmoktaser_elshamel/models/notification_model.dart';
import 'package:elmoktaser_elshamel/repos/auth_repo.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());
  static NotificationCubit get(context) => BlocProvider.of(context);
  //============get user notification====================
  NotificationModel? notificationModel;
  List<NotificationItemModel> notificationsList = [];
  List<NotificationItemModel> unreadedNotification=[];
  Future<void> getUserNotification(context) async {
     notificationsList = [];
   unreadedNotification=[];
    emit(GetUserNotificationLoadingState());
    try {
      var res = await AuthRepositories.getUserNotifications();
      if (res['status'] < 300) {
             notificationsList = [];
   unreadedNotification=[];
        notificationModel = NotificationModel.fromJson(res);
        notificationsList.addAll(notificationModel!.data!);
        for(var item in notificationsList){
          if(item.readAt==null){
            unreadedNotification.add(item);
          }
        }
        emit(GetUserNotificationLoadedState());
      } else {
        AppUtil.flushbarNotification( res['data']);
        emit(GetUserNotificationErrorState());
      }
    } catch (error) {
      emit(GetUserNotificationErrorState());
    }
  }

  //=====================mark notification as readed==========

  Future<void> markNotificationAsReaded(NotificationItemModel notificationId,context) async {
    emit(MarkUserNotificationAsReadedLoadingState());
    try {

      await AuthRepositories.markNotificationAsReaded(notificationId.id);
      
   
   getUserNotification(context);
      emit(MarkUserNotificationAsReadedLoadedState());
    } catch (error) {
      emit(MarkUserNotificationAsReadedErrorState());
    }
  }

  }