import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/data/models/response/owner/owner_room_response_model.dart';
import 'package:sewain/presentasion/bloc/owner_room/owner_room_bloc.dart';
import 'package:sewain/presentasion/owner/room/owner_room_form_page.dart';

class OwnerRoomDetailPage extends StatefulWidget {
  final int propertyId;
  final int roomId;

  const OwnerRoomDetailPage({
    super.key,
    required this.propertyId,
    required this.roomId,
  });

  @override
  State<OwnerRoomDetailPage> createState() => _OwnerRoomDetailPageState();
}

class _OwnerRoomDetailPageState extends State<OwnerRoomDetailPage> {
  @override
  void initState() {
    super.initState();
    _getDetail();
  }

  void _getDetail() {
    context.read<OwnerRoomBloc>().add(
      OwnerRoomEvent.getDetail(
        propertyId: widget.propertyId,
        roomId: widget.roomId,
      ),
    );
  }

  void _delete() {
    context.read<OwnerRoomBloc>().add(
      OwnerRoomEvent.delete(
        propertyId: widget.propertyId,
        roomId: widget.roomId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(
        title: const Text('Detail Kamar'),
        actions: [
          IconButton(
            onPressed: _showDeleteConfirm,
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: BlocConsumer<OwnerRoomBloc, OwnerRoomState>(
        listener: (context, state) {
          state.maybeWhen(
            success: (message) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));

              if (message.toLowerCase().contains('hapus')) {
                context.pop(true);
              } else {
                _getDetail();
              }
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
            detailLoaded: (room) {
              if (room == null) {
                return const Center(child: Text('Kamar tidak ditemukan.'));
              }

              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _headerCard(room),
                  const SpaceHeight(16),
                  _tenantCard(room.tenant),
                  const SpaceHeight(16),
                  _infoCard(room),
                  const SpaceHeight(24),
                  Button.filled(
                    onPressed: () async {
                      final result = await context.push(
                        OwnerRoomFormPage(
                          propertyId: widget.propertyId,
                          initial: room,
                        ),
                      );

                      if (result == true && mounted) _getDetail();
                    },
                    label: 'Edit Kamar',
                    icon: const Icon(Icons.edit, color: AppColors.white),
                  ),
                ],
              );
            },
            error: (message) => Center(
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.red),
              ),
            ),
            orElse: () => const SizedBox(),
          );
        },
      ),
    );
  }

  Widget _headerCard(OwnerRoomModel room) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kamar ${room.code ?? '-'}',
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 26,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SpaceHeight(8),
          Text(room.priceRp, style: const TextStyle(color: AppColors.white)),
          const SpaceHeight(14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              room.statusLabel,
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tenantCard(OwnerRoomTenantModel? tenant) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.stroke),
      ),
      child: tenant == null
          ? const Text(
              'Kamar belum ditempati tenant.',
              style: TextStyle(color: AppColors.gray),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tenant Aktif',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
                const SpaceHeight(16),
                _row('Nama', tenant.name ?? '-'),
                _row('Email', tenant.email ?? '-'),
                _row('Phone', tenant.phone ?? '-'),
              ],
            ),
    );
  }

  Widget _infoCard(OwnerRoomModel room) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Informasi Kamar',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
          const SpaceHeight(16),
          _row('Kode', room.code ?? '-'),
          _row('Harga per Bulan', room.priceRp),
          _row('Status', room.statusLabel),
          _row('Deskripsi', room.description ?? '-'),
        ],
      ),
    );
  }

  Widget _row(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(title, style: const TextStyle(color: AppColors.gray)),
          ),
          const SpaceWidth(12),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirm() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Hapus Kamar?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              const SpaceHeight(8),
              const Text(
                'Kamar tidak bisa dihapus jika sedang ditempati.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.gray),
              ),
              const SpaceHeight(20),
              Button.filled(
                onPressed: () {
                  context.pop();
                  _delete();
                },
                label: 'Hapus',
                color: AppColors.red,
              ),
              const SpaceHeight(12),
              Button.outlined(onPressed: () => context.pop(), label: 'Batal'),
            ],
          ),
        );
      },
    );
  }
}
