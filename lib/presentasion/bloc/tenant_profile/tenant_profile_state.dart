part of 'tenant_profile_bloc.dart';

@freezed
class TenantProfileState with _$TenantProfileState {
  const factory TenantProfileState.initial() = _Initial;
  const factory TenantProfileState.loading() = _Loading;

  const factory TenantProfileState.loaded(TenantProfileResponseModel data) =
      _Loaded;

  const factory TenantProfileState.success(String message) = _Success;

  const factory TenantProfileState.error(String message) = _Error;
}
