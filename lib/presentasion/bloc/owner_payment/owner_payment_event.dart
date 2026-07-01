part of 'owner_payment_bloc.dart';

@freezed
class OwnerPaymentEvent with _$OwnerPaymentEvent {
  const factory OwnerPaymentEvent.started() = _Started;
  const factory OwnerPaymentEvent.getList({
    String? status,
    String? method,
    @Default(1) int page,
  }) = _GetList;

  const factory OwnerPaymentEvent.getDetail(int id) = _GetDetail;
}
