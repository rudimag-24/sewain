import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/data/models/response/owner/owner_contract_response_model.dart';
import 'package:sewain/presentasion/bloc/owner_contract/owner_contract_bloc.dart';
import 'package:sewain/presentasion/owner/contract/owner_contract_form_page.dart';

class OwnerContractDetailPage extends StatefulWidget {
  final int id;

  const OwnerContractDetailPage({super.key, required this.id});

  @override
  State<OwnerContractDetailPage> createState() =>
      _OwnerContractDetailPageState();
}

class _OwnerContractDetailPageState extends State<OwnerContractDetailPage> {
  @override
  void initState() {
    super.initState();
    _getDetail();
  }

  void _getDetail() {
    context.read<OwnerContractBloc>().add(
      OwnerContractEvent.getDetail(widget.id),
    );
  }

  void _endContract() {
    context.read<OwnerContractBloc>().add(
      OwnerContractEvent.endContract(widget.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(title: const Text('Detail Kontrak')),
      body: BlocConsumer<OwnerContractBloc, OwnerContractState>(
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
            detailLoaded: (item) {
              if (item == null) {
                return const Center(child: Text('Kontrak tidak ditemukan.'));
              }

              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _headerCard(item),
                  const SpaceHeight(16),
                  _tenantCard(item),
                  const SpaceHeight(16),
                  _contractInfoCard(item),
                  const SpaceHeight(16),
                  _billHistoryCard(item),
                  if (item.isActive) ...[
                    const SpaceHeight(24),
                    Button.filled(
                      onPressed: () async {
                        final result = await context.push(
                          OwnerContractFormPage(initial: item),
                        );
                        if (result == true && mounted) _getDetail();
                      },
                      label: 'Edit Kontrak',
                      icon: const Icon(Icons.edit, color: AppColors.white),
                    ),
                    const SpaceHeight(12),
                    Button.outlined(
                      onPressed: _showEndContractConfirm,
                      label: 'Akhiri Kontrak',
                      icon: const Icon(Icons.logout_rounded),
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

  Widget _headerCard(OwnerContractModel item) {
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
            item.statusLabel,
            style: const TextStyle(color: AppColors.white),
          ),
          const SpaceHeight(8),
          Text(
            item.propertyName ?? '-',
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SpaceHeight(6),
          Text(
            'Kamar ${item.roomCode ?? '-'}',
            style: const TextStyle(color: AppColors.white),
          ),
          const SpaceHeight(16),
          Text(
            item.monthlyPriceRp,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 26,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tenantCard(OwnerContractModel item) {
    final tenant = item.tenant;

    return _card(
      title: 'Tenant',
      children: [
        _row('Nama', tenant?.name ?? '-'),
        _row('Email', tenant?.email ?? '-'),
        _row('Phone', tenant?.phone ?? '-'),
      ],
    );
  }

  Widget _contractInfoCard(OwnerContractModel item) {
    return _card(
      title: 'Informasi Kontrak',
      children: [
        _row('Mulai', item.startDate ?? '-'),
        _row('Selesai', item.endDate ?? '-'),
        _row('Sisa Kontrak', '${item.remainingMonths ?? 0} bulan'),
        _row('Harga Bulanan', item.monthlyPriceRp),
        _row('Deposit', item.depositRp),
        _row('Status', item.statusLabel),
        _row('Catatan', item.notes ?? '-'),
      ],
    );
  }

  Widget _billHistoryCard(OwnerContractModel item) {
    if (item.bills.isEmpty) {
      return _card(
        title: 'Tagihan Terakhir',
        children: [_row('Data', 'Belum ada tagihan')],
      );
    }

    return _card(
      title: 'Tagihan Terakhir',
      children: item.bills
          .map(
            (bill) => _row(
              bill.period ?? '-',
              '${bill.totalAmountRp} • ${bill.status ?? '-'}',
            ),
          )
          .toList(),
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

  void _showEndContractConfirm() {
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
                'Akhiri Kontrak?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              const SpaceHeight(8),
              const Text(
                'Kamar akan berubah menjadi tersedia kembali.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.gray),
              ),
              const SpaceHeight(20),
              Button.filled(
                onPressed: () {
                  context.pop();
                  _endContract();
                },
                label: 'Akhiri Kontrak',
                color: AppColors.red,
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
