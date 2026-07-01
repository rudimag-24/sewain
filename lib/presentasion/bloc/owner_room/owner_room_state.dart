part of 'owner_room_bloc.dart';

@freezed
class OwnerRoomState with _$OwnerRoomState {
  const factory OwnerRoomState.initial() = _Initial;

  const factory OwnerRoomState.loading() = _Loading;

  const factory OwnerRoomState.listLoaded(List<OwnerRoomModel> items) =
      _ListLoaded;

  const factory OwnerRoomState.detailLoaded(OwnerRoomModel? item) =
      _DetailLoaded;

  const factory OwnerRoomState.success(String message) = _Success;

  const factory OwnerRoomState.error(String message) = _Error;
}
