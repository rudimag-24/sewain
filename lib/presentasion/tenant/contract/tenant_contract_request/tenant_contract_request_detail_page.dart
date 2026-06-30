import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/presentasion/bloc/tenant_contract_request/tenant_contract_request_bloc.dart';

class TenantContractRequestDetailPage extends StatefulWidget {
  final int id;

  const TenantContractRequestDetailPage({super.key, required this.id});

  @override
  State<TenantContractRequestDetailPage> createState() =>
      _TenantContractRequestDetailPageState();
}

class _TenantContractRequestDetailPageState
    extends State<TenantContractRequestDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<TenantContractRequestBloc>().add(
      TenantContractRequestEvent.getDetail(widget.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(title: const Text('Detail Pengajuan')),
      body: BlocBuilder<TenantContractRequestBloc, TenantContractRequestState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            detailLoaded: (item) {
              if (item == null) {
                return const Center(child: Text('Data tidak ditemukan.'));
              }

              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _card([
                    _info('Jenis Pengajuan', item.typeLabel),
                    _info('Status', item.statusLabel),
                    _info('Properti', item.propertyName ?? '-'),
                    _info('Kamar', item.roomCode ?? '-'),
                    _info('Perpanjangan', '${item.extendMonths ?? 0} bulan'),
                    _info('Tanggal Akhir Baru', item.requestedEndDate ?? '-'),
                    _info('Tanggal Stop', item.requestedStopDate ?? '-'),
                    _info('Alasan', item.reason ?? '-'),
                    _info('Catatan Tenant', item.tenantNotes ?? '-'),
                    _info('Catatan Owner', item.ownerNotes ?? '-'),
                    _info('Direspon Pada', item.respondedAt ?? '-'),
                    _info('Dibuat Pada', item.createdAt ?? '-'),
                  ]),
                ],
              );
            },
            error: (message) => Center(
              child: Text(
                message,
                style: const TextStyle(color: AppColors.red),
              ),
            ),
            orElse: () => const SizedBox(),
          );
        },
      ),
    );
  }

  Widget _card(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Column(children: children),
    );
  }

  Widget _info(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
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
