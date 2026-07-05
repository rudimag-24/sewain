import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sewain/data/datasources/tenant/tenant_bill_remote_datasource.dart';
import 'package:sewain/data/models/response/tenant/tenant_bill_response_model.dart';

part 'tenant_bill_event.dart';
part 'tenant_bill_state.dart';
part 'tenant_bill_bloc.freezed.dart';

class TenantBillBloc extends Bloc<TenantBillEvent, TenantBillState> {
  final TenantBillRemoteDatasource remoteDatasource;

  TenantBillBloc(this.remoteDatasource) : super(const _Initial()) {
    on<_GetList>(_onGetList);
    on<_GetDetail>(_onGetDetail);
  }

  Future<void> _onGetList(_GetList event, Emitter<TenantBillState> emit) async {
    emit(const TenantBillState.loading());

    try {
      final result = await remoteDatasource.list(status: event.status);

      result.fold(
        (error) => emit(TenantBillState.error(error)),
        (data) => emit(
          TenantBillState.listLoaded(
            items: data.data,
            message: data.message,
            status: event.status,
          ),
        ),
      );
    } catch (e) {
      emit(TenantBillState.error(e.toString()));
    }
  }

  Future<void> _onGetDetail(
    _GetDetail event,
    Emitter<TenantBillState> emit,
  ) async {
    emit(const TenantBillState.loading());

    try {
      final result = await remoteDatasource.detail(event.id);

      result.fold(
        (error) => emit(TenantBillState.error(error)),
        (data) => emit(TenantBillState.detailLoaded(data.data)),
      );
    } catch (e) {
      emit(TenantBillState.error(e.toString()));
    }
  }
}
