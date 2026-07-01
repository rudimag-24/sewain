part of 'owner_payment_bloc.dart';

@freezed
class OwnerPaymentState with _$OwnerPaymentState {
  const factory OwnerPaymentState.initial() = _Initial;
  const factory OwnerPaymentState.loading() = _Loading;

  const factory OwnerPaymentState.listLoaded(
    List<OwnerPaymentModel> items,
    OwnerPaymentMetaModel? meta,
  ) = _ListLoaded;

  const factory OwnerPaymentState.detailLoaded(OwnerPaymentModel? item) =
      _DetailLoaded;

  const factory OwnerPaymentState.error(String message) = _Error;
}
