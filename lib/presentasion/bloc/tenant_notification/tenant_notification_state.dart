part of 'tenant_notification_bloc.dart';

@freezed
class TenantNotificationState with _$TenantNotificationState {
  const factory TenantNotificationState.initial() = _Initial;

  const factory TenantNotificationState.loading() = _Loading;

  const factory TenantNotificationState.listLoaded(
    TenantNotificationListResponseModel data,
  ) = _ListLoaded;

  const factory TenantNotificationState.unreadCountLoaded(int count) =
      _UnreadCountLoaded;

  const factory TenantNotificationState.success(String message) = _Success;

  const factory TenantNotificationState.error(String message) = _Error;
}
