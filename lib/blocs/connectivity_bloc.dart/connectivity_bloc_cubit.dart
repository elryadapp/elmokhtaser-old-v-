import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:elmoktaser_elshamel/layout/_exports.dart';
import 'package:meta/meta.dart';

part 'connectivity_bloc_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityCubitState> {
  ConnectivityCubit() : super(ConnectivityBlocInitial());
  static ConnectivityCubit get(context)=>BlocProvider.of(context);
  final Connectivity connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;


  Future<void> checkConnection({required Connectivity connectivity}) async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) {
      AppUtil.flushbarNotification('مفيش زفت نت');
      emit(DisconnectedState());
    } else {
            AppUtil.flushbarNotification('فيه زفت نت');
      emit(ConnectedState());
    }
  }
}
