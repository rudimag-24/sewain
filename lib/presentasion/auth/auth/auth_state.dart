part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;

  const factory AuthState.loginSuccess(AuthResponseModel data) = _LoginSuccess;

  const factory AuthState.userLoaded(AuthUserModel user) = _UserLoaded;

  const factory AuthState.success(String message) = _Success;

  const factory AuthState.error(String message) = _Error;
}
