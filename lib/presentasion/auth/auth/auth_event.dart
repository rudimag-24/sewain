part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.started() = _Started;

  const factory AuthEvent.login(LoginRequestModel request) = _Login;

  const factory AuthEvent.logout() = _Logout;

  const factory AuthEvent.getMe() = _GetMe;

  const factory AuthEvent.changePassword(ChangePasswordRequestModel request) =
      _ChangePassword;
}
