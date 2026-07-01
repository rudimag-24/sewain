part of 'owner_contract_bloc.dart';

@freezed
class OwnerContractEvent with _$OwnerContractEvent {
  const factory OwnerContractEvent.started() = _Started;
  const factory OwnerContractEvent.getList({String? status}) = _GetList;

  const factory OwnerContractEvent.getDetail(int id) = _GetDetail;

  const factory OwnerContractEvent.create(
    OwnerContractCreateRequestModel request,
  ) = _Create;

  const factory OwnerContractEvent.update(
    int id,
    OwnerContractUpdateRequestModel request,
  ) = _Update;

  const factory OwnerContractEvent.endContract(int id) = _EndContract;
}
