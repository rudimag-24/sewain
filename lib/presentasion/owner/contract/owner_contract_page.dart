import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/data/models/response/owner/owner_contract_response_model.dart';
import 'package:sewain/presentasion/bloc/owner_contract/owner_contract_bloc.dart';
import 'package:sewain/presentasion/owner/contract/owner_contract_detail_page.dart';
import 'package:sewain/presentasion/owner/contract/owner_contract_form_page.dart';

class OwnerContractPage extends StatefulWidget {
  const OwnerContractPage({super.key});

  @override
  State<OwnerContractPage> createState() => _OwnerContractPageState();
}

class _OwnerContractPageState extends State<OwnerContractPage> {
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    _getContracts();
  }

  void _getContracts() {
    context.read<OwnerContractBloc>().add(
      OwnerContractEvent.getList(status: selectedStatus),
    );
  }

  Future<void> _refresh() async => _getContracts();

  void _changeStatus(String? status) {
    setState(() => selectedStatus = status);
    _getContracts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () async {
          final result = await context.push(const OwnerContractFormPage());
          if (result == true && mounted) _getContracts();
        },
        child: const Icon(Icons.add, color: AppColors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            _filter(),
            Expanded(
              child: BlocConsumer<OwnerContractBloc, OwnerContractState>(
                listener: (context, state) {
                  state.maybeWhen(
                    success: (message) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(message)));
                      _getContracts();
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
                            return _contractCard(items[index]);
                          },
                        ),
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
              'Kontrak',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filter() {
    final filters = [
      {'label': 'Semua', 'value': null},
      {'label': 'Aktif', 'value': 'active'},
      {'label': 'Berakhir', 'value': 'expired'},
      {'label': 'Diakhiri', 'value': 'terminated'},
    ];

    return SizedBox(
      height: 46,
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
            onTap: () => _changeStatus(value),
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

  Widget _contractCard(OwnerContractModel item) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () async {
        if (item.id != null) {
          final result = await context.push(
            OwnerContractDetailPage(id: item.id!),
          );
          if (result == true && mounted) _getContracts();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: item.statusColor.withOpacity(0.12),
                  child: Icon(
                    Icons.assignment_outlined,
                    color: item.statusColor,
                  ),
                ),
                const SpaceWidth(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.tenant?.name ?? '-',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SpaceHeight(4),
                      Text(
                        '${item.propertyName ?? '-'} • Kamar ${item.roomCode ?? '-'}',
                        style: const TextStyle(
                          color: AppColors.gray,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                _statusBadge(item),
              ],
            ),
            const SpaceHeight(16),
            Row(
              children: [
                Expanded(child: _miniInfo('Mulai', item.startDate ?? '-')),
                Expanded(child: _miniInfo('Selesai', item.endDate ?? '-')),
                Expanded(
                  child: _miniInfo('Sisa', '${item.remainingMonths ?? 0} bln'),
                ),
              ],
            ),
            const SpaceHeight(14),
            Text(
              item.monthlyPriceRp,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _miniInfo(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xffF8FAFC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
          ),
          const SpaceHeight(4),
          Text(
            title,
            style: const TextStyle(color: AppColors.gray, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _statusBadge(OwnerContractModel item) {
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
          Icon(Icons.assignment_outlined, size: 80, color: AppColors.gray),
          SpaceHeight(16),
          Text(
            'Belum Ada Kontrak',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          SpaceHeight(8),
          Text(
            'Buat kontrak pertama untuk tenant kamu.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.gray),
          ),
        ],
      ),
    );
  }
}
