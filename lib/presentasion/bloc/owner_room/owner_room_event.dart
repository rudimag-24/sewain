part of 'owner_room_bloc.dart';

@freezed
class OwnerRoomEvent with _$OwnerRoomEvent {
  const factory OwnerRoomEvent.started() = _Started;

  const factory OwnerRoomEvent.getList({
    required int propertyId,
    String? status,
  }) = _GetList;

  const factory OwnerRoomEvent.getDetail({
    required int propertyId,
    required int roomId,
  }) = _GetDetail;

  const factory OwnerRoomEvent.create({
    required int propertyId,
    required OwnerRoomRequestModel request,
  }) = _Create;

  const factory OwnerRoomEvent.update({
    required int propertyId,
    required int roomId,
    required OwnerRoomRequestModel request,
  }) = _Update;

  const factory OwnerRoomEvent.delete({
    required int propertyId,
    required int roomId,
  }) = _Delete;
}
