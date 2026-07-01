import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sewain/data/datasources/owner/owner_tenant_remote_datasource.dart';
import 'package:sewain/data/models/request/owner/owner_tenant_request_model.dart';
import 'package:sewain/data/models/response/owner/owner_tenant_response_model.dart';

part 'owner_tenant_event.dart';
part 'owner_tenant_state.dart';
part 'owner_tenant_bloc.freezed.dart';

class OwnerTenantBloc extends Bloc<OwnerTenantEvent, OwnerTenantState> {
  final OwnerTenantRemoteDatasource remoteDatasource;

  OwnerTenantBloc(this.remoteDatasource) : super(const _Initial()) {
    on<_GetList>(_onGetList);
    on<_GetDetail>(_onGetDetail);
    on<_Create>(_onCreate);
    on<_Update>(_onUpdate);
    on<_ResetPassword>(_onResetPassword);
  }

  Future<void> _onGetList(
    _GetList event,
    Emitter<OwnerTenantState> emit,
  ) async {
    emit(const OwnerTenantState.loading());

    final result = await remoteDatasource.list(search: event.search);

    result.fold(
      (error) => emit(OwnerTenantState.error(error)),
      (data) => emit(OwnerTenantState.listLoaded(data.data)),
    );
  }

  Future<void> _onGetDetail(
    _GetDetail event,
    Emitter<OwnerTenantState> emit,
  ) async {
    emit(const OwnerTenantState.loading());

    final result = await remoteDatasource.detail(event.id);

    result.fold(
      (error) => emit(OwnerTenantState.error(error)),
      (data) => emit(OwnerTenantState.detailLoaded(data.data)),
    );
  }

  Future<void> _onCreate(_Create event, Emitter<OwnerTenantState> emit) async {
    emit(const OwnerTenantState.loading());

    final result = await remoteDatasource.create(event.request);

    result.fold(
      (error) => emit(OwnerTenantState.error(error)),
      (data) => emit(OwnerTenantState.success(data.message)),
    );
  }

  Future<void> _onUpdate(_Update event, Emitter<OwnerTenantState> emit) async {
    emit(const OwnerTenantState.loading());

    final result = await remoteDatasource.update(event.id, event.request);

    result.fold(
      (error) => emit(OwnerTenantState.error(error)),
      (data) => emit(OwnerTenantState.success(data.message)),
    );
  }

  Future<void> _onResetPassword(
    _ResetPassword event,
    Emitter<OwnerTenantState> emit,
  ) async {
    emit(const OwnerTenantState.loading());

    final result = await remoteDatasource.resetPassword(
      event.id,
      event.request,
    );

    result.fold(
      (error) => emit(OwnerTenantState.error(error)),
      (data) => emit(OwnerTenantState.success(data.message)),
    );
  }
}
