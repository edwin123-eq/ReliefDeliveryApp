part of 'session_time_out_bloc.dart';

sealed class SessionTimeOutState extends Equatable {
  const SessionTimeOutState();
  
  @override
  List<Object> get props => [];
}
final class SessionTimeOut extends SessionTimeOutState {
  final bool status;
  const SessionTimeOut({required this.status});
}

final class SessionTimeOutInitial extends SessionTimeOutState {}

