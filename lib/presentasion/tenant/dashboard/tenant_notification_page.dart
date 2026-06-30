import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/data/models/response/tenant/tenant_notification_response_model.dart';
import 'package:sewain/presentasion/bloc/tenant_notification/tenant_notification_bloc.dart';

class TenantNotificationPage extends StatefulWidget {
  const TenantNotificationPage({super.key});

  @override
  State<TenantNotificationPage> createState() => _TenantNotificationPageState();
}

class _TenantNotificationPageState extends State<TenantNotificationPage> {
  @override
  void initState() {
    super.initState();
    _getList();
  }

  void _getList() {
    context.read<TenantNotificationBloc>().add(
      const TenantNotificationEvent.getList(),
    );
  }

  Future<void> _refresh() async {
    _getList();
  }

  void _markAllRead() {
    context.read<TenantNotificationBloc>().add(
      const TenantNotificationEvent.markAllRead(),
    );
  }

  void _markRead(String id) {
    context.read<TenantNotificationBloc>().add(
      TenantNotificationEvent.markRead(id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(
        title: const Text('Notifikasi'),
        actions: [
          TextButton(onPressed: _markAllRead, child: const Text('Baca Semua')),
        ],
      ),
      body: BlocConsumer<TenantNotificationBloc, TenantNotificationState>(
        listener: (context, state) {
          state.maybeWhen(
            success: (message) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
              _getList();
            },
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: AppColors.red,
                ),
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            listLoaded: (response) {
              final items = response.data;

              if (items.isEmpty) {
                return const Center(
                  child: Text(
                    'Belum ada notifikasi.',
                    style: TextStyle(color: AppColors.gray),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: _refresh,
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    if (response.meta != null)
                      Text(
                        '${response.meta!.unreadCount} belum dibaca',
                        style: const TextStyle(
                          color: AppColors.gray,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    const SpaceHeight(16),
                    ...items.map((item) => _notificationItem(item)),
                  ],
                ),
              );
            },
            error: (message) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.red),
                ),
              ),
            ),
            orElse: () => const SizedBox(),
          );
        },
      ),
    );
  }

  Widget _notificationItem(TenantNotificationModel item) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        if (item.id != null && !item.isRead) {
          _markRead(item.id!);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: item.isRead ? AppColors.stroke : AppColors.primary,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primary.withOpacity(0.12),
              child: Icon(_iconByType(item.type), color: AppColors.primary),
            ),
            const SpaceWidth(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                      if (!item.isRead)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SpaceHeight(6),
                  Text(
                    item.message,
                    style: const TextStyle(color: AppColors.gray, fontSize: 13),
                  ),
                  const SpaceHeight(8),
                  Text(
                    item.createdAt ?? '-',
                    style: const TextStyle(color: AppColors.gray, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconByType(String? type) {
    final value = type?.toLowerCase() ?? '';

    if (value.contains('bill')) return Icons.receipt_long_outlined;
    if (value.contains('payment')) return Icons.payments_outlined;
    if (value.contains('contract')) return Icons.assignment_outlined;

    return Icons.notifications_none_rounded;
  }
}
