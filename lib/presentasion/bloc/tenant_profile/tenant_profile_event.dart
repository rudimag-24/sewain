part of 'tenant_profile_bloc.dart';

@freezed
class TenantProfileEvent with _$TenantProfileEvent {
  const factory TenantProfileEvent.started() = _Started;
  const factory TenantProfileEvent.getProfile() = _GetProfile;

  const factory TenantProfileEvent.updateProfile(
    TenantProfileUpdateRequestModel request,
  ) = _UpdateProfile;
}
