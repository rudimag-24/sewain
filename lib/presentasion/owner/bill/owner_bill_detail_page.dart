import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/data/models/response/owner/owner_bill_response_model.dart';
import 'package:sewain/presentasion/bloc/owner_bill/owner_bill_bloc.dart';
import 'package:sewain/presentasion/owner/bill/owner_bill_form_page.dart';

class OwnerBillDetailPage extends StatefulWidget {
  final int id;

  const OwnerBillDetailPage({super.key, required this.id});

  @override
  State<OwnerBillDetailPage> createState() => _OwnerBillDetailPageState();
}

class _OwnerBillDetailPageState extends State<OwnerBillDetailPage> {
  @override
  void initState() {
    super.initState();
    _getDetail();
  }

  void _getDetail() {
    context.read<OwnerBillBloc>().add(OwnerBillEvent.getDetail(widget.id));
  }

  void _markPaid() {
    context.read<OwnerBillBloc>().add(OwnerBillEvent.markPaid(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(title: const Text('Detail Tagihan')),
      body: BlocConsumer<OwnerBillBloc, OwnerBillState>(
        listener: (context, state) {
          state.maybeWhen(
            success: (message) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
              _getDetail();
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
            detailLoaded: (bill) {
              if (bill == null) {
                return const Center(child: Text('Tagihan tidak ditemukan.'));
              }

              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _headerCard(bill),
                  const SpaceHeight(16),
                  _tenantCard(bill),
                  const SpaceHeight(16),
                  _breakdownCard(bill),
                  const SpaceHeight(16),
                  _infoCard(bill),
                  if (!bill.isPaid) ...[
                    const SpaceHeight(24),
                    Button.filled(
                      onPressed: _showMarkPaidConfirm,
                      label: 'Tandai Lunas Manual',
                      icon: const Icon(
                        Icons.check_circle,
                        color: AppColors.white,
                      ),
                    ),
                    const SpaceHeight(12),
                    Button.outlined(
                      onPressed: () async {
                        final result = await context.push(
                          OwnerBillFormPage(initial: bill),
                        );
                        if (result == true && mounted) _getDetail();
                      },
                      label: 'Edit Tagihan',
                      icon: const Icon(Icons.edit),
                    ),
                  ],
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

  Widget _headerCard(OwnerBillModel bill) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Periode ${bill.period ?? '-'}',
            style: const TextStyle(color: AppColors.white),
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
            bill.statusLabel,
            style: const TextStyle(color: AppColors.white),
          ),
        ],
      ),
    );
  }

  Widget _tenantCard(OwnerBillModel bill) {
    return _card(
      title: 'Tenant & Properti',
      children: [
        _row('Tenant', bill.tenantName ?? '-'),
        _row('Properti', bill.propertyName ?? '-'),
        _row('Kamar', bill.roomCode ?? '-'),
      ],
    );
  }

  Widget _breakdownCard(OwnerBillModel bill) {
    return _card(
      title: 'Rincian Tagihan',
      children: [
        _row('Sewa', bill.rentAmountRp),
        _row('Listrik', bill.electricityAmountRp),
        _row('Air', bill.waterAmountRp),
        _row(
          bill.otherDescription?.isNotEmpty == true
              ? bill.otherDescription!
              : 'Lainnya',
          bill.otherAmountRp,
        ),
        const Divider(height: 28),
        _row('Total', bill.totalAmountRp, isBold: true),
      ],
    );
  }

  Widget _infoCard(OwnerBillModel bill) {
    return _card(
      title: 'Informasi',
      children: [
        _row('Jatuh Tempo', bill.dueDate ?? '-'),
        _row('Status', bill.statusLabel),
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

  Widget _row(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
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

  void _showMarkPaidConfirm() {
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
                'Tandai Lunas?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              const SpaceHeight(8),
              const Text(
                'Tagihan akan ditandai lunas secara manual.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.gray),
              ),
              const SpaceHeight(20),
              Button.filled(
                onPressed: () {
                  context.pop();
                  _markPaid();
                },
                label: 'Tandai Lunas',
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
