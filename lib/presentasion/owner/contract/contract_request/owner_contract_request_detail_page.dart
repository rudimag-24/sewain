import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/data/models/request/owner/owner_contract_request_request_model.dart';
import 'package:sewain/data/models/response/owner/owner_contract_request_response_model.dart';
import 'package:sewain/presentasion/bloc/owner_contract_request/owner_contract_request_bloc.dart';

class OwnerContractRequestDetailPage extends StatefulWidget {
  final int id;

  const OwnerContractRequestDetailPage({super.key, required this.id});

  @override
  State<OwnerContractRequestDetailPage> createState() =>
      _OwnerContractRequestDetailPageState();
}

class _OwnerContractRequestDetailPageState
    extends State<OwnerContractRequestDetailPage> {
  @override
  void initState() {
    super.initState();
    _getDetail();
  }

  void _getDetail() {
    context.read<OwnerContractRequestBloc>().add(
      OwnerContractRequestEvent.getDetail(widget.id),
    );
  }

  void _approve(String? notes) {
    context.read<OwnerContractRequestBloc>().add(
      OwnerContractRequestEvent.approve(
        widget.id,
        OwnerContractRequestActionRequestModel(ownerNotes: notes),
      ),
    );
  }

  void _reject(String notes) {
    context.read<OwnerContractRequestBloc>().add(
      OwnerContractRequestEvent.reject(
        widget.id,
        OwnerContractRequestActionRequestModel(ownerNotes: notes),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(title: const Text('Detail Pengajuan')),
      body: BlocConsumer<OwnerContractRequestBloc, OwnerContractRequestState>(
        listener: (context, state) {
          state.maybeWhen(
            success: (message) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
              context.pop(true);
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
                return const Center(child: Text('Pengajuan tidak ditemukan.'));
              }

              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _headerCard(item),
                  const SpaceHeight(16),
                  _tenantCard(item),
                  const SpaceHeight(16),
                  _requestInfoCard(item),
                  const SpaceHeight(16),
                  _notesCard(item),
                  if (item.isPending) ...[
                    const SpaceHeight(24),
                    Button.filled(
                      onPressed: () => _showApproveSheet(),
                      label: 'Setujui Pengajuan',
                      icon: const Icon(
                        Icons.check_circle,
                        color: AppColors.white,
                      ),
                    ),
                    const SpaceHeight(12),
                    Button.outlined(
                      onPressed: () => _showRejectSheet(),
                      label: 'Tolak Pengajuan',
                      icon: const Icon(Icons.cancel_outlined),
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

  Widget _headerCard(OwnerContractRequestModel item) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(item.typeIcon, color: AppColors.white, size: 36),
          const SpaceHeight(14),
          Text(
            item.typeLabel,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 26,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SpaceHeight(8),
          Text(
            item.statusLabel,
            style: const TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tenantCard(OwnerContractRequestModel item) {
    return _card(
      title: 'Tenant & Properti',
      children: [
        _row('Tenant', item.tenantName ?? '-'),
        _row('Email', item.tenantEmail ?? '-'),
        _row('Properti', item.propertyName ?? '-'),
        _row('Kamar', item.roomCode ?? '-'),
      ],
    );
  }

  Widget _requestInfoCard(OwnerContractRequestModel item) {
    return _card(
      title: 'Informasi Pengajuan',
      children: [
        _row('Jenis', item.typeLabel),
        _row('Status', item.statusLabel),
        _row('Durasi Perpanjangan', '${item.extendMonths ?? 0} bulan'),
        _row('Tanggal Akhir Baru', item.requestedEndDate ?? '-'),
        _row('Tanggal Stop', item.requestedStopDate ?? '-'),
        _row('Diajukan Pada', item.createdAt ?? '-'),
        _row('Direspon Pada', item.respondedAt ?? '-'),
      ],
    );
  }

  Widget _notesCard(OwnerContractRequestModel item) {
    return _card(
      title: 'Catatan',
      children: [
        _row('Alasan', item.reason ?? '-'),
        _row('Catatan Tenant', item.tenantNotes ?? '-'),
        _row('Catatan Owner', item.ownerNotes ?? '-'),
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

  void _showApproveSheet() {
    final notesC = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Setujui Pengajuan?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              const SpaceHeight(8),
              const Text(
                'Backend akan memproses perubahan kontrak secara otomatis.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.gray),
              ),
              const SpaceHeight(20),
              CustomTextField(
                controller: notesC,
                label: 'Catatan Owner',
                hintText: 'Opsional',
                prefixIcon: const Icon(Icons.notes_outlined),
              ),
              const SpaceHeight(20),
              Button.filled(
                onPressed: () {
                  context.pop();
                  _approve(
                    notesC.text.trim().isEmpty ? null : notesC.text.trim(),
                  );
                },
                label: 'Setujui',
              ),
              const SpaceHeight(12),
              Button.outlined(onPressed: () => context.pop(), label: 'Batal'),
            ],
          ),
        );
      },
    );
  }

  void _showRejectSheet() {
    final notesC = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Tolak Pengajuan?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              const SpaceHeight(8),
              const Text(
                'Masukkan alasan penolakan agar tenant mengetahui alasannya.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.gray),
              ),
              const SpaceHeight(20),
              CustomTextField(
                controller: notesC,
                label: 'Alasan Penolakan',
                hintText: 'Wajib diisi',
                prefixIcon: const Icon(Icons.notes_outlined),
              ),
              const SpaceHeight(20),
              Button.filled(
                onPressed: () {
                  if (notesC.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Alasan penolakan wajib diisi'),
                      ),
                    );
                    return;
                  }

                  context.pop();
                  _reject(notesC.text.trim());
                },
                label: 'Tolak Pengajuan',
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
