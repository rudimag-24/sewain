part of 'tenant_dashboard_bloc.dart';

@freezed
class TenantDashboardEvent with _$TenantDashboardEvent {
  const factory TenantDashboardEvent.started() = _Started;
  const factory TenantDashboardEvent.getDashboard() = _GetDashboard;
}
