import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sewain/data/datasources/owner/owner_payment_remote_datasource.dart';
import 'package:sewain/data/models/response/owner/owner_payment_response_model.dart';

part 'owner_payment_event.dart';
part 'owner_payment_state.dart';
part 'owner_payment_bloc.freezed.dart';

class OwnerPaymentBloc extends Bloc<OwnerPaymentEvent, OwnerPaymentState> {
  final OwnerPaymentRemoteDatasource remoteDatasource;

  OwnerPaymentBloc(this.remoteDatasource) : super(const _Initial()) {
    on<_GetList>(_onGetList);
    on<_GetDetail>(_onGetDetail);
  }

  Future<void> _onGetList(
    _GetList event,
    Emitter<OwnerPaymentState> emit,
  ) async {
    emit(const OwnerPaymentState.loading());

    final result = await remoteDatasource.list(
      status: event.status,
      method: event.method,
      page: event.page,
    );

    result.fold(
      (error) => emit(OwnerPaymentState.error(error)),
      (data) => emit(OwnerPaymentState.listLoaded(data.data, data.meta)),
    );
  }

  Future<void> _onGetDetail(
    _GetDetail event,
    Emitter<OwnerPaymentState> emit,
  ) async {
    emit(const OwnerPaymentState.loading());

    final result = await remoteDatasource.detail(event.id);

    result.fold(
      (error) => emit(OwnerPaymentState.error(error)),
      (data) => emit(OwnerPaymentState.detailLoaded(data.data)),
    );
  }
}
