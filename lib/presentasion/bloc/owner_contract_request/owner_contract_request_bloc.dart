import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sewain/data/datasources/owner/owner_contract_request_remote_datasource.dart';
import 'package:sewain/data/models/request/owner/owner_contract_request_request_model.dart';
import 'package:sewain/data/models/response/owner/owner_contract_request_response_model.dart';

part 'owner_contract_request_event.dart';
part 'owner_contract_request_state.dart';
part 'owner_contract_request_bloc.freezed.dart';

class OwnerContractRequestBloc
    extends Bloc<OwnerContractRequestEvent, OwnerContractRequestState> {
  final OwnerContractRequestRemoteDatasource remoteDatasource;

  OwnerContractRequestBloc(this.remoteDatasource) : super(const _Initial()) {
    on<_GetList>(_onGetList);
    on<_GetDetail>(_onGetDetail);
    on<_Approve>(_onApprove);
    on<_Reject>(_onReject);
  }

  Future<void> _onGetList(
    _GetList event,
    Emitter<OwnerContractRequestState> emit,
  ) async {
    emit(const OwnerContractRequestState.loading());

    final result = await remoteDatasource.list(
      status: event.status,
      type: event.type,
    );

    result.fold(
      (error) => emit(OwnerContractRequestState.error(error)),
      (data) => emit(OwnerContractRequestState.listLoaded(data.data)),
    );
  }

  Future<void> _onGetDetail(
    _GetDetail event,
    Emitter<OwnerContractRequestState> emit,
  ) async {
    emit(const OwnerContractRequestState.loading());

    final result = await remoteDatasource.detail(event.id);

    result.fold(
      (error) => emit(OwnerContractRequestState.error(error)),
      (data) => emit(OwnerContractRequestState.detailLoaded(data.data)),
    );
  }

  Future<void> _onApprove(
    _Approve event,
    Emitter<OwnerContractRequestState> emit,
  ) async {
    emit(const OwnerContractRequestState.loading());

    final result = await remoteDatasource.approve(event.id, event.request);

    result.fold(
      (error) => emit(OwnerContractRequestState.error(error)),
      (data) => emit(OwnerContractRequestState.success(data.message)),
    );
  }

  Future<void> _onReject(
    _Reject event,
    Emitter<OwnerContractRequestState> emit,
  ) async {
    emit(const OwnerContractRequestState.loading());

    final result = await remoteDatasource.reject(event.id, event.request);

    result.fold(
      (error) => emit(OwnerContractRequestState.error(error)),
      (data) => emit(OwnerContractRequestState.success(data.message)),
    );
  }
}
