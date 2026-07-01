import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/data/models/request/owner/owner_room_request_model.dart';
import 'package:sewain/data/models/response/owner/owner_room_response_model.dart';
import 'package:sewain/presentasion/bloc/owner_room/owner_room_bloc.dart';

class OwnerRoomFormPage extends StatefulWidget {
  final int propertyId;
  final OwnerRoomModel? initial;

  const OwnerRoomFormPage({super.key, required this.propertyId, this.initial});

  @override
  State<OwnerRoomFormPage> createState() => _OwnerRoomFormPageState();
}

class _OwnerRoomFormPageState extends State<OwnerRoomFormPage> {
  late final TextEditingController codeC;
  late final TextEditingController priceC;
  late final TextEditingController descriptionC;

  bool get isEdit => widget.initial?.id != null;

  @override
  void initState() {
    super.initState();
    final item = widget.initial;

    codeC = TextEditingController(text: item?.code ?? '');
    priceC = TextEditingController(text: item?.pricePerMonth?.toString() ?? '');
    descriptionC = TextEditingController(text: item?.description ?? '');
  }

  @override
  void dispose() {
    codeC.dispose();
    priceC.dispose();
    descriptionC.dispose();
    super.dispose();
  }

  void _submit() {
    if (codeC.text.trim().isEmpty || priceC.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kode kamar dan harga wajib diisi')),
      );
      return;
    }

    final price = num.tryParse(priceC.text.trim());

    if (price == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Harga harus berupa angka')));
      return;
    }

    final request = OwnerRoomRequestModel(
      code: codeC.text.trim(),
      pricePerMonth: price,
      description: descriptionC.text.trim().isEmpty
          ? null
          : descriptionC.text.trim(),
    );

    if (isEdit) {
      context.read<OwnerRoomBloc>().add(
        OwnerRoomEvent.update(
          propertyId: widget.propertyId,
          roomId: widget.initial!.id!,
          request: request,
        ),
      );
    } else {
      context.read<OwnerRoomBloc>().add(
        OwnerRoomEvent.create(propertyId: widget.propertyId, request: request),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(title: Text(isEdit ? 'Edit Kamar' : 'Tambah Kamar')),
      body: BlocConsumer<OwnerRoomBloc, OwnerRoomState>(
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
                controller: codeC,
                label: 'Kode Kamar',
                hintText: 'Contoh: A1',
                prefixIcon: const Icon(Icons.meeting_room_outlined),
              ),
              const SpaceHeight(16),
              CustomTextField(
                controller: priceC,
                label: 'Harga per Bulan',
                hintText: 'Contoh: 900000',
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(Icons.payments_outlined),
              ),
              const SpaceHeight(16),
              CustomTextField(
                controller: descriptionC,
                label: 'Deskripsi',
                hintText: 'Masukkan deskripsi opsional',
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
                    : 'Tambah Kamar',
              ),
            ],
          );
        },
      ),
    );
  }
}
