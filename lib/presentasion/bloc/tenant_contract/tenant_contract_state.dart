part of 'tenant_contract_bloc.dart';

@freezed
class TenantContractState with _$TenantContractState {
  const factory TenantContractState.initial() = _Initial;
  const factory TenantContractState.loading() = _Loading;

  const factory TenantContractState.loaded(TenantContractResponseModel data) =
      _Loaded;

  const factory TenantContractState.error(String message) = _Error;
}
