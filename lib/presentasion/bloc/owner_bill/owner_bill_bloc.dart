import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sewain/data/datasources/owner/owner_bill_remote_datasource.dart';
import 'package:sewain/data/models/request/owner/owner_bill_request_model.dart';
import 'package:sewain/data/models/response/owner/owner_bill_response_model.dart';

part 'owner_bill_event.dart';
part 'owner_bill_state.dart';
part 'owner_bill_bloc.freezed.dart';

class OwnerBillBloc extends Bloc<OwnerBillEvent, OwnerBillState> {
  final OwnerBillRemoteDatasource remoteDatasource;

  OwnerBillBloc(this.remoteDatasource) : super(const _Initial()) {
    on<_GetList>(_onGetList);
    on<_GetDetail>(_onGetDetail);
    on<_Create>(_onCreate);
    on<_Update>(_onUpdate);
    on<_MarkPaid>(_onMarkPaid);
  }

  Future<void> _onGetList(_GetList event, Emitter<OwnerBillState> emit) async {
    emit(const OwnerBillState.loading());

    final result = await remoteDatasource.list(
      status: event.status,
      period: event.period,
      page: event.page,
    );

    result.fold(
      (error) => emit(OwnerBillState.error(error)),
      (data) => emit(OwnerBillState.listLoaded(data.data, data.meta)),
    );
  }

  Future<void> _onGetDetail(
    _GetDetail event,
    Emitter<OwnerBillState> emit,
  ) async {
    emit(const OwnerBillState.loading());

    final result = await remoteDatasource.detail(event.id);

    result.fold(
      (error) => emit(OwnerBillState.error(error)),
      (data) => emit(OwnerBillState.detailLoaded(data.data)),
    );
  }

  Future<void> _onCreate(_Create event, Emitter<OwnerBillState> emit) async {
    emit(const OwnerBillState.loading());

    final result = await remoteDatasource.create(event.request);

    result.fold(
      (error) => emit(OwnerBillState.error(error)),
      (data) => emit(OwnerBillState.success(data.message)),
    );
  }

  Future<void> _onUpdate(_Update event, Emitter<OwnerBillState> emit) async {
    emit(const OwnerBillState.loading());

    final result = await remoteDatasource.update(event.id, event.request);

    result.fold(
      (error) => emit(OwnerBillState.error(error)),
      (data) => emit(OwnerBillState.success(data.message)),
    );
  }

  Future<void> _onMarkPaid(
    _MarkPaid event,
    Emitter<OwnerBillState> emit,
  ) async {
    emit(const OwnerBillState.loading());

    final result = await remoteDatasource.markPaid(event.id);

    result.fold(
      (error) => emit(OwnerBillState.error(error)),
      (data) => emit(OwnerBillState.success(data.message)),
    );
  }
}
