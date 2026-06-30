import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sewain/data/datasources/tenant/tenant_dashboard_remote_datasource.dart';
import 'package:sewain/data/models/response/tenant/tenant_dashboard_response_model.dart';

part 'tenant_dashboard_event.dart';
part 'tenant_dashboard_state.dart';
part 'tenant_dashboard_bloc.freezed.dart';

class TenantDashboardBloc
    extends Bloc<TenantDashboardEvent, TenantDashboardState> {
  final TenantDashboardRemoteDatasource remoteDatasource;

  TenantDashboardBloc(this.remoteDatasource) : super(const _Initial()) {
    on<_GetDashboard>(_onGetDashboard);
  }

  Future<void> _onGetDashboard(
    _GetDashboard event,
    Emitter<TenantDashboardState> emit,
  ) async {
    emit(const TenantDashboardState.loading());

    final result = await remoteDatasource.getDashboard();

    result.fold(
      (error) => emit(TenantDashboardState.error(error)),
      (data) => emit(TenantDashboardState.loaded(data)),
    );
  }
}
