part of 'tenant_payment_bloc.dart';

@freezed
class TenantPaymentState with _$TenantPaymentState {
  const factory TenantPaymentState.initial() = _Initial;
  const factory TenantPaymentState.loading() = _Loading;

  const factory TenantPaymentState.listLoaded(List<TenantPaymentModel> items) =
      _ListLoaded;

  const factory TenantPaymentState.paymentSuccess(
    String message,
    TenantPaymentModel? payment,
  ) = _PaymentSuccess;

  const factory TenantPaymentState.receiptLoaded(
    TenantPaymentReceiptModel? receipt,
  ) = _ReceiptLoaded;

  const factory TenantPaymentState.error(String message) = _Error;
}
