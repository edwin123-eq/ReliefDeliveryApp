part of 'session_time_out_bloc.dart';

sealed class SessionTimeOutEvent extends Equatable {
  const SessionTimeOutEvent();

  @override
  List<Object> get props => [];
}
final class  SessionTimeOutUserEvent extends SessionTimeOutEvent {
 
  const SessionTimeOutUserEvent();
}
