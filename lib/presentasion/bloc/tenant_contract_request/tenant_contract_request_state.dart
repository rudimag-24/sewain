part of 'tenant_contract_request_bloc.dart';

@freezed
class TenantContractRequestState with _$TenantContractRequestState {
  const factory TenantContractRequestState.initial() = _Initial;
  const factory TenantContractRequestState.loading() = _Loading;

  const factory TenantContractRequestState.listLoaded(
    List<TenantContractRequestModel> items,
  ) = _ListLoaded;

  const factory TenantContractRequestState.detailLoaded(
    TenantContractRequestModel? item,
  ) = _DetailLoaded;

  const factory TenantContractRequestState.success(String message) = _Success;

  const factory TenantContractRequestState.error(String message) = _Error;
}
