import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sewain/data/datasources/owner/owner_property_remote_datasource.dart';
import 'package:sewain/data/models/request/owner/owner_property_request_model.dart';
import 'package:sewain/data/models/response/owner/owner_property_response_model.dart';

part 'owner_property_event.dart';
part 'owner_property_state.dart';
part 'owner_property_bloc.freezed.dart';

class OwnerPropertyBloc extends Bloc<OwnerPropertyEvent, OwnerPropertyState> {
  final OwnerPropertyRemoteDatasource remoteDatasource;

  OwnerPropertyBloc(this.remoteDatasource) : super(const _Initial()) {
    on<_GetList>(_onGetList);
    on<_GetDetail>(_onGetDetail);
    on<_Create>(_onCreate);
    on<_Update>(_onUpdate);
    on<_Delete>(_onDelete);
    on<_ToggleStatus>(_onToggleStatus);
  }

  Future<void> _onGetList(
    _GetList event,
    Emitter<OwnerPropertyState> emit,
  ) async {
    emit(const OwnerPropertyState.loading());

    final result = await remoteDatasource.list(
      status: event.status,
      type: event.type,
    );

    result.fold(
      (error) => emit(OwnerPropertyState.error(error)),
      (data) => emit(OwnerPropertyState.listLoaded(data.data)),
    );
  }

  Future<void> _onGetDetail(
    _GetDetail event,
    Emitter<OwnerPropertyState> emit,
  ) async {
    emit(const OwnerPropertyState.loading());

    final result = await remoteDatasource.detail(event.id);

    result.fold(
      (error) => emit(OwnerPropertyState.error(error)),
      (data) => emit(OwnerPropertyState.detailLoaded(data.data)),
    );
  }

  Future<void> _onCreate(
    _Create event,
    Emitter<OwnerPropertyState> emit,
  ) async {
    emit(const OwnerPropertyState.loading());

    final result = await remoteDatasource.create(event.request);

    result.fold(
      (error) => emit(OwnerPropertyState.error(error)),
      (data) => emit(OwnerPropertyState.success(data.message)),
    );
  }

  Future<void> _onUpdate(
    _Update event,
    Emitter<OwnerPropertyState> emit,
  ) async {
    emit(const OwnerPropertyState.loading());

    final result = await remoteDatasource.update(event.id, event.request);

    result.fold(
      (error) => emit(OwnerPropertyState.error(error)),
      (data) => emit(OwnerPropertyState.success(data.message)),
    );
  }

  Future<void> _onDelete(
    _Delete event,
    Emitter<OwnerPropertyState> emit,
  ) async {
    emit(const OwnerPropertyState.loading());

    final result = await remoteDatasource.delete(event.id);

    result.fold(
      (error) => emit(OwnerPropertyState.error(error)),
      (message) => emit(OwnerPropertyState.success(message)),
    );
  }

  Future<void> _onToggleStatus(
    _ToggleStatus event,
    Emitter<OwnerPropertyState> emit,
  ) async {
    final result = await remoteDatasource.toggleStatus(event.id);

    result.fold(
      (error) => emit(OwnerPropertyState.error(error)),
      (data) => emit(OwnerPropertyState.success(data.message)),
    );
  }
}
