import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/data/models/response/tenant/tenant_bill_response_model.dart';
import 'package:sewain/presentasion/bloc/tenant_bill/tenant_bill_bloc.dart';
import 'package:sewain/presentasion/tenant/payment/tenant_payment_simulation_page.dart';

class TenantBillDetailPage extends StatefulWidget {
  final int id;

  const TenantBillDetailPage({super.key, required this.id});

  @override
  State<TenantBillDetailPage> createState() => _TenantBillDetailPageState();
}

class _TenantBillDetailPageState extends State<TenantBillDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<TenantBillBloc>().add(TenantBillEvent.getDetail(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(title: const Text('Detail Tagihan')),
      body: BlocBuilder<TenantBillBloc, TenantBillState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            detailLoaded: (bill) {
              if (bill == null) {
                return const Center(child: Text('Tagihan tidak ditemukan.'));
              }

              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _headerCard(bill),
                  const SpaceHeight(16),
                  _breakdownCard(bill),
                  const SpaceHeight(16),
                  _infoCard(bill),
                  if (!bill.isPaid) ...[
                    const SpaceHeight(24),
                    Button.filled(
                      onPressed: () {
                        context.push(TenantPaymentSimulationPage(bill: bill));
                      },
                      label: 'Bayar Sekarang',
                    ),
                  ],
                ],
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

  Widget _headerCard(TenantBillModel bill) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Tagihan',
            style: TextStyle(color: AppColors.white, fontSize: 14),
          ),
          const SpaceHeight(10),
          Text(
            bill.totalAmountRp,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SpaceHeight(10),
          Text(
            'Periode ${bill.period ?? '-'}',
            style: const TextStyle(color: AppColors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _breakdownCard(TenantBillModel bill) {
    return _card(
      title: 'Rincian Tagihan',
      children: [
        _row('Sewa Kamar', bill.rentAmountRp),
        _row('Listrik', bill.electricityAmountRp),
        _row('Air', bill.waterAmountRp),
        _row(
          bill.otherDescription?.isNotEmpty == true
              ? bill.otherDescription!
              : 'Biaya Lainnya',
          bill.otherAmountRp,
        ),
        const Divider(height: 28),
        _row('Total', bill.totalAmountRp, isBold: true),
      ],
    );
  }

  Widget _infoCard(TenantBillModel bill) {
    return _card(
      title: 'Informasi',
      children: [
        _row('Status', bill.statusLabel),
        _row('Jatuh Tempo', bill.dueDate ?? '-'),
        _row('Dibayar Pada', bill.paidAt ?? '-'),
        _row('Terlambat', bill.isOverdue ? 'Ya' : 'Tidak'),
        _row('Catatan', bill.notes ?? '-'),
      ],
    );
  }

  Widget _card({required String title, required List<Widget> children}) {
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
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
          const SpaceHeight(16),
          ...children,
        ],
      ),
    );
  }

  Widget _row(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: isBold ? AppColors.black : AppColors.gray,
                fontWeight: isBold ? FontWeight.w800 : FontWeight.w400,
              ),
            ),
          ),
          const SpaceWidth(12),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.w900 : FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
