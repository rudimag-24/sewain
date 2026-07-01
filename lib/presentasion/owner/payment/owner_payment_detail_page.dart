import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/data/models/response/owner/owner_payment_response_model.dart';
import 'package:sewain/presentasion/bloc/owner_payment/owner_payment_bloc.dart';

class OwnerPaymentDetailPage extends StatefulWidget {
  final int id;

  const OwnerPaymentDetailPage({super.key, required this.id});

  @override
  State<OwnerPaymentDetailPage> createState() => _OwnerPaymentDetailPageState();
}

class _OwnerPaymentDetailPageState extends State<OwnerPaymentDetailPage> {
  @override
  void initState() {
    super.initState();
    _getDetail();
  }

  void _getDetail() {
    context.read<OwnerPaymentBloc>().add(
      OwnerPaymentEvent.getDetail(widget.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(title: const Text('Detail Pembayaran')),
      body: BlocBuilder<OwnerPaymentBloc, OwnerPaymentState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            detailLoaded: (payment) {
              if (payment == null) {
                return const Center(child: Text('Pembayaran tidak ditemukan.'));
              }

              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _headerCard(payment),
                  const SpaceHeight(16),
                  _paymentInfoCard(payment),
                  const SpaceHeight(16),
                  _tenantInfoCard(payment),
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

  Widget _headerCard(OwnerPaymentModel payment) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Icon(
            payment.isPaid
                ? Icons.check_circle_rounded
                : Icons.payments_outlined,
            color: AppColors.white,
            size: 64,
          ),
          const SpaceHeight(14),
          Text(
            payment.statusLabel,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SpaceHeight(8),
          Text(
            payment.amountRp,
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

  Widget _paymentInfoCard(OwnerPaymentModel payment) {
    return _card(
      title: 'Informasi Pembayaran',
      children: [
        _row('Kode Pembayaran', payment.paymentCode ?? '-'),
        _row('Metode', payment.methodLabel),
        _row('Status', payment.statusLabel),
        _row('Dibayar Pada', payment.paidAt ?? '-'),
        _row('Dibuat Pada', payment.createdAt ?? '-'),
        _row('Bill ID', payment.bill?.id?.toString() ?? '-'),
        _row('Periode Bill', payment.bill?.period ?? '-'),
      ],
    );
  }

  Widget _tenantInfoCard(OwnerPaymentModel payment) {
    return _card(
      title: 'Tenant & Properti',
      children: [
        _row('Tenant', payment.tenantName ?? '-'),
        _row('Properti', payment.propertyName ?? '-'),
        _row('Kamar', payment.roomCode ?? '-'),
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
}
