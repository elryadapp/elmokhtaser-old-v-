part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}
//====================get user notification state================
class GetUserNotificationLoadingState extends NotificationState {}
class GetUserNotificationLoadedState extends  NotificationState {}
class GetUserNotificationErrorState extends   NotificationState {}


//===============mark user notification AS readed states==============
class MarkUserNotificationAsReadedLoadingState extends NotificationState {}
class MarkUserNotificationAsReadedLoadedState extends  NotificationState {}
class MarkUserNotificationAsReadedErrorState extends   NotificationState {}