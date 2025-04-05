// login_event.dart
abstract class LoginEvent {}

class LoginNameChanged extends LoginEvent {
  final String name;
  LoginNameChanged(this.name);
}

class LoginLicenseChanged extends LoginEvent {
  final String license;
  LoginLicenseChanged(this.license);
}

class LoginPasswordChanged extends LoginEvent {
  final String password;
  LoginPasswordChanged(this.password);
}

class LoginSubmit extends LoginEvent {
  
}
