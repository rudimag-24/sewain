import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sewain/data/datasources/owner/owner_contract_remote_datasource.dart';
import 'package:sewain/data/models/request/owner/owner_contract_request_model.dart';
import 'package:sewain/data/models/response/owner/owner_contract_response_model.dart';

part 'owner_contract_event.dart';
part 'owner_contract_state.dart';
part 'owner_contract_bloc.freezed.dart';

class OwnerContractBloc extends Bloc<OwnerContractEvent, OwnerContractState> {
  final OwnerContractRemoteDatasource remoteDatasource;

  OwnerContractBloc(this.remoteDatasource) : super(const _Initial()) {
    on<_GetList>(_onGetList);
    on<_GetDetail>(_onGetDetail);
    on<_Create>(_onCreate);
    on<_Update>(_onUpdate);
    on<_EndContract>(_onEndContract);
  }

  Future<void> _onGetList(
    _GetList event,
    Emitter<OwnerContractState> emit,
  ) async {
    emit(const OwnerContractState.loading());

    final result = await remoteDatasource.list(status: event.status);

    result.fold(
      (error) => emit(OwnerContractState.error(error)),
      (data) => emit(OwnerContractState.listLoaded(data.data)),
    );
  }

  Future<void> _onGetDetail(
    _GetDetail event,
    Emitter<OwnerContractState> emit,
  ) async {
    emit(const OwnerContractState.loading());

    final result = await remoteDatasource.detail(event.id);

    result.fold(
      (error) => emit(OwnerContractState.error(error)),
      (data) => emit(OwnerContractState.detailLoaded(data.data)),
    );
  }

  Future<void> _onCreate(
    _Create event,
    Emitter<OwnerContractState> emit,
  ) async {
    emit(const OwnerContractState.loading());

    final result = await remoteDatasource.create(event.request);

    result.fold(
      (error) => emit(OwnerContractState.error(error)),
      (data) => emit(OwnerContractState.success(data.message)),
    );
  }

  Future<void> _onUpdate(
    _Update event,
    Emitter<OwnerContractState> emit,
  ) async {
    emit(const OwnerContractState.loading());

    final result = await remoteDatasource.update(event.id, event.request);

    result.fold(
      (error) => emit(OwnerContractState.error(error)),
      (data) => emit(OwnerContractState.success(data.message)),
    );
  }

  Future<void> _onEndContract(
    _EndContract event,
    Emitter<OwnerContractState> emit,
  ) async {
    emit(const OwnerContractState.loading());

    final result = await remoteDatasource.endContract(event.id);

    result.fold(
      (error) => emit(OwnerContractState.error(error)),
      (data) => emit(OwnerContractState.success(data.message)),
    );
  }
}
