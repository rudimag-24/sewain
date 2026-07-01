part of 'owner_dashboard_bloc.dart';

@freezed
class OwnerDashboardState with _$OwnerDashboardState {
  const factory OwnerDashboardState.initial() = _Initial;
  const factory OwnerDashboardState.loading() = _Loading;

  const factory OwnerDashboardState.loaded(OwnerDashboardResponseModel data) =
      _Loaded;

  const factory OwnerDashboardState.error(String message) = _Error;
}
