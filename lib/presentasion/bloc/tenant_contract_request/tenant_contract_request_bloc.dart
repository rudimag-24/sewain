import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sewain/data/datasources/tenant/tenant_contract_request_remote_datasource.dart';
import 'package:sewain/data/models/request/tenant/tenant_contract_request_request_model.dart';
import 'package:sewain/data/models/response/tenant/tenant_contract_request_response_model.dart';

part 'tenant_contract_request_event.dart';
part 'tenant_contract_request_state.dart';
part 'tenant_contract_request_bloc.freezed.dart';

class TenantContractRequestBloc
    extends Bloc<TenantContractRequestEvent, TenantContractRequestState> {
  final TenantContractRequestRemoteDatasource remoteDatasource;

  TenantContractRequestBloc(this.remoteDatasource) : super(const _Initial()) {
    on<_GetList>(_onGetList);
    on<_GetDetail>(_onGetDetail);
    on<_Extend>(_onExtend);
    on<_Stop>(_onStop);
  }

  Future<void> _onGetList(
    _GetList event,
    Emitter<TenantContractRequestState> emit,
  ) async {
    emit(const TenantContractRequestState.loading());

    final result = await remoteDatasource.list(
      type: event.type,
      status: event.status,
    );

    result.fold(
      (error) => emit(TenantContractRequestState.error(error)),
      (data) => emit(TenantContractRequestState.listLoaded(data.data)),
    );
  }

  Future<void> _onGetDetail(
    _GetDetail event,
    Emitter<TenantContractRequestState> emit,
  ) async {
    emit(const TenantContractRequestState.loading());

    final result = await remoteDatasource.detail(event.id);

    result.fold(
      (error) => emit(TenantContractRequestState.error(error)),
      (data) => emit(TenantContractRequestState.detailLoaded(data.data)),
    );
  }

  Future<void> _onExtend(
    _Extend event,
    Emitter<TenantContractRequestState> emit,
  ) async {
    emit(const TenantContractRequestState.loading());

    final result = await remoteDatasource.extend(event.request);

    result.fold(
      (error) => emit(TenantContractRequestState.error(error)),
      (data) => emit(TenantContractRequestState.success(data.message)),
    );
  }

  Future<void> _onStop(
    _Stop event,
    Emitter<TenantContractRequestState> emit,
  ) async {
    emit(const TenantContractRequestState.loading());

    final result = await remoteDatasource.stop(event.request);

    result.fold(
      (error) => emit(TenantContractRequestState.error(error)),
      (data) => emit(TenantContractRequestState.success(data.message)),
    );
  }
}
