import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/data/models/request/tenant/tenant_contract_request_request_model.dart';
import 'package:sewain/presentasion/bloc/tenant_contract_request/tenant_contract_request_bloc.dart';

class TenantContractStopPage extends StatefulWidget {
  const TenantContractStopPage({super.key});

  @override
  State<TenantContractStopPage> createState() => _TenantContractStopPageState();
}

class _TenantContractStopPageState extends State<TenantContractStopPage> {
  final stopDateC = TextEditingController();
  final reasonC = TextEditingController();
  final notesC = TextEditingController();

  @override
  void dispose() {
    stopDateC.dispose();
    reasonC.dispose();
    notesC.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();

    final date = await showDatePicker(
      context: context,
      firstDate: now.add(const Duration(days: 1)),
      lastDate: DateTime(now.year + 2),
      initialDate: now.add(const Duration(days: 1)),
    );

    if (date != null) {
      stopDateC.text =
          '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    }
  }

  void _submit() {
    if (stopDateC.text.trim().isEmpty || reasonC.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tanggal stop dan alasan wajib diisi')),
      );
      return;
    }

    context.read<TenantContractRequestBloc>().add(
      TenantContractRequestEvent.stop(
        TenantContractStopRequestModel(
          requestedStopDate: stopDateC.text.trim(),
          reason: reasonC.text.trim(),
          tenantNotes: notesC.text.trim().isEmpty ? null : notesC.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(title: const Text('Ajukan Stop Kos')),
      body: BlocConsumer<TenantContractRequestBloc, TenantContractRequestState>(
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
          final loading = state.maybeWhen(
            loading: () => true,
            orElse: () => false,
          );

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              CustomTextField(
                controller: stopDateC,
                label: 'Tanggal Stop',
                hintText: 'Pilih tanggal stop',
                readOnly: true,
                onChanged: (_) {},
                prefixIcon: const Icon(Icons.calendar_today_outlined),
                suffixIcon: IconButton(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.date_range),
                ),
              ),
              const SpaceHeight(16),
              CustomTextField(
                controller: reasonC,
                label: 'Alasan',
                hintText: 'Masukkan alasan stop kos',
                prefixIcon: const Icon(Icons.info_outline),
              ),
              const SpaceHeight(16),
              CustomTextField(
                controller: notesC,
                label: 'Catatan',
                hintText: 'Tulis catatan opsional',
                prefixIcon: const Icon(Icons.notes_outlined),
              ),
              const SpaceHeight(24),
              Button.filled(
                onPressed: _submit,
                disabled: loading,
                label: loading ? 'Mengirim...' : 'Kirim Pengajuan',
              ),
            ],
          );
        },
      ),
    );
  }
}
