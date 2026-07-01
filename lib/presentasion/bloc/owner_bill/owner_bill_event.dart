part of 'owner_bill_bloc.dart';

@freezed
class OwnerBillEvent with _$OwnerBillEvent {
  const factory OwnerBillEvent.started() = _Started;
  const factory OwnerBillEvent.getList({
    String? status,
    String? period,
    @Default(1) int page,
  }) = _GetList;

  const factory OwnerBillEvent.getDetail(int id) = _GetDetail;

  const factory OwnerBillEvent.create(OwnerBillCreateRequestModel request) =
      _Create;

  const factory OwnerBillEvent.update(
    int id,
    OwnerBillUpdateRequestModel request,
  ) = _Update;

  const factory OwnerBillEvent.markPaid(int id) = _MarkPaid;
}
