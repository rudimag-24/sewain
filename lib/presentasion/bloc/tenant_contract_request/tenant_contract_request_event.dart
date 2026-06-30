part of 'tenant_contract_request_bloc.dart';

@freezed
class TenantContractRequestEvent with _$TenantContractRequestEvent {
  const factory TenantContractRequestEvent.started() = _Started;
  const factory TenantContractRequestEvent.getList({
    String? type,
    String? status,
  }) = _GetList;

  const factory TenantContractRequestEvent.getDetail(int id) = _GetDetail;

  const factory TenantContractRequestEvent.extend(
    TenantContractExtendRequestModel request,
  ) = _Extend;

  const factory TenantContractRequestEvent.stop(
    TenantContractStopRequestModel request,
  ) = _Stop;
}
