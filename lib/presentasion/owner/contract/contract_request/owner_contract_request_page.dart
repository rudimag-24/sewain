import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/data/models/response/owner/owner_contract_request_response_model.dart';
import 'package:sewain/presentasion/bloc/owner_contract_request/owner_contract_request_bloc.dart';
import 'package:sewain/presentasion/owner/contract/contract_request/owner_contract_request_detail_page.dart';

class OwnerContractRequestPage extends StatefulWidget {
  const OwnerContractRequestPage({super.key});

  @override
  State<OwnerContractRequestPage> createState() =>
      _OwnerContractRequestPageState();
}

class _OwnerContractRequestPageState extends State<OwnerContractRequestPage> {
  String? selectedStatus;
  String? selectedType;

  @override
  void initState() {
    super.initState();
    _getList();
  }

  void _getList() {
    context.read<OwnerContractRequestBloc>().add(
      OwnerContractRequestEvent.getList(
        status: selectedStatus,
        type: selectedType,
      ),
    );
  }

  Future<void> _refresh() async => _getList();

  void _changeStatus(String? status) {
    setState(() => selectedStatus = status);
    _getList();
  }

  void _changeType(String? type) {
    setState(() => selectedType = type);
    _getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            _statusFilter(),
            const SpaceHeight(8),
            _typeFilter(),
            Expanded(
              child:
                  BlocConsumer<
                    OwnerContractRequestBloc,
                    OwnerContractRequestState
                  >(
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
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        listLoaded: (items) {
                          if (items.isEmpty) return _emptyState();

                          return RefreshIndicator(
                            onRefresh: _refresh,
                            child: ListView.builder(
                              padding: const EdgeInsets.all(20),
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                return _requestCard(items[index]);
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
      ),
    );
  }

  Widget _header() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Pengajuan Tenant',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusFilter() {
    final filters = [
      {'label': 'Semua', 'value': null},
      {'label': 'Pending', 'value': 'pending'},
      {'label': 'Disetujui', 'value': 'approved'},
      {'label': 'Ditolak', 'value': 'rejected'},
    ];

    return _chipFilter(
      filters: filters,
      selectedValue: selectedStatus,
      onSelected: _changeStatus,
    );
  }

  Widget _typeFilter() {
    final filters = [
      {'label': 'Semua Tipe', 'value': null},
      {'label': 'Perpanjangan', 'value': 'extend'},
      {'label': 'Stop Kos', 'value': 'stop'},
    ];

    return _chipFilter(
      filters: filters,
      selectedValue: selectedType,
      onSelected: _changeType,
    );
  }

  Widget _chipFilter({
    required List<Map<String, String?>> filters,
    required String? selectedValue,
    required Function(String?) onSelected,
  }) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SpaceWidth(8),
        itemBuilder: (context, index) {
          final item = filters[index];
          final label = item['label'] ?? '-';
          final value = item['value'];
          final selected = selectedValue == value;

          return InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () => onSelected(value),
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

  Widget _requestCard(OwnerContractRequestModel item) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () async {
        if (item.id != null) {
          final result = await context.push(
            OwnerContractRequestDetailPage(id: item.id!),
          );
          if (result == true && mounted) _getList();
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
              backgroundColor: item.statusColor.withOpacity(0.12),
              child: Icon(item.typeIcon, color: item.statusColor),
            ),
            const SpaceWidth(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.typeLabel,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SpaceHeight(4),
                  Text(
                    item.tenantName ?? '-',
                    style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SpaceHeight(4),
                  Text(
                    '${item.propertyName ?? '-'} • Kamar ${item.roomCode ?? '-'}',
                    style: const TextStyle(color: AppColors.gray, fontSize: 12),
                  ),
                ],
              ),
            ),
            _statusBadge(item),
          ],
        ),
      ),
    );
  }

  Widget _statusBadge(OwnerContractRequestModel item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: item.statusColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        item.statusLabel,
        style: TextStyle(
          color: item.statusColor,
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
          Icon(Icons.pending_actions_outlined, size: 80, color: AppColors.gray),
          SpaceHeight(16),
          Text(
            'Belum Ada Pengajuan',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          SpaceHeight(8),
          Text(
            'Pengajuan tenant akan tampil di sini.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.gray),
          ),
        ],
      ),
    );
  }
}
