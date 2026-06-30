import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/data/models/response/tenant/tenant_payment_response_model.dart';
import 'package:sewain/presentasion/bloc/tenant_payment/tenant_payment_bloc.dart';

class TenantPaymentReceiptPage extends StatefulWidget {
  final int paymentId;

  const TenantPaymentReceiptPage({super.key, required this.paymentId});

  @override
  State<TenantPaymentReceiptPage> createState() =>
      _TenantPaymentReceiptPageState();
}

class _TenantPaymentReceiptPageState extends State<TenantPaymentReceiptPage> {
  @override
  void initState() {
    super.initState();
    context.read<TenantPaymentBloc>().add(
      TenantPaymentEvent.getReceipt(widget.paymentId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(title: const Text('Struk Pembayaran')),
      body: BlocBuilder<TenantPaymentBloc, TenantPaymentState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            receiptLoaded: (receipt) {
              if (receipt == null) {
                return const Center(child: Text('Struk tidak ditemukan.'));
              }

              final breakdown = receipt.bill?.breakdown;

              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _successHeader(receipt),
                  const SpaceHeight(16),
                  _card(
                    title: 'Informasi Pembayaran',
                    children: [
                      _row('Kode', receipt.paymentCode ?? '-'),
                      _row('Tenant', receipt.tenant ?? '-'),
                      _row('Properti', receipt.property ?? '-'),
                      _row('Unit', receipt.unit ?? '-'),
                      _row('Metode', receipt.method ?? '-'),
                      _row('Status', receipt.status ?? '-'),
                      _row('Dibayar Pada', receipt.paidAt ?? '-'),
                    ],
                  ),
                  const SpaceHeight(16),
                  _card(
                    title: 'Rincian Tagihan',
                    children: [
                      _row('Periode', receipt.bill?.period ?? '-'),
                      _row('Jatuh Tempo', receipt.bill?.dueDate ?? '-'),
                      const Divider(height: 28),
                      _row('Sewa', breakdown?.rentRp ?? 'Rp. 0'),
                      _row('Listrik', breakdown?.electricityRp ?? 'Rp. 0'),
                      _row('Air', breakdown?.waterRp ?? 'Rp. 0'),
                      _row('Lainnya', breakdown?.otherRp ?? 'Rp. 0'),
                      const Divider(height: 28),
                      _row(
                        'Total',
                        breakdown?.totalRp ?? receipt.amountRp,
                        isBold: true,
                      ),
                    ],
                  ),
                  const SpaceHeight(24),
                  Button.filled(
                    onPressed: () {
                      context.popToRoot();
                    },
                    label: 'Kembali',
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

  Widget _successHeader(TenantPaymentReceiptModel receipt) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.check_circle_rounded,
            color: AppColors.white,
            size: 64,
          ),
          const SpaceHeight(14),
          const Text(
            'Pembayaran Berhasil',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SpaceHeight(8),
          Text(
            receipt.amountRp,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
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
