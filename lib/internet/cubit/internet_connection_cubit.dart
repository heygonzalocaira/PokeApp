import 'dart:io' show Platform;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
part 'internet_connection_state.dart';

class InternetConnectionCubit extends Cubit<InternetConnectionState> {
  InternetConnectionCubit(this._internetConnectionChecker)
      : super(const InternetConnectionState());

  final InternetConnectionChecker _internetConnectionChecker;

  Future<void> monitorInternet() async {
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      emit(state.copyWith(status: InternetStatus.haveInternet));
    }
    try {
      final internet =
          _internetConnectionChecker.onStatusChange.listen((status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            emit(state.copyWith(status: InternetStatus.haveInternet));
            break;
          case InternetConnectionStatus.disconnected:
            emit(state.copyWith(status: InternetStatus.noInternet));
            break;
        }
      });
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
