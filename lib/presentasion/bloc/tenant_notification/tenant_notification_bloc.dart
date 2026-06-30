import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sewain/data/datasources/tenant/tenant_notification_remote_datasource.dart';
import 'package:sewain/data/models/response/tenant/tenant_notification_response_model.dart';

part 'tenant_notification_event.dart';
part 'tenant_notification_state.dart';
part 'tenant_notification_bloc.freezed.dart';

class TenantNotificationBloc
    extends Bloc<TenantNotificationEvent, TenantNotificationState> {
  final TenantNotificationRemoteDatasource remoteDatasource;

  TenantNotificationBloc(this.remoteDatasource) : super(const _Initial()) {
    on<_GetList>(_onGetList);
    on<_GetUnreadCount>(_onGetUnreadCount);
    on<_MarkRead>(_onMarkRead);
    on<_MarkAllRead>(_onMarkAllRead);
  }

  Future<void> _onGetList(
    _GetList event,
    Emitter<TenantNotificationState> emit,
  ) async {
    emit(const TenantNotificationState.loading());

    final result = await remoteDatasource.list(page: event.page);

    result.fold(
      (error) => emit(TenantNotificationState.error(error)),
      (data) => emit(TenantNotificationState.listLoaded(data)),
    );
  }

  Future<void> _onGetUnreadCount(
    _GetUnreadCount event,
    Emitter<TenantNotificationState> emit,
  ) async {
    final result = await remoteDatasource.unreadCount();

    result.fold(
      (error) => emit(TenantNotificationState.error(error)),
      (data) => emit(TenantNotificationState.unreadCountLoaded(data.count)),
    );
  }

  Future<void> _onMarkRead(
    _MarkRead event,
    Emitter<TenantNotificationState> emit,
  ) async {
    final result = await remoteDatasource.markRead(event.id);

    result.fold(
      (error) => emit(TenantNotificationState.error(error)),
      (data) => emit(TenantNotificationState.success(data.message)),
    );
  }

  Future<void> _onMarkAllRead(
    _MarkAllRead event,
    Emitter<TenantNotificationState> emit,
  ) async {
    emit(const TenantNotificationState.loading());

    final result = await remoteDatasource.markAllRead();

    result.fold(
      (error) => emit(TenantNotificationState.error(error)),
      (data) => emit(TenantNotificationState.success(data.message)),
    );
  }
}
