import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/data/models/response/owner/owner_tenant_response_model.dart';
import 'package:sewain/presentasion/bloc/owner_tenant/owner_tenant_bloc.dart';
import 'package:sewain/presentasion/owner/tenant/owner_tenant_detail_page.dart';
import 'package:sewain/presentasion/owner/tenant/owner_tenant_form_page.dart';

class OwnerTenantPage extends StatefulWidget {
  const OwnerTenantPage({super.key});

  @override
  State<OwnerTenantPage> createState() => _OwnerTenantPageState();
}

class _OwnerTenantPageState extends State<OwnerTenantPage> {
  final searchC = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getTenants();
  }

  @override
  void dispose() {
    searchC.dispose();
    super.dispose();
  }

  void _getTenants() {
    context.read<OwnerTenantBloc>().add(
      OwnerTenantEvent.getList(
        search: searchC.text.trim().isEmpty ? null : searchC.text.trim(),
      ),
    );
  }

  Future<void> _refresh() async => _getTenants();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () async {
          final result = await context.push(const OwnerTenantFormPage());
          if (result == true && mounted) _getTenants();
        },
        child: const Icon(Icons.add, color: AppColors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SearchInput(
                controller: searchC,
                hintText: 'Cari tenant',
                onChanged: (_) => _getTenants(),
              ),
            ),
            const SpaceHeight(8),
            Expanded(
              child: BlocBuilder<OwnerTenantBloc, OwnerTenantState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    listLoaded: (items) {
                      if (items.isEmpty) return _emptyState();

                      return RefreshIndicator(
                        onRefresh: _refresh,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(20),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return _tenantCard(items[index]);
                          },
                        ),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Tenant',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tenantCard(OwnerTenantModel item) {
    final contract = item.activeContract;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () async {
        if (item.id != null) {
          final result = await context.push(
            OwnerTenantDetailPage(id: item.id!),
          );
          if (result == true && mounted) _getTenants();
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.stroke),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primary.withOpacity(0.12),
              child: Text(
                item.safeName.isNotEmpty ? item.safeName[0].toUpperCase() : 'T',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SpaceWidth(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.safeName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SpaceHeight(4),
                  Text(
                    item.safeEmail,
                    style: const TextStyle(color: AppColors.gray, fontSize: 12),
                  ),
                  if (contract != null) ...[
                    const SpaceHeight(6),
                    Text(
                      '${contract.propertyName ?? '-'} • Kamar ${contract.roomCode ?? '-'}',
                      style: const TextStyle(
                        color: AppColors.gray,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            _statusBadge(item),
          ],
        ),
      ),
    );
  }

  Widget _statusBadge(OwnerTenantModel item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: item.isActive
            ? AppColors.primary.withOpacity(0.12)
            : AppColors.gray.withOpacity(0.12),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        item.status ?? '-',
        style: TextStyle(
          color: item.isActive ? AppColors.primary : AppColors.gray,
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _emptyState() {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: const [
          SpaceHeight(120),
          Icon(Icons.people_outline, size: 80, color: AppColors.gray),
          SpaceHeight(16),
          Text(
            'Belum Ada Tenant',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          SpaceHeight(8),
          Text(
            'Tambahkan tenant pertama kamu.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.gray),
          ),
        ],
      ),
    );
  }
}
