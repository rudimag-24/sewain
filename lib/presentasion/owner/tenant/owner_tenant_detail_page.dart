import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/data/models/request/owner/owner_tenant_request_model.dart';
import 'package:sewain/data/models/response/owner/owner_tenant_response_model.dart';
import 'package:sewain/presentasion/bloc/owner_tenant/owner_tenant_bloc.dart';
import 'package:sewain/presentasion/owner/tenant/owner_tenant_form_page.dart';

class OwnerTenantDetailPage extends StatefulWidget {
  final int id;

  const OwnerTenantDetailPage({super.key, required this.id});

  @override
  State<OwnerTenantDetailPage> createState() => _OwnerTenantDetailPageState();
}

class _OwnerTenantDetailPageState extends State<OwnerTenantDetailPage> {
  @override
  void initState() {
    super.initState();
    _getDetail();
  }

  void _getDetail() {
    context.read<OwnerTenantBloc>().add(OwnerTenantEvent.getDetail(widget.id));
  }

  void _showResetPasswordSheet() {
    final passwordC = TextEditingController();
    final confirmC = TextEditingController();

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
                'Reset Password',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              const SpaceHeight(20),
              CustomTextField(
                controller: passwordC,
                label: 'Password Baru',
                obscureText: true,
                prefixIcon: const Icon(Icons.lock_outline),
              ),
              const SpaceHeight(16),
              CustomTextField(
                controller: confirmC,
                label: 'Konfirmasi Password',
                obscureText: true,
                prefixIcon: const Icon(Icons.lock_outline),
              ),
              const SpaceHeight(20),
              Button.filled(
                onPressed: () {
                  if (passwordC.text.length < 8 ||
                      passwordC.text != confirmC.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Password minimal 8 karakter dan konfirmasi harus sama',
                        ),
                      ),
                    );
                    return;
                  }

                  context.read<OwnerTenantBloc>().add(
                    OwnerTenantEvent.resetPassword(
                      widget.id,
                      OwnerTenantResetPasswordRequestModel(
                        password: passwordC.text,
                        passwordConfirmation: confirmC.text,
                      ),
                    ),
                  );

                  context.pop();
                },
                label: 'Reset Password',
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(title: const Text('Detail Tenant')),
      body: BlocConsumer<OwnerTenantBloc, OwnerTenantState>(
        listener: (context, state) {
          state.maybeWhen(
            success: (message) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
              _getDetail();
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
            detailLoaded: (tenant) {
              if (tenant == null) {
                return const Center(child: Text('Tenant tidak ditemukan.'));
              }

              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _headerCard(tenant),
                  const SpaceHeight(16),
                  _infoCard(tenant),
                  const SpaceHeight(16),
                  _contractCard(tenant),
                  const SpaceHeight(24),
                  Button.filled(
                    onPressed: () async {
                      final result = await context.push(
                        OwnerTenantFormPage(initial: tenant),
                      );
                      if (result == true && mounted) _getDetail();
                    },
                    label: 'Edit Tenant',
                    icon: const Icon(Icons.edit, color: AppColors.white),
                  ),
                  const SpaceHeight(12),
                  Button.outlined(
                    onPressed: _showResetPasswordSheet,
                    label: 'Reset Password',
                    icon: const Icon(Icons.lock_reset),
                  ),
                ],
              );
            },
            error: (message) => Center(
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.red),
              ),
            ),
            orElse: () => const SizedBox(),
          );
        },
      ),
    );
  }

  Widget _headerCard(OwnerTenantModel tenant) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 34,
            backgroundColor: AppColors.white,
            child: Text(
              tenant.safeName.isNotEmpty
                  ? tenant.safeName[0].toUpperCase()
                  : 'T',
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SpaceWidth(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tenant.safeName,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SpaceHeight(4),
                Text(
                  tenant.safeEmail,
                  style: const TextStyle(color: AppColors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard(OwnerTenantModel tenant) {
    return _card(
      title: 'Informasi Tenant',
      children: [
        _row('Nama', tenant.safeName),
        _row('Email', tenant.safeEmail),
        _row('Phone', tenant.safePhone),
        _row('Status', tenant.status ?? '-'),
      ],
    );
  }

  Widget _contractCard(OwnerTenantModel tenant) {
    final contract = tenant.activeContract;

    if (contract == null) {
      return _card(
        title: 'Kontrak Aktif',
        children: [_row('Status', 'Tidak ada kontrak aktif')],
      );
    }

    return _card(
      title: 'Kontrak Aktif',
      children: [
        _row('Properti', contract.propertyName ?? '-'),
        _row('Kamar', contract.roomCode ?? '-'),
        _row('Berakhir', contract.endDate ?? '-'),
        _row('Harga Bulanan', contract.monthlyPriceRp),
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
