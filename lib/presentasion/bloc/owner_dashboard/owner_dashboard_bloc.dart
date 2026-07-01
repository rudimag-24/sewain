import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sewain/data/datasources/owner/owner_dashboard_remote_datasource.dart';
import 'package:sewain/data/models/response/owner/owner_dashboard_response_model.dart';

part 'owner_dashboard_event.dart';
part 'owner_dashboard_state.dart';
part 'owner_dashboard_bloc.freezed.dart';

class OwnerDashboardBloc
    extends Bloc<OwnerDashboardEvent, OwnerDashboardState> {
  final OwnerDashboardRemoteDatasource remoteDatasource;

  OwnerDashboardBloc(this.remoteDatasource) : super(const _Initial()) {
    on<_GetDashboard>(_onGetDashboard);
  }

  Future<void> _onGetDashboard(
    _GetDashboard event,
    Emitter<OwnerDashboardState> emit,
  ) async {
    emit(const OwnerDashboardState.loading());

    final result = await remoteDatasource.getDashboard();

    result.fold(
      (error) => emit(OwnerDashboardState.error(error)),
      (data) => emit(OwnerDashboardState.loaded(data)),
    );
  }
}
