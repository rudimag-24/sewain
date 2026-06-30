part of 'tenant_payment_bloc.dart';

@freezed
class TenantPaymentEvent with _$TenantPaymentEvent {
  const factory TenantPaymentEvent.started() = _Started;
  const factory TenantPaymentEvent.getList() = _GetList;

  const factory TenantPaymentEvent.simulate(int billId) = _Simulate;

  const factory TenantPaymentEvent.getReceipt(int paymentId) = _GetReceipt;
}
