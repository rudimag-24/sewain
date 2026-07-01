import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/data/models/response/owner/owner_room_response_model.dart';
import 'package:sewain/presentasion/bloc/owner_room/owner_room_bloc.dart';
import 'package:sewain/presentasion/owner/room/owner_room_detail_page.dart';
import 'package:sewain/presentasion/owner/room/owner_room_form_page.dart';

class OwnerRoomPage extends StatefulWidget {
  final int propertyId;
  final String propertyName;

  const OwnerRoomPage({
    super.key,
    required this.propertyId,
    required this.propertyName,
  });

  @override
  State<OwnerRoomPage> createState() => _OwnerRoomPageState();
}

class _OwnerRoomPageState extends State<OwnerRoomPage> {
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    _getRooms();
  }

  void _getRooms() {
    context.read<OwnerRoomBloc>().add(
      OwnerRoomEvent.getList(
        propertyId: widget.propertyId,
        status: selectedStatus,
      ),
    );
  }

  Future<void> _refresh() async => _getRooms();

  void _changeFilter(String? status) {
    setState(() => selectedStatus = status);
    _getRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(title: Text(widget.propertyName)),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () async {
          final result = await context.push(
            OwnerRoomFormPage(propertyId: widget.propertyId),
          );
          if (result == true && mounted) _getRooms();
        },
        child: const Icon(Icons.add, color: AppColors.white),
      ),
      body: Column(
        children: [
          _filterSection(),
          Expanded(
            child: BlocConsumer<OwnerRoomBloc, OwnerRoomState>(
              listener: (context, state) {
                state.maybeWhen(
                  success: (message) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(message)));
                    _getRooms();
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
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  listLoaded: (items) {
                    if (items.isEmpty) {
                      return _emptyState();
                    }

                    return RefreshIndicator(
                      onRefresh: _refresh,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(20),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return _roomCard(items[index]);
                        },
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
          ),
        ],
      ),
    );
  }

  Widget _filterSection() {
    final filters = [
      {'label': 'Semua', 'value': null},
      {'label': 'Kosong', 'value': 'available'},
      {'label': 'Terisi', 'value': 'occupied'},
      {'label': 'Maintenance', 'value': 'maintenance'},
    ];

    return Container(
      height: 58,
      padding: const EdgeInsets.only(top: 10),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SpaceWidth(8),
        itemBuilder: (context, index) {
          final item = filters[index];
          final label = item['label'] as String;
          final value = item['value'] as String?;
          final selected = selectedStatus == value;

          return InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () => _changeFilter(value),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : AppColors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: selected ? AppColors.primary : AppColors.stroke,
                ),
              ),
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                    color: selected ? AppColors.white : AppColors.gray,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _roomCard(OwnerRoomModel room) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () async {
        if (room.id != null) {
          final result = await context.push(
            OwnerRoomDetailPage(
              propertyId: widget.propertyId,
              roomId: room.id!,
            ),
          );

          if (result == true && mounted) _getRooms();
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.stroke),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: room.statusColor.withOpacity(0.12),
              child: Icon(Icons.meeting_room_outlined, color: room.statusColor),
            ),
            const SpaceWidth(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kamar ${room.code ?? '-'}',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SpaceHeight(4),
                  Text(
                    room.priceRp,
                    style: const TextStyle(color: AppColors.gray, fontSize: 12),
                  ),
                  if (room.tenant != null) ...[
                    const SpaceHeight(4),
                    Text(
                      room.tenant?.name ?? '-',
                      style: const TextStyle(
                        color: AppColors.gray,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            _statusBadge(room),
          ],
        ),
      ),
    );
  }

  Widget _statusBadge(OwnerRoomModel room) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: room.statusColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        room.statusLabel,
        style: TextStyle(
          color: room.statusColor,
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _emptyState() {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: const [
          SpaceHeight(120),
          Icon(Icons.meeting_room_outlined, size: 80, color: AppColors.gray),
          SpaceHeight(16),
          Text(
            'Belum Ada Kamar',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          SpaceHeight(8),
          Text(
            'Tambahkan kamar pertama untuk properti ini.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.gray),
          ),
        ],
      ),
    );
  }
}
