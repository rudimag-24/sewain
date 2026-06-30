part of 'tenant_bill_bloc.dart';

@freezed
class TenantBillEvent with _$TenantBillEvent {
  const factory TenantBillEvent.started() = _Started;

  const factory TenantBillEvent.getList({String? status}) = _GetList;

  const factory TenantBillEvent.getDetail(int id) = _GetDetail;
}
