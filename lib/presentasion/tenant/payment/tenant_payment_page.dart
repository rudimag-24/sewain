import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/data/models/response/tenant/tenant_payment_response_model.dart';
import 'package:sewain/presentasion/bloc/tenant_payment/tenant_payment_bloc.dart';
import 'package:sewain/presentasion/tenant/payment/tenant_payment_receipt_page.dart';

class TenantPaymentPage extends StatefulWidget {
  const TenantPaymentPage({super.key});

  @override
  State<TenantPaymentPage> createState() => _TenantPaymentPageState();
}

class _TenantPaymentPageState extends State<TenantPaymentPage> {
  @override
  void initState() {
    super.initState();
    _getPayments();
  }

  void _getPayments() {
    context.read<TenantPaymentBloc>().add(const TenantPaymentEvent.getList());
  }

  Future<void> _refresh() async {
    _getPayments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      body: SafeArea(
        child: BlocBuilder<TenantPaymentBloc, TenantPaymentState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(child: CircularProgressIndicator()),
              listLoaded: (items) {
                if (items.isEmpty) {
                  return _emptyState();
                }

                return RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      const Text(
                        'Pembayaran',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SpaceHeight(6),
                      const Text(
                        'Riwayat pembayaran tagihan kos',
                        style: TextStyle(color: AppColors.gray),
                      ),
                      const SpaceHeight(20),
                      ...items.map((item) => _paymentCard(item)),
                    ],
                  ),
                );
              },
              error: (message) => Center(
                child: Text(
                  message,
                  style: const TextStyle(color: AppColors.red),
                  textAlign: TextAlign.center,
                ),
              ),
              orElse: () => const SizedBox(),
            );
          },
        ),
      ),
    );
  }

  Widget _paymentCard(TenantPaymentModel item) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        if (item.id != null) {
          context.push(TenantPaymentReceiptPage(paymentId: item.id!));
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
                    'Periode ${item.billPeriod ?? '-'}',
                    style: const TextStyle(color: AppColors.gray, fontSize: 12),
                  ),
                  const SpaceHeight(4),
                  Text(
                    item.paidAt ?? item.createdAt ?? '-',
                    style: const TextStyle(color: AppColors.gray, fontSize: 11),
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
          SpaceHeight(140),
          Icon(Icons.payments_outlined, size: 80, color: AppColors.gray),
          SpaceHeight(16),
          Text(
            'Belum Ada Pembayaran',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          SpaceHeight(8),
          Text(
            'Riwayat pembayaran akan tampil di sini.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.gray),
          ),
        ],
      ),
    );
  }
}
