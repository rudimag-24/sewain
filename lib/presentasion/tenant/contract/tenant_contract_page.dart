import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/data/models/response/tenant/tenant_contract_response_model.dart';
import 'package:sewain/presentasion/bloc/tenant_contract/tenant_contract_bloc.dart';

class TenantContractPage extends StatefulWidget {
  const TenantContractPage({super.key});

  @override
  State<TenantContractPage> createState() => _TenantContractPageState();
}

class _TenantContractPageState extends State<TenantContractPage> {
  @override
  void initState() {
    super.initState();
    context.read<TenantContractBloc>().add(
      const TenantContractEvent.getContract(),
    );
  }

  Future<void> _refresh() async {
    context.read<TenantContractBloc>().add(
      const TenantContractEvent.getContract(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(title: const Text('Detail Kontrak')),
      body: BlocBuilder<TenantContractBloc, TenantContractState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (response) {
              final contract = response.data;

              if (contract == null) {
                return _emptyContract(response.message ?? 'Tidak ada kontrak.');
              }

              return RefreshIndicator(
                onRefresh: _refresh,
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    _headerCard(contract),
                    const SpaceHeight(16),
                    _contractInfoCard(contract),
                    const SpaceHeight(16),
                    _roomPropertyCard(contract),
                    const SpaceHeight(16),
                    _ownerCard(contract.owner),
                    const SpaceHeight(24),
                    Button.filled(
                      onPressed: () {
                        // nanti arahkan ke ExtendContractPage
                      },
                      label: 'Ajukan Perpanjangan',
                      icon: const Icon(
                        Icons.calendar_month,
                        color: AppColors.white,
                      ),
                    ),
                    const SpaceHeight(12),
                    Button.outlined(
                      onPressed: () {
                        // nanti arahkan ke StopContractPage
                      },
                      label: 'Ajukan Stop Kos',
                      icon: const Icon(Icons.logout),
                    ),
                  ],
                ),
              );
            },
            error: (message) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.red),
                ),
              ),
            ),
            orElse: () => const SizedBox(),
          );
        },
      ),
    );
  }

  Widget _emptyContract(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.assignment_outlined,
              size: 80,
              color: AppColors.gray,
            ),
            const SpaceHeight(16),
            const Text(
              'Belum Ada Kontrak Aktif',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            const SpaceHeight(8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.gray),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerCard(TenantContractModel contract) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kontrak Aktif',
            style: TextStyle(color: AppColors.white, fontSize: 14),
          ),
          const SpaceHeight(8),
          Text(
            contract.property?.name ?? '-',
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SpaceHeight(6),
          Text(
            'Kamar ${contract.room?.code ?? '-'}',
            style: const TextStyle(color: AppColors.white, fontSize: 15),
          ),
          const SpaceHeight(16),
          Row(
            children: [
              Expanded(
                child: _headerInfo(
                  title: 'Sisa',
                  value: '${contract.remainingMonths ?? 0} bulan',
                ),
              ),
              Expanded(
                child: _headerInfo(
                  title: 'Status',
                  value: contract.status ?? '-',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _headerInfo({required String title, required String value}) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: AppColors.white, fontSize: 12),
          ),
          const SpaceHeight(4),
          Text(
            value.toUpperCase(),
            style: const TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _contractInfoCard(TenantContractModel contract) {
    return _sectionCard(
      title: 'Informasi Kontrak',
      children: [
        _infoItem(
          icon: Icons.calendar_today_outlined,
          title: 'Mulai',
          value: contract.startDate ?? '-',
        ),
        const Divider(height: 24),
        _infoItem(
          icon: Icons.event_available_outlined,
          title: 'Berakhir',
          value: contract.endDate ?? '-',
        ),
        const Divider(height: 24),
        _infoItem(
          icon: Icons.payments_outlined,
          title: 'Harga Bulanan',
          value: (contract.monthlyPrice ?? 0).currencyFormatRp,
        ),
        const Divider(height: 24),
        _infoItem(
          icon: Icons.savings_outlined,
          title: 'Deposit',
          value: (contract.deposit ?? 0).currencyFormatRp,
        ),
        const Divider(height: 24),
        _infoItem(
          icon: Icons.notes_outlined,
          title: 'Catatan',
          value: contract.notes ?? '-',
        ),
      ],
    );
  }

  Widget _roomPropertyCard(TenantContractModel contract) {
    return _sectionCard(
      title: 'Informasi Kamar & Properti',
      children: [
        _infoItem(
          icon: Icons.meeting_room_outlined,
          title: 'Kode Kamar',
          value: contract.room?.code ?? '-',
        ),
        const Divider(height: 24),
        _infoItem(
          icon: Icons.description_outlined,
          title: 'Deskripsi Kamar',
          value: contract.room?.description ?? '-',
        ),
        const Divider(height: 24),
        _infoItem(
          icon: Icons.home_work_outlined,
          title: 'Nama Properti',
          value: contract.property?.name ?? '-',
        ),
        const Divider(height: 24),
        _infoItem(
          icon: Icons.category_outlined,
          title: 'Tipe',
          value: contract.property?.type ?? '-',
        ),
        const Divider(height: 24),
        _infoItem(
          icon: Icons.location_on_outlined,
          title: 'Alamat',
          value:
              '${contract.property?.address ?? '-'}, ${contract.property?.city ?? '-'}, ${contract.property?.province ?? '-'}',
        ),
      ],
    );
  }

  Widget _ownerCard(TenantContractOwnerModel? owner) {
    return _sectionCard(
      title: 'Pemilik Kos',
      children: [
        _infoItem(
          icon: Icons.person_outline,
          title: 'Nama',
          value: owner?.name ?? '-',
        ),
        const Divider(height: 24),
        _infoItem(
          icon: Icons.phone_outlined,
          title: 'Nomor HP',
          value: owner?.phone ?? '-',
        ),
        const Divider(height: 24),
        _infoItem(
          icon: Icons.email_outlined,
          title: 'Email',
          value: owner?.email ?? '-',
        ),
      ],
    );
  }

  Widget _sectionCard({required String title, required List<Widget> children}) {
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
