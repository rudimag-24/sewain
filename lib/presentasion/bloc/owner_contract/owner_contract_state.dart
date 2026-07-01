part of 'owner_contract_bloc.dart';

@freezed
class OwnerContractState with _$OwnerContractState {
  const factory OwnerContractState.initial() = _Initial;
  const factory OwnerContractState.loading() = _Loading;

  const factory OwnerContractState.listLoaded(List<OwnerContractModel> items) =
      _ListLoaded;

  const factory OwnerContractState.detailLoaded(OwnerContractModel? item) =
      _DetailLoaded;

  const factory OwnerContractState.success(String message) = _Success;

  const factory OwnerContractState.error(String message) = _Error;
}
