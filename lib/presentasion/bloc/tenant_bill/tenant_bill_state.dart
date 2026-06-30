part of 'tenant_bill_bloc.dart';

@freezed
class TenantBillState with _$TenantBillState {
  const factory TenantBillState.initial() = _Initial;

  const factory TenantBillState.loading() = _Loading;

  const factory TenantBillState.listLoaded({
    required List<TenantBillModel> items,
    String? message,
    String? status,
  }) = _ListLoaded;

  const factory TenantBillState.detailLoaded(TenantBillModel? item) =
      _DetailLoaded;

  const factory TenantBillState.error(String message) = _Error;
}
