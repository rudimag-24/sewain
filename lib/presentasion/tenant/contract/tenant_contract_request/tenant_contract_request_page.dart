import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/data/models/response/tenant/tenant_contract_request_response_model.dart';
import 'package:sewain/presentasion/bloc/tenant_contract_request/tenant_contract_request_bloc.dart';
import 'package:sewain/presentasion/tenant/contract/tenant_contract_request/tenant_contract_extend_page.dart';
import 'package:sewain/presentasion/tenant/contract/tenant_contract_request/tenant_contract_request_detail_page.dart';
import 'package:sewain/presentasion/tenant/contract/tenant_contract_request/tenant_contract_stop_page.dart';

class TenantContractRequestPage extends StatefulWidget {
  const TenantContractRequestPage({super.key});

  @override
  State<TenantContractRequestPage> createState() =>
      _TenantContractRequestPageState();
}

class _TenantContractRequestPageState extends State<TenantContractRequestPage> {
  @override
  void initState() {
    super.initState();
    _getList();
  }

  void _getList() {
    context.read<TenantContractRequestBloc>().add(
      const TenantContractRequestEvent.getList(),
    );
  }

  Future<void> _refresh() async => _getList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      body: SafeArea(
        child:
            BlocBuilder<TenantContractRequestBloc, TenantContractRequestState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  listLoaded: (items) {
                    return RefreshIndicator(
                      onRefresh: _refresh,
                      child: ListView(
                        padding: const EdgeInsets.all(20),
                        children: [
                          const Text(
                            'Pengajuan',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SpaceHeight(6),
                          const Text(
                            'Riwayat pengajuan perpanjangan dan stop kos',
                            style: TextStyle(color: AppColors.gray),
                          ),
                          const SpaceHeight(20),
                          Row(
                            children: [
                              Expanded(
                                child: Button.filled(
                                  onPressed: () async {
                                    final result = await context.push(
                                      const TenantContractExtendPage(),
                                    );
                                    if (result == true && mounted) _getList();
                                  },
                                  label: 'Perpanjang',
                                  height: 48,
                                ),
                              ),
                              const SpaceWidth(12),
                              Expanded(
                                child: Button.outlined(
                                  onPressed: () async {
                                    final result = await context.push(
                                      const TenantContractStopPage(),
                                    );
                                    if (result == true && mounted) _getList();
                                  },
                                  label: 'Stop Kos',
                                  height: 48,
                                ),
                              ),
                            ],
                          ),
                          const SpaceHeight(20),
                          if (items.isEmpty)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 80),
                                child: Text(
                                  'Belum ada pengajuan.',
                                  style: TextStyle(color: AppColors.gray),
                                ),
                              ),
                            )
                          else
                            ...items.map((item) => _requestItem(item)),
                        ],
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
    );
  }

  Widget _requestItem(TenantContractRequestModel item) {
    return InkWell(
      onTap: () {
        if (item.id != null) {
          context.push(TenantContractRequestDetailPage(id: item.id!));
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.stroke),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primary.withOpacity(0.12),
              child: Icon(
                item.type == 'extend'
                    ? Icons.calendar_month
                    : Icons.logout_rounded,
                color: AppColors.primary,
              ),
            ),
            const SpaceWidth(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.typeLabel,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const SpaceHeight(4),
                  Text(
                    '${item.propertyName ?? '-'} • Kamar ${item.roomCode ?? '-'}',
                    style: const TextStyle(color: AppColors.gray, fontSize: 12),
                  ),
                ],
              ),
            ),
            Text(
              item.statusLabel,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
