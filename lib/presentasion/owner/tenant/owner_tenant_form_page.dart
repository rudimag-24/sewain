import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/data/models/request/owner/owner_tenant_request_model.dart';
import 'package:sewain/data/models/response/owner/owner_tenant_response_model.dart';
import 'package:sewain/presentasion/bloc/owner_tenant/owner_tenant_bloc.dart';

class OwnerTenantFormPage extends StatefulWidget {
  final OwnerTenantModel? initial;

  const OwnerTenantFormPage({super.key, this.initial});

  @override
  State<OwnerTenantFormPage> createState() => _OwnerTenantFormPageState();
}

class _OwnerTenantFormPageState extends State<OwnerTenantFormPage> {
  late final TextEditingController nameC;
  late final TextEditingController emailC;
  late final TextEditingController phoneC;
  late final TextEditingController passwordC;

  bool get isEdit => widget.initial?.id != null;

  @override
  void initState() {
    super.initState();
    final item = widget.initial;

    nameC = TextEditingController(text: item?.name ?? '');
    emailC = TextEditingController(text: item?.email ?? '');
    phoneC = TextEditingController(text: item?.phone ?? '');
    passwordC = TextEditingController();
  }

  @override
  void dispose() {
    nameC.dispose();
    emailC.dispose();
    phoneC.dispose();
    passwordC.dispose();
    super.dispose();
  }

  void _submit() {
    if (nameC.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Nama wajib diisi')));
      return;
    }

    if (!isEdit) {
      if (emailC.text.trim().isEmpty || passwordC.text.length < 8) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email wajib diisi dan password minimal 8 karakter'),
          ),
        );
        return;
      }

      context.read<OwnerTenantBloc>().add(
        OwnerTenantEvent.create(
          OwnerTenantCreateRequestModel(
            name: nameC.text.trim(),
            email: emailC.text.trim(),
            phone: phoneC.text.trim().isEmpty ? null : phoneC.text.trim(),
            password: passwordC.text,
          ),
        ),
      );
    } else {
      context.read<OwnerTenantBloc>().add(
        OwnerTenantEvent.update(
          widget.initial!.id!,
          OwnerTenantUpdateRequestModel(
            name: nameC.text.trim(),
            phone: phoneC.text.trim().isEmpty ? null : phoneC.text.trim(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(title: Text(isEdit ? 'Edit Tenant' : 'Tambah Tenant')),
      body: BlocConsumer<OwnerTenantBloc, OwnerTenantState>(
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
                label: 'Nama Tenant',
                hintText: 'Masukkan nama tenant',
                prefixIcon: const Icon(Icons.person_outline),
              ),
              const SpaceHeight(16),
              CustomTextField(
                controller: emailC,
                label: 'Email',
                hintText: 'Masukkan email tenant',
                readOnly: isEdit,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              const SpaceHeight(16),
              CustomTextField(
                controller: phoneC,
                label: 'Nomor HP',
                hintText: 'Masukkan nomor HP',
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(Icons.phone_outlined),
              ),
              if (!isEdit) ...[
                const SpaceHeight(16),
                CustomTextField(
                  controller: passwordC,
                  label: 'Password',
                  hintText: 'Minimal 8 karakter',
                  obscureText: true,
                  prefixIcon: const Icon(Icons.lock_outline),
                ),
              ],
              const SpaceHeight(24),
              Button.filled(
                onPressed: _submit,
                disabled: loading,
                label: loading
                    ? 'Menyimpan...'
                    : isEdit
                    ? 'Simpan Perubahan'
                    : 'Tambah Tenant',
              ),
            ],
          );
        },
      ),
    );
  }
}
