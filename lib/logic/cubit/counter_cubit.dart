import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_tutorial_one/constants/enums.dart';
import 'package:equatable/equatable.dart';
import 'internet_cubit.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  final InternetCubit internetCubit;
  late StreamSubscription internetCubitSubscription;
  CounterCubit({required this.internetCubit})
      : super(
          CounterState(counterValue: 0, wasIncremented: false),
        ){
    monitorInternetCubit();
  }

  StreamSubscription<InternetState> monitorInternetCubit() {
    return internetCubitSubscription = internetCubit.stream.listen((InternetState state) {
      if(state is InternetConnected && state.connectionType == ConnectionType.Wifi){
        increment();
      } else if(state is InternetConnected && state.connectionType == ConnectionType.Mobile){
        decrement();
      }
    });
  }

  void increment() => emit(
        CounterState(counterValue: state.counterValue + 1, wasIncremented: true),
      );

  void decrement() => emit(
        CounterState(counterValue: state.counterValue - 1, wasIncremented: false),
      );
}
