import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  StreamSubscription? internetSubs;
  InternetBloc() : super(InternetInitial()) {
    on<OnConnected>(
      (event, emit) {
        return emit(const Connected(message: "Connected to the intenet"));
      },
    );
    on<OnDisconnected>((event, emit) =>
        emit(const Disconnected(errorMessage: "something went wrong")));
    internetSubs = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        add(OnConnected());
      } else {
        add(OnDisconnected());
      }
    });
  }
}
