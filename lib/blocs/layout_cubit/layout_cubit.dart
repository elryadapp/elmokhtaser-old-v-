import 'package:elmoktaser_elshamel/layout/visitor_screen.dart';
import 'package:elmoktaser_elshamel/modules/layout_screens/home/home_screen.dart';
import 'package:elmoktaser_elshamel/modules/layout_screens/more_screen.dart';
import 'package:elmoktaser_elshamel/modules/layout_screens/personal_courses_screens/personal_courses_screen.dart';
import 'package:elmoktaser_elshamel/modules/layout_screens/profile_screens/profile_screen.dart';
import 'package:elmoktaser_elshamel/modules/notification_screen/notifications_screen.dart';
import 'package:elmoktaser_elshamel/shared/constants.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayiutInitial());
  static LayoutCubit get(context)=>BlocProvider.of(context);
  //===========================main Layout=========================

List<Widget>pages=Constants.token==''?const[
  HomeScreen(),
  VisitorScreen(),
  VisitorScreen(),
  VisitorScreen(),
  MoreScreen()
]:const[
  HomeScreen(),
  PersonalCoursesScreen(),
  NotificationScreen(),
  ProfileScreen(),
  MoreScreen()

];



int currentPageIndex=0;
void changeCurrentPageIndex(newIndex){
  currentPageIndex=newIndex;
  emit(ChangePageIndexState());
}

}
