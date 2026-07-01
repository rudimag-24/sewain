import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sewain/data/datasources/owner/owner_report_remote_datasource.dart';
import 'package:sewain/data/models/response/owner/owner_report_response_model.dart';

part 'owner_report_event.dart';
part 'owner_report_state.dart';
part 'owner_report_bloc.freezed.dart';

class OwnerReportBloc extends Bloc<OwnerReportEvent, OwnerReportState> {
  final OwnerReportRemoteDatasource remoteDatasource;

  OwnerReportBloc(this.remoteDatasource) : super(const _Initial()) {
    on<_GetReport>(_onGetReport);
  }

  Future<void> _onGetReport(
    _GetReport event,
    Emitter<OwnerReportState> emit,
  ) async {
    emit(const OwnerReportState.loading());

    final result = await remoteDatasource.getReport();

    result.fold(
      (error) => emit(OwnerReportState.error(error)),
      (data) => emit(OwnerReportState.loaded(data)),
    );
  }
}
