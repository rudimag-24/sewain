part of 'owner_contract_request_bloc.dart';

@freezed
class OwnerContractRequestState with _$OwnerContractRequestState {
  const factory OwnerContractRequestState.initial() = _Initial;
  const factory OwnerContractRequestState.loading() = _Loading;

  const factory OwnerContractRequestState.listLoaded(
    List<OwnerContractRequestModel> items,
  ) = _ListLoaded;

  const factory OwnerContractRequestState.detailLoaded(
    OwnerContractRequestModel? item,
  ) = _DetailLoaded;

  const factory OwnerContractRequestState.success(String message) = _Success;

  const factory OwnerContractRequestState.error(String message) = _Error;
}
