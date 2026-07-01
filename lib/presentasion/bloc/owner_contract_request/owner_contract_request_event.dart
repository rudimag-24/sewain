part of 'owner_contract_request_bloc.dart';

@freezed
class OwnerContractRequestEvent with _$OwnerContractRequestEvent {
  const factory OwnerContractRequestEvent.started() = _Started;
  const factory OwnerContractRequestEvent.getList({
    String? status,
    String? type,
  }) = _GetList;

  const factory OwnerContractRequestEvent.getDetail(int id) = _GetDetail;

  const factory OwnerContractRequestEvent.approve(
    int id,
    OwnerContractRequestActionRequestModel request,
  ) = _Approve;

  const factory OwnerContractRequestEvent.reject(
    int id,
    OwnerContractRequestActionRequestModel request,
  ) = _Reject;
}
