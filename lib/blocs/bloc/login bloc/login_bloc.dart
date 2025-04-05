import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deliveryapp/login_module/controller/repo.dart';
import 'package:deliveryapp/blocs/bloc/login bloc/login_state.dart';
import 'package:deliveryapp/blocs/bloc/login bloc/login_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      SharedPreferences logindata = await SharedPreferences.getInstance();
      final response = await login(event.username, event.password);
      logindata.setString("token", response.accessToken);
      logindata.setString("refresh_token", response.refreshToken);
      logindata.setString("userId", response.userId.toString());
      logindata.setString("userName", response.userName.toString());
      logindata.setBool("isLogin", true);
      emit(LoginSuccess(response));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
