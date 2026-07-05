import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sewain/data/datasources/tenant/tenant_contract_remote_datasource.dart';
import 'package:sewain/data/models/response/tenant/tenant_contract_response_model.dart';

part 'tenant_contract_event.dart';
part 'tenant_contract_state.dart';
part 'tenant_contract_bloc.freezed.dart';

class TenantContractBloc
    extends Bloc<TenantContractEvent, TenantContractState> {
  final TenantContractRemoteDatasource remoteDatasource;

  TenantContractBloc(this.remoteDatasource) : super(const _Initial()) {
    on<_GetContract>(_onGetContract);
  }

  Future<void> _onGetContract(
    _GetContract event,
    Emitter<TenantContractState> emit,
  ) async {
    emit(const TenantContractState.loading());

    try {
      final result = await remoteDatasource.getContract();

      result.fold(
        (error) => emit(TenantContractState.error(error)),
        (data) => emit(TenantContractState.loaded(data)),
      );
    } catch (e) {
      emit(TenantContractState.error(e.toString()));
    }
  }
}
