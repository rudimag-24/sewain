import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/data/models/request/tenant/tenant_profile_request_model.dart';
import 'package:sewain/data/models/response/tenant/tenant_profile_response_model.dart';
import 'package:sewain/presentasion/bloc/tenant_profile/tenant_profile_bloc.dart';

class TenantProfileEditPage extends StatefulWidget {
  final TenantProfileResponseModel initial;

  const TenantProfileEditPage({super.key, required this.initial});

  @override
  State<TenantProfileEditPage> createState() => _TenantProfileEditPageState();
}

class _TenantProfileEditPageState extends State<TenantProfileEditPage> {
  late final TextEditingController nameC;
  late final TextEditingController phoneC;

  @override
  void initState() {
    super.initState();
    nameC = TextEditingController(text: widget.initial.name ?? '');
    phoneC = TextEditingController(text: widget.initial.phone ?? '');
  }

  @override
  void dispose() {
    nameC.dispose();
    phoneC.dispose();
    super.dispose();
  }

  void _submit() {
    if (nameC.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Nama wajib diisi')));
      return;
    }

    context.read<TenantProfileBloc>().add(
      TenantProfileEvent.updateProfile(
        TenantProfileUpdateRequestModel(
          name: nameC.text.trim(),
          phone: phoneC.text.trim().isEmpty ? null : phoneC.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(title: const Text('Edit Profil')),
      body: BlocConsumer<TenantProfileBloc, TenantProfileState>(
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
                label: 'Nama',
                hintText: 'Masukkan nama',
                prefixIcon: const Icon(Icons.person_outline),
              ),
              const SpaceHeight(16),
              CustomTextField(
                controller: phoneC,
                label: 'Nomor HP',
                hintText: 'Masukkan nomor HP',
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(Icons.phone_outlined),
              ),
              const SpaceHeight(24),
              Button.filled(
                onPressed: _submit,
                disabled: loading,
                label: loading ? 'Menyimpan...' : 'Simpan Perubahan',
              ),
            ],
          );
        },
      ),
    );
  }
}
