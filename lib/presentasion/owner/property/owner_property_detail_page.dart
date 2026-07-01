import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/data/models/response/owner/owner_property_response_model.dart';
import 'package:sewain/presentasion/bloc/owner_property/owner_property_bloc.dart';
import 'package:sewain/presentasion/owner/property/owner_property_form_page.dart';
import 'package:sewain/presentasion/owner/room/owner_room_page.dart';

class OwnerPropertyDetailPage extends StatefulWidget {
  final int id;

  const OwnerPropertyDetailPage({super.key, required this.id});

  @override
  State<OwnerPropertyDetailPage> createState() =>
      _OwnerPropertyDetailPageState();
}

class _OwnerPropertyDetailPageState extends State<OwnerPropertyDetailPage> {
  @override
  void initState() {
    super.initState();
    _getDetail();
  }

  void _getDetail() {
    context.read<OwnerPropertyBloc>().add(
      OwnerPropertyEvent.getDetail(widget.id),
    );
  }

  void _delete() {
    context.read<OwnerPropertyBloc>().add(OwnerPropertyEvent.delete(widget.id));
  }

  void _toggleStatus() {
    context.read<OwnerPropertyBloc>().add(
      OwnerPropertyEvent.toggleStatus(widget.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(
        title: const Text('Detail Properti'),
        actions: [
          IconButton(
            onPressed: _showDeleteConfirm,
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: BlocConsumer<OwnerPropertyBloc, OwnerPropertyState>(
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
            detailLoaded: (item) {
              if (item == null) {
                return const Center(child: Text('Properti tidak ditemukan.'));
              }

              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _headerCard(item),
                  const SpaceHeight(16),
                  _statsCard(item),
                  Button.filled(
                    onPressed: () {
                      context.push(
                        OwnerRoomPage(
                          propertyId: item.id!,
                          propertyName: item.name ?? 'Properti',
                        ),
                      );
                    },
                    label: 'Kelola Kamar',
                    icon: const Icon(
                      Icons.meeting_room_outlined,
                      color: AppColors.white,
                    ),
                  ),
                  const SpaceHeight(16),
                  _infoCard(item),
                  const SpaceHeight(24),
                  Button.filled(
                    onPressed: () async {
                      final result = await context.push(
                        OwnerPropertyFormPage(initial: item),
                      );

                      if (result == true && mounted) _getDetail();
                    },
                    label: 'Edit Properti',
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

  Widget _headerCard(OwnerPropertyModel item) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.typeLabel, style: const TextStyle(color: AppColors.white)),
          const SpaceHeight(8),
          Text(
            item.name ?? '-',
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SpaceHeight(8),
          Text(
            '${item.city ?? '-'}, ${item.province ?? '-'}',
            style: const TextStyle(color: AppColors.white),
          ),
          const SpaceHeight(16),
          Row(
            children: [
              const Text(
                'Status aktif',
                style: TextStyle(color: AppColors.white),
              ),
              const Spacer(),
              Switch(
                value: item.isActive,
                activeThumbColor: AppColors.white,
                onChanged: (_) => _toggleStatus(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statsCard(OwnerPropertyModel item) {
    return Row(
      children: [
        Expanded(child: _stat('Total Kamar', '${item.roomsCount}')),
        const SpaceWidth(12),
        Expanded(child: _stat('Terisi', '${item.occupiedRoomsCount}')),
        const SpaceWidth(12),
        Expanded(child: _stat('Kosong', '${item.availableRoomsCount}')),
      ],
    );
  }

  Widget _stat(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
          ),
          const SpaceHeight(4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.gray, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _infoCard(OwnerPropertyModel item) {
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
            'Informasi Properti',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
          const SpaceHeight(16),
          _row('Alamat', item.address ?? '-'),
          _row('Kota', item.city ?? '-'),
          _row('Provinsi', item.province ?? '-'),
          _row('Deskripsi', item.description ?? '-'),
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
                'Hapus Properti?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              const SpaceHeight(8),
              const Text(
                'Properti tidak bisa dihapus jika masih ada kamar yang terisi.',
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
