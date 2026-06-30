import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/data/models/response/tenant/tenant_bill_response_model.dart';
import 'package:sewain/presentasion/bloc/tenant_payment/tenant_payment_bloc.dart';
import 'package:sewain/presentasion/tenant/payment/tenant_payment_receipt_page.dart';

class TenantPaymentSimulationPage extends StatelessWidget {
  final TenantBillModel bill;

  const TenantPaymentSimulationPage({super.key, required this.bill});

  void _submit(BuildContext context) {
    if (bill.id == null) return;

    context.read<TenantPaymentBloc>().add(
      TenantPaymentEvent.simulate(bill.id!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(title: const Text('Pembayaran')),
      body: BlocConsumer<TenantPaymentBloc, TenantPaymentState>(
        listener: (context, state) {
          state.maybeWhen(
            paymentSuccess: (message, payment) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));

              if (payment?.id != null) {
                context.pushReplacement(
                  TenantPaymentReceiptPage(paymentId: payment!.id!),
                );
              }
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
          final loading = state.maybeWhen(
            loading: () => true,
            orElse: () => false,
          );

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Pembayaran',
                      style: TextStyle(color: AppColors.white),
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
                    const SpaceHeight(8),
                    Text(
                      'Periode ${bill.period ?? '-'}',
                      style: const TextStyle(color: AppColors.white),
                    ),
                  ],
                ),
              ),
              const SpaceHeight(18),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.stroke),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.payments_outlined, color: AppColors.primary),
                    SpaceWidth(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Simulasi Pembayaran',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                          SpaceHeight(4),
                          Text(
                            'Pembayaran akan langsung dianggap berhasil.',
                            style: TextStyle(
                              color: AppColors.gray,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.check_circle, color: AppColors.primary),
                  ],
                ),
              ),
              const SpaceHeight(24),
              Button.filled(
                onPressed: () => _submit(context),
                disabled: loading,
                label: loading ? 'Memproses...' : 'Bayar Sekarang',
              ),
            ],
          );
        },
      ),
    );
  }
}
