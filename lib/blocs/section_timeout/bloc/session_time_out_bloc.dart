import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:deliveryapp/app_confiq/auth_service.dart';
import 'package:equatable/equatable.dart';

part 'session_time_out_event.dart';
part 'session_time_out_state.dart';

class SessionTimeOutBloc extends Bloc<SessionTimeOutEvent, SessionTimeOutState> {
  SessionTimeOutBloc() : super(SessionTimeOutInitial()) {
    on<SessionTimeOutEvent>((event, emit)async {

if (event is SessionTimeOutUserEvent) {
        AuthService authService = AuthService();
        final getToken = await authService.getToken();
        final isExpired = await authService.isTokenExpired(getToken!);
        log("Expired  $isExpired");

        if (isExpired) {
          emit(SessionTimeOut(status: true));
        } else {
          emit(SessionTimeOut(status: false));
        }
      }
    });
  }
}
