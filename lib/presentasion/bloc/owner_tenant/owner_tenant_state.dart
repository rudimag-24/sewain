part of 'owner_tenant_bloc.dart';

@freezed
class OwnerTenantState with _$OwnerTenantState {
  const factory OwnerTenantState.initial() = _Initial;
  const factory OwnerTenantState.loading() = _Loading;

  const factory OwnerTenantState.listLoaded(List<OwnerTenantModel> items) =
      _ListLoaded;

  const factory OwnerTenantState.detailLoaded(OwnerTenantModel? item) =
      _DetailLoaded;

  const factory OwnerTenantState.success(String message) = _Success;

  const factory OwnerTenantState.error(String message) = _Error;
}
