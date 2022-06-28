
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayiutInitial());
  static LayoutCubit get(context)=>BlocProvider.of(context);
  //===========================main Layout=========================





int currentPageIndex=0;
void changeCurrentPageIndex(newIndex){
  currentPageIndex=newIndex;
  emit(ChangePageIndexState());
}

}
