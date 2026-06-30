part of 'tenant_contract_bloc.dart';

@freezed
class TenantContractEvent with _$TenantContractEvent {
  const factory TenantContractEvent.started() = _Started;
  const factory TenantContractEvent.getContract() = _GetContract;
}
