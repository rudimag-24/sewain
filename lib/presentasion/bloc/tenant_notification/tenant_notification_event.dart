part of 'tenant_notification_bloc.dart';

@freezed
class TenantNotificationEvent with _$TenantNotificationEvent {
  const factory TenantNotificationEvent.started() = _Started;

  const factory TenantNotificationEvent.getList({@Default(1) int page}) =
      _GetList;

  const factory TenantNotificationEvent.getUnreadCount() = _GetUnreadCount;

  const factory TenantNotificationEvent.markRead(String id) = _MarkRead;

  const factory TenantNotificationEvent.markAllRead() = _MarkAllRead;
}
