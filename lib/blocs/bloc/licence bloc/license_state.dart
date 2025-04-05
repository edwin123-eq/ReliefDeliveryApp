// login_state.dart
class LoginState {

  final String license;
 
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  LoginState({
 
    required this.license,
    
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
  });

  LoginState copyWith({
    String? name,
    String? license,
    String? password,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return LoginState(
   
      license: license ?? this.license,
     
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }




}
