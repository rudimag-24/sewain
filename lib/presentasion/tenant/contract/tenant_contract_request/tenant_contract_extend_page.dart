import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/data/models/request/tenant/tenant_contract_request_request_model.dart';
import 'package:sewain/presentasion/bloc/tenant_contract_request/tenant_contract_request_bloc.dart';

class TenantContractExtendPage extends StatefulWidget {
  const TenantContractExtendPage({super.key});

  @override
  State<TenantContractExtendPage> createState() =>
      _TenantContractExtendPageState();
}

class _TenantContractExtendPageState extends State<TenantContractExtendPage> {
  int extendMonths = 6;
  final notesC = TextEditingController();

  @override
  void dispose() {
    notesC.dispose();
    super.dispose();
  }

  void _submit() {
    context.read<TenantContractRequestBloc>().add(
      TenantContractRequestEvent.extend(
        TenantContractExtendRequestModel(
          extendMonths: extendMonths,
          tenantNotes: notesC.text.trim().isEmpty ? null : notesC.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(title: const Text('Ajukan Perpanjangan')),
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
              CustomDropdown(
                value: '$extendMonths',
                items: const ['6', '12', '24'],
                label: 'Durasi Perpanjangan',
                onChanged: (value) {
                  setState(() {
                    extendMonths = int.parse(value ?? '6');
                  });
                },
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
