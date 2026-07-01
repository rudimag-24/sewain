import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/data/models/request/owner/owner_contract_request_model.dart';
import 'package:sewain/data/models/response/owner/owner_contract_response_model.dart';
import 'package:sewain/presentasion/bloc/owner_contract/owner_contract_bloc.dart';

class OwnerContractFormPage extends StatefulWidget {
  final OwnerContractModel? initial;

  const OwnerContractFormPage({super.key, this.initial});

  @override
  State<OwnerContractFormPage> createState() => _OwnerContractFormPageState();
}

class _OwnerContractFormPageState extends State<OwnerContractFormPage> {
  final roomIdC = TextEditingController();
  final tenantIdC = TextEditingController();
  final startDateC = TextEditingController();
  final endDateC = TextEditingController();
  final monthlyPriceC = TextEditingController();
  final depositC = TextEditingController();
  final notesC = TextEditingController();

  bool get isEdit => widget.initial?.id != null;

  @override
  void initState() {
    super.initState();

    final item = widget.initial;

    roomIdC.text = item?.room?.id?.toString() ?? '';
    tenantIdC.text = item?.tenant?.id?.toString() ?? '';
    startDateC.text = item?.startDate ?? '';
    endDateC.text = item?.endDate ?? '';
    monthlyPriceC.text = item?.monthlyPrice?.toString() ?? '';
    depositC.text = item?.deposit?.toString() ?? '';
    notesC.text = item?.notes ?? '';
  }

  @override
  void dispose() {
    roomIdC.dispose();
    tenantIdC.dispose();
    startDateC.dispose();
    endDateC.dispose();
    monthlyPriceC.dispose();
    depositC.dispose();
    notesC.dispose();
    super.dispose();
  }

  Future<void> _pickDate(TextEditingController controller) async {
    final now = DateTime.now();

    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 5),
      initialDate: now,
    );

    if (date != null) {
      controller.text =
          '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    }
  }

  void _submit() {
    final monthlyPrice = num.tryParse(monthlyPriceC.text.trim());
    final deposit = num.tryParse(
      depositC.text.trim().isEmpty ? '0' : depositC.text.trim(),
    );

    if (isEdit) {
      if (monthlyPrice == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Harga bulanan wajib angka')),
        );
        return;
      }

      context.read<OwnerContractBloc>().add(
        OwnerContractEvent.update(
          widget.initial!.id!,
          OwnerContractUpdateRequestModel(
            endDate: endDateC.text.trim().isEmpty ? null : endDateC.text.trim(),
            monthlyPrice: monthlyPrice,
            deposit: deposit,
            notes: notesC.text.trim().isEmpty ? null : notesC.text.trim(),
          ),
        ),
      );
    } else {
      final roomId = int.tryParse(roomIdC.text.trim());
      final tenantId = int.tryParse(tenantIdC.text.trim());

      if (roomId == null ||
          tenantId == null ||
          startDateC.text.trim().isEmpty ||
          endDateC.text.trim().isEmpty ||
          monthlyPrice == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Room ID, Tenant ID, tanggal, dan harga wajib diisi'),
          ),
        );
        return;
      }

      context.read<OwnerContractBloc>().add(
        OwnerContractEvent.create(
          OwnerContractCreateRequestModel(
            roomId: roomId,
            tenantId: tenantId,
            startDate: startDateC.text.trim(),
            endDate: endDateC.text.trim(),
            monthlyPrice: monthlyPrice,
            deposit: deposit,
            notes: notesC.text.trim().isEmpty ? null : notesC.text.trim(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(title: Text(isEdit ? 'Edit Kontrak' : 'Buat Kontrak')),
      body: BlocConsumer<OwnerContractBloc, OwnerContractState>(
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
              if (!isEdit) ...[
                CustomTextField(
                  controller: roomIdC,
                  label: 'Room ID',
                  hintText: 'Masukkan ID kamar',
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.meeting_room_outlined),
                ),
                const SpaceHeight(16),
                CustomTextField(
                  controller: tenantIdC,
                  label: 'Tenant ID',
                  hintText: 'Masukkan ID tenant',
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.person_outline),
                ),
                const SpaceHeight(16),
                CustomTextField(
                  controller: startDateC,
                  label: 'Tanggal Mulai',
                  hintText: 'YYYY-MM-DD',
                  readOnly: true,
                  prefixIcon: const Icon(Icons.calendar_today_outlined),
                  suffixIcon: IconButton(
                    onPressed: () => _pickDate(startDateC),
                    icon: const Icon(Icons.date_range),
                  ),
                ),
                const SpaceHeight(16),
              ],
              CustomTextField(
                controller: endDateC,
                label: 'Tanggal Selesai',
                hintText: 'YYYY-MM-DD',
                readOnly: true,
                prefixIcon: const Icon(Icons.event_available_outlined),
                suffixIcon: IconButton(
                  onPressed: () => _pickDate(endDateC),
                  icon: const Icon(Icons.date_range),
                ),
              ),
              const SpaceHeight(16),
              CustomTextField(
                controller: monthlyPriceC,
                label: 'Harga Bulanan',
                hintText: 'Contoh: 900000',
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(Icons.payments_outlined),
              ),
              const SpaceHeight(16),
              CustomTextField(
                controller: depositC,
                label: 'Deposit',
                hintText: 'Contoh: 500000',
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(Icons.savings_outlined),
              ),
              const SpaceHeight(16),
              CustomTextField(
                controller: notesC,
                label: 'Catatan',
                hintText: 'Masukkan catatan opsional',
                prefixIcon: const Icon(Icons.notes_outlined),
              ),
              const SpaceHeight(24),
              Button.filled(
                onPressed: _submit,
                disabled: loading,
                label: loading
                    ? 'Menyimpan...'
                    : isEdit
                    ? 'Simpan Perubahan'
                    : 'Buat Kontrak',
              ),
            ],
          );
        },
      ),
    );
  }
}
