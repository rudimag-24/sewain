part of 'tenant_dashboard_bloc.dart';

@freezed
class TenantDashboardState with _$TenantDashboardState {
  const factory TenantDashboardState.initial() = _Initial;
  const factory TenantDashboardState.loading() = _Loading;

  const factory TenantDashboardState.loaded(TenantDashboardResponseModel data) =
      _Loaded;

  const factory TenantDashboardState.error(String message) = _Error;
}
