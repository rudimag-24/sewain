part of 'owner_tenant_bloc.dart';

@freezed
class OwnerTenantEvent with _$OwnerTenantEvent {
  const factory OwnerTenantEvent.started() = _Started;
  const factory OwnerTenantEvent.getList({String? search}) = _GetList;

  const factory OwnerTenantEvent.getDetail(int id) = _GetDetail;

  const factory OwnerTenantEvent.create(OwnerTenantCreateRequestModel request) =
      _Create;

  const factory OwnerTenantEvent.update(
    int id,
    OwnerTenantUpdateRequestModel request,
  ) = _Update;

  const factory OwnerTenantEvent.resetPassword(
    int id,
    OwnerTenantResetPasswordRequestModel request,
  ) = _ResetPassword;
}
