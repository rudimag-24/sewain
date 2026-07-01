part of 'owner_bill_bloc.dart';

@freezed
class OwnerBillState with _$OwnerBillState {
  const factory OwnerBillState.initial() = _Initial;
  const factory OwnerBillState.loading() = _Loading;

  const factory OwnerBillState.listLoaded(
    List<OwnerBillModel> items,
    OwnerBillMetaModel? meta,
  ) = _ListLoaded;

  const factory OwnerBillState.detailLoaded(OwnerBillModel? item) =
      _DetailLoaded;

  const factory OwnerBillState.success(String message) = _Success;

  const factory OwnerBillState.error(String message) = _Error;
}
