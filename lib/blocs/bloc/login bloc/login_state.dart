import 'package:deliveryapp/login_module/model/login_response.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginResponse response;

  LoginSuccess(this.response);
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);
}
