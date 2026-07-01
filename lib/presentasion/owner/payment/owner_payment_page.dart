import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/data/models/response/owner/owner_payment_response_model.dart';
import 'package:sewain/presentasion/bloc/owner_payment/owner_payment_bloc.dart';
import 'package:sewain/presentasion/owner/payment/owner_payment_detail_page.dart';

class OwnerPaymentPage extends StatefulWidget {
  const OwnerPaymentPage({super.key});

  @override
  State<OwnerPaymentPage> createState() => _OwnerPaymentPageState();
}

class _OwnerPaymentPageState extends State<OwnerPaymentPage> {
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    _getPayments();
  }

  void _getPayments() {
    context.read<OwnerPaymentBloc>().add(
      OwnerPaymentEvent.getList(status: selectedStatus),
    );
  }

  Future<void> _refresh() async => _getPayments();

  void _changeStatus(String? status) {
    setState(() => selectedStatus = status);
    _getPayments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            _filter(),
            Expanded(
              child: BlocBuilder<OwnerPaymentBloc, OwnerPaymentState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    listLoaded: (items, meta) {
                      if (items.isEmpty) return _emptyState();

                      return RefreshIndicator(
                        onRefresh: _refresh,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(20),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return _paymentCard(items[index]);
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
              'Pembayaran',
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
      {'label': 'Berhasil', 'value': 'paid'},
      {'label': 'Pending', 'value': 'pending'},
      {'label': 'Gagal', 'value': 'failed'},
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

  Widget _paymentCard(OwnerPaymentModel item) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        if (item.id != null) {
          context.push(OwnerPaymentDetailPage(id: item.id!));
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
              child: Icon(
                item.isPaid ? Icons.check_rounded : Icons.payments_outlined,
                color: item.statusColor,
              ),
            ),
            const SpaceWidth(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.amountRp,
                    style: const TextStyle(
                      fontSize: 18,
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
            Text(
              item.statusLabel,
              style: TextStyle(
                color: item.statusColor,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ],
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
          Icon(Icons.payments_outlined, size: 80, color: AppColors.gray),
          SpaceHeight(16),
          Text(
            'Belum Ada Pembayaran',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          SpaceHeight(8),
          Text(
            'Riwayat pembayaran tenant akan tampil di sini.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.gray),
          ),
        ],
      ),
    );
  }
}
