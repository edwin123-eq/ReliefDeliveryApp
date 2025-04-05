// login_bloc.dart
import 'package:deliveryapp/blocs/bloc/licence%20bloc/license_event.dart';
import 'package:deliveryapp/blocs/bloc/licence%20bloc/license_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LicenseBloc extends Bloc<LoginEvent, LoginState> {
  LicenseBloc()
      : super(LoginState(
          license: '',
        )) {
    // Handler for LoginNameChanged event
    on<LoginNameChanged>((event, emit) {
      emit(state.copyWith(name: event.name));
    });

    // Handler for LoginLicenseChanged event
    on<LoginLicenseChanged>((event, emit) {
      emit(state.copyWith(license: event.license));
    });

    // Handler for LoginPasswordChanged event
    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    // Handler for LoginSubmitted event
    on<LoginSubmit>((event, emit) async {
      emit(state.copyWith(
          isSubmitting: true, isFailure: false, isSuccess: false));

      // Simulate login process
      await Future.delayed(Duration(seconds: 2));

      // Update the state based on success or failure
      if (state.license.isNotEmpty) {
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } else {
        emit(state.copyWith(isSubmitting: false, isFailure: true));
      }
    });
  }
}
