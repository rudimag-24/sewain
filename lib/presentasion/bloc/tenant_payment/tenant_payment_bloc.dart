import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sewain/data/datasources/tenant/tenant_payment_remote_datasource.dart';
import 'package:sewain/data/models/response/tenant/tenant_payment_response_model.dart';

part 'tenant_payment_event.dart';
part 'tenant_payment_state.dart';
part 'tenant_payment_bloc.freezed.dart';

class TenantPaymentBloc extends Bloc<TenantPaymentEvent, TenantPaymentState> {
  final TenantPaymentRemoteDatasource remoteDatasource;

  TenantPaymentBloc(this.remoteDatasource) : super(const _Initial()) {
    on<_GetList>(_onGetList);
    on<_Simulate>(_onSimulate);
    on<_GetReceipt>(_onGetReceipt);
  }

  Future<void> _onGetList(
    _GetList event,
    Emitter<TenantPaymentState> emit,
  ) async {
    emit(const TenantPaymentState.loading());

    final result = await remoteDatasource.list();

    result.fold(
      (error) => emit(TenantPaymentState.error(error)),
      (data) => emit(TenantPaymentState.listLoaded(data.data)),
    );
  }

  Future<void> _onSimulate(
    _Simulate event,
    Emitter<TenantPaymentState> emit,
  ) async {
    emit(const TenantPaymentState.loading());

    final result = await remoteDatasource.simulate(event.billId);

    result.fold(
      (error) => emit(TenantPaymentState.error(error)),
      (data) =>
          emit(TenantPaymentState.paymentSuccess(data.message, data.data)),
    );
  }

  Future<void> _onGetReceipt(
    _GetReceipt event,
    Emitter<TenantPaymentState> emit,
  ) async {
    emit(const TenantPaymentState.loading());

    final result = await remoteDatasource.receipt(event.paymentId);

    result.fold(
      (error) => emit(TenantPaymentState.error(error)),
      (data) => emit(TenantPaymentState.receiptLoaded(data.data)),
    );
  }
}
