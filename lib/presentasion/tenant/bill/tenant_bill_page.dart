import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/data/models/response/tenant/tenant_bill_response_model.dart';
import 'package:sewain/presentasion/bloc/tenant_bill/tenant_bill_bloc.dart';
import 'package:sewain/presentasion/tenant/bill/tenant_bill_detail_page.dart';

class TenantBillPage extends StatefulWidget {
  const TenantBillPage({super.key});

  @override
  State<TenantBillPage> createState() => _TenantBillPageState();
}

class _TenantBillPageState extends State<TenantBillPage> {
  String? selectedStatus;

  final filters = const [
    {'label': 'Semua', 'value': null},
    {'label': 'Belum Bayar', 'value': 'unpaid'},
    {'label': 'Pending', 'value': 'pending'},
    {'label': 'Lunas', 'value': 'paid'},
  ];

  @override
  void initState() {
    super.initState();
    _getBills();
  }

  void _getBills() {
    context.read<TenantBillBloc>().add(
      TenantBillEvent.getList(status: selectedStatus),
    );
  }

  Future<void> _refresh() async {
    _getBills();
  }

  void _changeFilter(String? status) {
    setState(() {
      selectedStatus = status;
    });
    _getBills();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      body: SafeArea(
        child: BlocBuilder<TenantBillBloc, TenantBillState>(
          builder: (context, state) {
            return Column(
              children: [
                _header(),
                _filterSection(),
                Expanded(
                  child: state.maybeWhen(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    listLoaded: (items, message, status) {
                      if (items.isEmpty) {
                        return _emptyState(message ?? 'Belum ada tagihan.');
                      }

                      return RefreshIndicator(
                        onRefresh: _refresh,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(20),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final bill = items[index];
                            return _billCard(bill);
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
                  ),
                ),
              ],
            );
          },
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
              'Tagihan',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterSection() {
    return SizedBox(
      height: 48,
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

  Widget _billCard(TenantBillModel bill) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        if (bill.id != null) {
          context.push(TenantBillDetailPage(id: bill.id!));
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: bill.isOverdue ? AppColors.red : AppColors.stroke,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: bill.statusColor.withOpacity(0.12),
                  child: Icon(
                    bill.isPaid
                        ? Icons.check_rounded
                        : Icons.receipt_long_outlined,
                    color: bill.statusColor,
                  ),
                ),
                const SpaceWidth(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tagihan ${bill.period ?? '-'}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                      const SpaceHeight(4),
                      Text(
                        'Jatuh tempo: ${bill.dueDate ?? '-'}',
                        style: const TextStyle(
                          color: AppColors.gray,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                _statusBadge(bill),
              ],
            ),
            const SpaceHeight(16),
            Text(
              bill.totalAmountRp,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: AppColors.primary,
              ),
            ),
            if (!bill.isPaid) ...[
              const SpaceHeight(14),
              Button.filled(
                onPressed: () {
                  // nanti diarahkan ke TenantPaymentSimulatePage
                },
                label: 'Bayar Sekarang',
                height: 46,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _statusBadge(TenantBillModel bill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bill.statusColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        bill.statusLabel,
        style: TextStyle(
          color: bill.statusColor,
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _emptyState(String message) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SpaceHeight(120),
          const Icon(
            Icons.receipt_long_outlined,
            size: 80,
            color: AppColors.gray,
          ),
          const SpaceHeight(16),
          const Text(
            'Belum Ada Tagihan',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SpaceHeight(8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.gray),
          ),
        ],
      ),
    );
  }
}
