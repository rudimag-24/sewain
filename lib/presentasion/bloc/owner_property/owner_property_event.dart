part of 'owner_property_bloc.dart';

@freezed
class OwnerPropertyEvent with _$OwnerPropertyEvent {
  const factory OwnerPropertyEvent.started() = _Started;
  const factory OwnerPropertyEvent.getList({String? status, String? type}) =
      _GetList;

  const factory OwnerPropertyEvent.getDetail(int id) = _GetDetail;

  const factory OwnerPropertyEvent.create(OwnerPropertyRequestModel request) =
      _Create;

  const factory OwnerPropertyEvent.update(
    int id,
    OwnerPropertyRequestModel request,
  ) = _Update;

  const factory OwnerPropertyEvent.delete(int id) = _Delete;

  const factory OwnerPropertyEvent.toggleStatus(int id) = _ToggleStatus;
}
