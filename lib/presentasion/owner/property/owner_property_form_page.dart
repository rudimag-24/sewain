import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/data/models/request/owner/owner_property_request_model.dart';
import 'package:sewain/data/models/response/owner/owner_property_response_model.dart';
import 'package:sewain/presentasion/bloc/owner_property/owner_property_bloc.dart';

class OwnerPropertyFormPage extends StatefulWidget {
  final OwnerPropertyModel? initial;

  const OwnerPropertyFormPage({super.key, this.initial});

  @override
  State<OwnerPropertyFormPage> createState() => _OwnerPropertyFormPageState();
}

class _OwnerPropertyFormPageState extends State<OwnerPropertyFormPage> {
  late final TextEditingController nameC;
  late final TextEditingController addressC;
  late final TextEditingController cityC;
  late final TextEditingController provinceC;
  late final TextEditingController descriptionC;

  String type = 'kos';

  bool get isEdit => widget.initial?.id != null;

  @override
  void initState() {
    super.initState();

    final item = widget.initial;

    nameC = TextEditingController(text: item?.name ?? '');
    addressC = TextEditingController(text: item?.address ?? '');
    cityC = TextEditingController(text: item?.city ?? '');
    provinceC = TextEditingController(text: item?.province ?? '');
    descriptionC = TextEditingController(text: item?.description ?? '');
    type = item?.type ?? 'kos';
  }

  @override
  void dispose() {
    nameC.dispose();
    addressC.dispose();
    cityC.dispose();
    provinceC.dispose();
    descriptionC.dispose();
    super.dispose();
  }

  void _submit() {
    if (nameC.text.trim().isEmpty || addressC.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama dan alamat wajib diisi')),
      );
      return;
    }

    final request = OwnerPropertyRequestModel(
      name: nameC.text.trim(),
      type: type,
      address: addressC.text.trim(),
      city: cityC.text.trim().isEmpty ? null : cityC.text.trim(),
      province: provinceC.text.trim().isEmpty ? null : provinceC.text.trim(),
      description: descriptionC.text.trim().isEmpty
          ? null
          : descriptionC.text.trim(),
    );

    if (isEdit) {
      context.read<OwnerPropertyBloc>().add(
        OwnerPropertyEvent.update(widget.initial!.id!, request),
      );
    } else {
      context.read<OwnerPropertyBloc>().add(OwnerPropertyEvent.create(request));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(title: Text(isEdit ? 'Edit Properti' : 'Tambah Properti')),
      body: BlocConsumer<OwnerPropertyBloc, OwnerPropertyState>(
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
                controller: nameC,
                label: 'Nama Properti',
                hintText: 'Contoh: Kos Melati',
                prefixIcon: const Icon(Icons.home_work_outlined),
              ),
              const SpaceHeight(16),
              CustomDropdown(
                value: type,
                items: const ['kos', 'kontrakan', 'apartemen'],
                label: 'Tipe Properti',
                onChanged: (value) {
                  setState(() => type = value ?? 'kos');
                },
              ),
              const SpaceHeight(16),
              CustomTextField(
                controller: addressC,
                label: 'Alamat',
                hintText: 'Masukkan alamat lengkap',
                prefixIcon: const Icon(Icons.location_on_outlined),
              ),
              const SpaceHeight(16),
              CustomTextField(
                controller: cityC,
                label: 'Kota',
                hintText: 'Masukkan kota',
                prefixIcon: const Icon(Icons.location_city_outlined),
              ),
              const SpaceHeight(16),
              CustomTextField(
                controller: provinceC,
                label: 'Provinsi',
                hintText: 'Masukkan provinsi',
                prefixIcon: const Icon(Icons.map_outlined),
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
                    : 'Tambah Properti',
              ),
            ],
          );
        },
      ),
    );
  }
}
