part of 'owner_dashboard_bloc.dart';

@freezed
class OwnerDashboardEvent with _$OwnerDashboardEvent {
  const factory OwnerDashboardEvent.started() = _Started;
  const factory OwnerDashboardEvent.getDashboard() = _GetDashboard;
}
