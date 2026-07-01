import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/data/models/request/owner/owner_bill_request_model.dart';
import 'package:sewain/data/models/response/owner/owner_bill_response_model.dart';
import 'package:sewain/presentasion/bloc/owner_bill/owner_bill_bloc.dart';

class OwnerBillFormPage extends StatefulWidget {
  final OwnerBillModel? initial;

  const OwnerBillFormPage({super.key, this.initial});

  @override
  State<OwnerBillFormPage> createState() => _OwnerBillFormPageState();
}

class _OwnerBillFormPageState extends State<OwnerBillFormPage> {
  final rentalContractIdC = TextEditingController();
  final periodC = TextEditingController();
  final rentAmountC = TextEditingController();
  final electricityAmountC = TextEditingController();
  final waterAmountC = TextEditingController();
  final otherAmountC = TextEditingController();
  final otherDescriptionC = TextEditingController();
  final dueDateC = TextEditingController();
  final notesC = TextEditingController();

  bool get isEdit => widget.initial?.id != null;

  @override
  void initState() {
    super.initState();

    final bill = widget.initial;

    periodC.text = bill?.period ?? '';
    rentAmountC.text = bill?.rentAmount?.toString() ?? '';
    electricityAmountC.text = bill?.electricityAmount?.toString() ?? '';
    waterAmountC.text = bill?.waterAmount?.toString() ?? '';
    otherAmountC.text = bill?.otherAmount?.toString() ?? '';
    otherDescriptionC.text = bill?.otherDescription ?? '';
    dueDateC.text = bill?.dueDate ?? '';
    notesC.text = bill?.notes ?? '';
  }

  @override
  void dispose() {
    rentalContractIdC.dispose();
    periodC.dispose();
    rentAmountC.dispose();
    electricityAmountC.dispose();
    waterAmountC.dispose();
    otherAmountC.dispose();
    otherDescriptionC.dispose();
    dueDateC.dispose();
    notesC.dispose();
    super.dispose();
  }

  Future<void> _pickDate(TextEditingController controller) async {
    final now = DateTime.now();

    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 3),
      initialDate: now,
    );

    if (date != null) {
      controller.text =
          '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    }
  }

  void _submit() {
    final electricity = num.tryParse(
      electricityAmountC.text.trim().isEmpty
          ? '0'
          : electricityAmountC.text.trim(),
    );
    final water = num.tryParse(
      waterAmountC.text.trim().isEmpty ? '0' : waterAmountC.text.trim(),
    );
    final other = num.tryParse(
      otherAmountC.text.trim().isEmpty ? '0' : otherAmountC.text.trim(),
    );

    if (isEdit) {
      context.read<OwnerBillBloc>().add(
        OwnerBillEvent.update(
          widget.initial!.id!,
          OwnerBillUpdateRequestModel(
            electricityAmount: electricity,
            waterAmount: water,
            otherAmount: other,
            otherDescription: otherDescriptionC.text.trim(),
            dueDate: dueDateC.text.trim().isEmpty ? null : dueDateC.text.trim(),
            notes: notesC.text.trim(),
          ),
        ),
      );
    } else {
      final rentalContractId = int.tryParse(rentalContractIdC.text.trim());
      final rentAmount = num.tryParse(rentAmountC.text.trim());

      if (rentalContractId == null ||
          periodC.text.trim().isEmpty ||
          rentAmount == null ||
          dueDateC.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Contract ID, periode, sewa, dan jatuh tempo wajib diisi',
            ),
          ),
        );
        return;
      }

      context.read<OwnerBillBloc>().add(
        OwnerBillEvent.create(
          OwnerBillCreateRequestModel(
            rentalContractId: rentalContractId,
            period: periodC.text.trim(),
            rentAmount: rentAmount,
            electricityAmount: electricity,
            waterAmount: water,
            otherAmount: other,
            otherDescription: otherDescriptionC.text.trim(),
            dueDate: dueDateC.text.trim(),
            notes: notesC.text.trim(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(title: Text(isEdit ? 'Edit Tagihan' : 'Buat Tagihan')),
      body: BlocConsumer<OwnerBillBloc, OwnerBillState>(
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
                  controller: rentalContractIdC,
                  label: 'Rental Contract ID',
                  hintText: 'Masukkan ID kontrak',
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.assignment_outlined),
                ),
                const SpaceHeight(16),
                CustomTextField(
                  controller: periodC,
                  label: 'Periode',
                  hintText: 'Contoh: 2026-07',
                  prefixIcon: const Icon(Icons.calendar_month_outlined),
                ),
                const SpaceHeight(16),
                CustomTextField(
                  controller: rentAmountC,
                  label: 'Sewa',
                  hintText: 'Contoh: 900000',
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.payments_outlined),
                ),
                const SpaceHeight(16),
              ],
              CustomTextField(
                controller: electricityAmountC,
                label: 'Listrik',
                hintText: 'Contoh: 50000',
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(Icons.electric_bolt_outlined),
              ),
              const SpaceHeight(16),
              CustomTextField(
                controller: waterAmountC,
                label: 'Air',
                hintText: 'Contoh: 30000',
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(Icons.water_drop_outlined),
              ),
              const SpaceHeight(16),
              CustomTextField(
                controller: otherAmountC,
                label: 'Biaya Lain',
                hintText: 'Contoh: 20000',
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(Icons.add_card_outlined),
              ),
              const SpaceHeight(16),
              CustomTextField(
                controller: otherDescriptionC,
                label: 'Deskripsi Biaya Lain',
                hintText: 'Contoh: Kebersihan',
                prefixIcon: const Icon(Icons.notes_outlined),
              ),
              const SpaceHeight(16),
              CustomTextField(
                controller: dueDateC,
                label: 'Jatuh Tempo',
                hintText: 'YYYY-MM-DD',
                readOnly: true,
                prefixIcon: const Icon(Icons.event_outlined),
                suffixIcon: IconButton(
                  onPressed: () => _pickDate(dueDateC),
                  icon: const Icon(Icons.date_range),
                ),
              ),
              const SpaceHeight(16),
              CustomTextField(
                controller: notesC,
                label: 'Catatan',
                hintText: 'Masukkan catatan opsional',
                prefixIcon: const Icon(Icons.description_outlined),
              ),
              const SpaceHeight(24),
              Button.filled(
                onPressed: _submit,
                disabled: loading,
                label: loading
                    ? 'Menyimpan...'
                    : isEdit
                    ? 'Simpan Perubahan'
                    : 'Buat Tagihan',
              ),
            ],
          );
        },
      ),
    );
  }
}
