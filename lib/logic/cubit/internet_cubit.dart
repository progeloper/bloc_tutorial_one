import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_tutorial_one/constants/enums.dart';
import 'package:meta/meta.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;
  InternetCubit({required this.connectivity}) : super(InternetLoading()){
    monitorConnectivityCubit();
  }

  StreamSubscription<ConnectivityResult> monitorConnectivityCubit() {
    return connectivityStreamSubscription = connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
        if(result == ConnectivityResult.wifi){
          emitInternetConnectedState(ConnectionType.Wifi);
        } else if(result == ConnectivityResult.mobile){
          emitInternetConnectedState(ConnectionType.Mobile);
        } else{
          emitInternetDisconnectedState();
        }
    });
  }



  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }

  void emitInternetConnectedState(ConnectionType connectionType) => emit(
        InternetConnected(connectionType: connectionType),
      );

  void emitInternetDisconnectedState() => emit(
        InternetDisconnected(),
      );
}
