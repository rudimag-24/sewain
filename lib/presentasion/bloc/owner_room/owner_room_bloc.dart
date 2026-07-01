import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sewain/data/datasources/owner/owner_room_remote_datasource.dart';
import 'package:sewain/data/models/request/owner/owner_room_request_model.dart';
import 'package:sewain/data/models/response/owner/owner_room_response_model.dart';

part 'owner_room_event.dart';
part 'owner_room_state.dart';
part 'owner_room_bloc.freezed.dart';

class OwnerRoomBloc extends Bloc<OwnerRoomEvent, OwnerRoomState> {
  final OwnerRoomRemoteDatasource remoteDatasource;

  OwnerRoomBloc(this.remoteDatasource) : super(const _Initial()) {
    on<_GetList>(_onGetList);
    on<_GetDetail>(_onGetDetail);
    on<_Create>(_onCreate);
    on<_Update>(_onUpdate);
    on<_Delete>(_onDelete);
  }

  Future<void> _onGetList(_GetList event, Emitter<OwnerRoomState> emit) async {
    emit(const OwnerRoomState.loading());

    final result = await remoteDatasource.list(
      propertyId: event.propertyId,
      status: event.status,
    );

    result.fold(
      (error) => emit(OwnerRoomState.error(error)),
      (data) => emit(OwnerRoomState.listLoaded(data.data)),
    );
  }

  Future<void> _onGetDetail(
    _GetDetail event,
    Emitter<OwnerRoomState> emit,
  ) async {
    emit(const OwnerRoomState.loading());

    final result = await remoteDatasource.detail(
      propertyId: event.propertyId,
      roomId: event.roomId,
    );

    result.fold(
      (error) => emit(OwnerRoomState.error(error)),
      (data) => emit(OwnerRoomState.detailLoaded(data.data)),
    );
  }

  Future<void> _onCreate(_Create event, Emitter<OwnerRoomState> emit) async {
    emit(const OwnerRoomState.loading());

    final result = await remoteDatasource.create(
      propertyId: event.propertyId,
      request: event.request,
    );

    result.fold(
      (error) => emit(OwnerRoomState.error(error)),
      (data) => emit(OwnerRoomState.success(data.message)),
    );
  }

  Future<void> _onUpdate(_Update event, Emitter<OwnerRoomState> emit) async {
    emit(const OwnerRoomState.loading());

    final result = await remoteDatasource.update(
      propertyId: event.propertyId,
      roomId: event.roomId,
      request: event.request,
    );

    result.fold(
      (error) => emit(OwnerRoomState.error(error)),
      (data) => emit(OwnerRoomState.success(data.message)),
    );
  }

  Future<void> _onDelete(_Delete event, Emitter<OwnerRoomState> emit) async {
    emit(const OwnerRoomState.loading());

    final result = await remoteDatasource.delete(
      propertyId: event.propertyId,
      roomId: event.roomId,
    );

    result.fold(
      (error) => emit(OwnerRoomState.error(error)),
      (message) => emit(OwnerRoomState.success(message)),
    );
  }
}
