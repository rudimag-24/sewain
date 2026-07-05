import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/data/models/response/tenant/tenant_profile_response_model.dart';
import 'package:sewain/presentasion/bloc/tenant_profile/tenant_profile_bloc.dart';
import 'package:sewain/presentasion/tenant/profile/tenant_profile_edit_page.dart';

class TenantProfilePage extends StatefulWidget {
  const TenantProfilePage({super.key});

  @override
  State<TenantProfilePage> createState() => _TenantProfilePageState();
}

class _TenantProfilePageState extends State<TenantProfilePage> {
  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  void _getProfile() {
    context.read<TenantProfileBloc>().add(
      const TenantProfileEvent.getProfile(),
    );
  }

  Future<void> _refresh() async {
    _getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      body: SafeArea(
        child: BlocConsumer<TenantProfileBloc, TenantProfileState>(
          listener: (context, state) {
            state.maybeWhen(
              error: (message) {
                context.showDialogError('Gagal Memuat Profil', message);
              },
              orElse: () {},
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (data) {
                return RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      const Text(
                        'Profil',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SpaceHeight(6),
                      const Text(
                        'Kelola informasi akun kamu',
                        style: TextStyle(color: AppColors.gray, fontSize: 14),
                      ),
                      const SpaceHeight(24),
                      _profileHeader(data),
                      const SpaceHeight(16),
                      _infoCard(data),
                      const SpaceHeight(16),
                      _contractCard(data.activeContract),
                      const SpaceHeight(24),
                      Button.filled(
                        onPressed: () async {
                          final result = await context.push(
                            TenantProfileEditPage(initial: data),
                          );

                          if (result == true && mounted) {
                            _refresh();
                          }
                        },
                        label: 'Edit Profil',
                        icon: const Icon(Icons.edit, color: AppColors.white),
                      ),

                      const SpaceHeight(24),
                      Button.filled(
                        color: AppColors.red,
                        onPressed: () async {
                          final result = await context.push(
                            TenantProfileEditPage(initial: data),
                          );

                          if (result == true && mounted) {
                            _refresh();
                          }
                        },
                        label: 'Logout',
                        icon: const Icon(Icons.logout, color: AppColors.white),
                      ),
                    ],
                  ),
                );
              },
              error: (message) => _errorState(message),
              orElse: () => const SizedBox(),
            );
          },
        ),
      ),
    );
  }

  Widget _errorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 80,
              color: AppColors.red,
            ),
            const SpaceHeight(16),
            const Text(
              'Gagal Memuat Profil',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            const SpaceHeight(8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.gray),
            ),
            const SpaceHeight(24),
            Button.filled(
              label: 'Coba Lagi',
              width: 180,
              height: 46,
              onPressed: _getProfile,
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileHeader(TenantProfileResponseModel data) {
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
              (data.name?.isNotEmpty ?? false)
                  ? data.name![0].toUpperCase()
                  : 'U',
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SpaceWidth(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name ?? '-',
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SpaceHeight(4),
                Text(
                  data.email ?? '-',
                  style: const TextStyle(color: AppColors.white, fontSize: 13),
                ),
                const SpaceHeight(8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    (data.role ?? '-').toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard(TenantProfileResponseModel data) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Column(
        children: [
          _infoItem(
            icon: Icons.person_outline,
            title: 'Nama',
            value: data.name ?? '-',
          ),
          const Divider(height: 24),
          _infoItem(
            icon: Icons.email_outlined,
            title: 'Email',
            value: data.email ?? '-',
          ),
          const Divider(height: 24),
          _infoItem(
            icon: Icons.phone_outlined,
            title: 'Nomor HP',
            value: data.phone ?? '-',
          ),
          const Divider(height: 24),
          _infoItem(
            icon: Icons.verified_user_outlined,
            title: 'Status',
            value: data.status ?? '-',
          ),
        ],
      ),
    );
  }

  Widget _contractCard(TenantActiveContractModel? contract) {
    if (contract == null) {
      return Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.stroke),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kontrak Aktif',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
            SpaceHeight(12),
            Text(
              'Belum ada kontrak aktif.',
              style: TextStyle(color: AppColors.gray),
            ),
          ],
        ),
      );
    }

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
          const Text(
            'Kontrak Aktif',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
          const SpaceHeight(14),
          _infoItem(
            icon: Icons.meeting_room_outlined,
            title: 'Unit',
            value: contract.unit ?? '-',
          ),
          const Divider(height: 24),
          _infoItem(
            icon: Icons.home_work_outlined,
            title: 'Properti',
            value: contract.property ?? '-',
          ),
          const Divider(height: 24),
          _infoItem(
            icon: Icons.location_on_outlined,
            title: 'Alamat',
            value: contract.address ?? '-',
          ),
          const Divider(height: 24),
          _infoItem(
            icon: Icons.calendar_month_outlined,
            title: 'Berakhir',
            value: contract.endDate ?? '-',
          ),
          const Divider(height: 24),
          _infoItem(
            icon: Icons.payments_outlined,
            title: 'Harga Bulanan',
            value: (contract.monthlyPrice ?? 0).currencyFormatRp,
          ),
        ],
      ),
    );
  }

  Widget _infoItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primary),
        const SpaceWidth(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: AppColors.gray, fontSize: 12),
              ),
              const SpaceHeight(4),
              Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ],
    );
  }
}
