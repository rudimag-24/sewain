// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sewain/core/core.dart';
// import 'package:sewain/data/models/response/owner/owner_dashboard_response_model.dart';
// import 'package:sewain/presentasion/bloc/owner_dashboard/owner_dashboard_bloc.dart';

// class OwnerDashboardPage extends StatefulWidget {
//   const OwnerDashboardPage({super.key});

//   @override
//   State<OwnerDashboardPage> createState() => _OwnerDashboardPageState();
// }

// class _OwnerDashboardPageState extends State<OwnerDashboardPage> {
//   @override
//   void initState() {
//     super.initState();
//     _getDashboard();
//   }

//   void _getDashboard() {
//     context.read<OwnerDashboardBloc>().add(
//       const OwnerDashboardEvent.getDashboard(),
//     );
//   }

//   Future<void> _refresh() async {
//     _getDashboard();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF8FAFC),
//       body: SafeArea(
//         child: BlocBuilder<OwnerDashboardBloc, OwnerDashboardState>(
//           builder: (context, state) {
//             return state.maybeWhen(
//               loading: () => const Center(child: CircularProgressIndicator()),
//               loaded: (data) {
//                 final stats = data.stats;

//                 return RefreshIndicator(
//                   onRefresh: _refresh,
//                   child: ListView(
//                     padding: const EdgeInsets.all(20),
//                     children: [
//                       _header(),
//                       const SpaceHeight(24),
//                       _incomeCard(stats),
//                       const SpaceHeight(16),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: _summaryCard(
//                               title: 'Properti',
//                               value: '${stats?.totalProperties ?? 0}',
//                               icon: Icons.home_work_outlined,
//                             ),
//                           ),
//                           const SpaceWidth(12),
//                           Expanded(
//                             child: _summaryCard(
//                               title: 'Kamar',
//                               value: '${stats?.totalRooms ?? 0}',
//                               icon: Icons.meeting_room_outlined,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SpaceHeight(12),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: _summaryCard(
//                               title: 'Terisi',
//                               value: '${stats?.occupiedRooms ?? 0}',
//                               icon: Icons.bed_rounded,
//                             ),
//                           ),
//                           const SpaceWidth(12),
//                           Expanded(
//                             child: _summaryCard(
//                               title: 'Kosong',
//                               value: '${stats?.availableRooms ?? 0}',
//                               icon: Icons.bed_outlined,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SpaceHeight(24),
//                       _sectionTitle('Tagihan Terbaru'),
//                       const SpaceHeight(12),
//                       if (data.recentBills.isEmpty)
//                         _emptyText('Belum ada tagihan terbaru.')
//                       else
//                         ...data.recentBills.map(_recentBillItem),
//                       const SpaceHeight(24),
//                       _sectionTitle('Pengajuan Pending'),
//                       const SpaceHeight(12),
//                       if (data.pendingRequests.isEmpty)
//                         _emptyText('Belum ada pengajuan pending.')
//                       else
//                         ...data.pendingRequests.map(_pendingRequestItem),
//                     ],
//                   ),
//                 );
//               },
//               error: (message) => Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(24),
//                   child: Text(
//                     message,
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(color: AppColors.red),
//                   ),
//                 ),
//               ),
//               orElse: () => const SizedBox(),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _header() {
//     return const Row(
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Owner Dashboard',
//                 style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
//               ),
//               SpaceHeight(4),
//               Text(
//                 'Ringkasan properti dan pemasukan',
//                 style: TextStyle(color: AppColors.gray, fontSize: 14),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _incomeCard(OwnerDashboardStatsModel? stats) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: AppColors.primary,
//         borderRadius: BorderRadius.circular(22),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Pendapatan Bulan Ini',
//             style: TextStyle(color: AppColors.white, fontSize: 14),
//           ),
//           const SpaceHeight(10),
//           Text(
//             stats?.totalIncomeRp ?? 0.currencyFormatRp,
//             style: const TextStyle(
//               color: AppColors.white,
//               fontSize: 30,
//               fontWeight: FontWeight.w900,
//             ),
//           ),
//           const SpaceHeight(14),
//           Row(
//             children: [
//               Expanded(
//                 child: _incomeSmallInfo(
//                   title: 'Pending',
//                   value: stats?.totalPendingRp ?? 0.currencyFormatRp,
//                 ),
//               ),
//               Expanded(
//                 child: _incomeSmallInfo(
//                   title: 'Tenant Aktif',
//                   value: '${stats?.activeTenants ?? 0}',
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _incomeSmallInfo({required String title, required String value}) {
//     return Container(
//       margin: const EdgeInsets.only(right: 8),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: AppColors.white.withOpacity(0.18),
//         borderRadius: BorderRadius.circular(14),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(color: AppColors.white, fontSize: 12),
//           ),
//           const SpaceHeight(4),
//           Text(
//             value,
//             style: const TextStyle(
//               color: AppColors.white,
//               fontWeight: FontWeight.w800,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _summaryCard({
//     required String title,
//     required String value,
//     required IconData icon,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: AppColors.stroke),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, color: AppColors.primary),
//           const SpaceHeight(12),
//           Text(
//             value,
//             style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
//           ),
//           const SpaceHeight(4),
//           Text(
//             title,
//             style: const TextStyle(color: AppColors.gray, fontSize: 12),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _sectionTitle(String title) {
//     return Text(
//       title,
//       style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
//     );
//   }

//   Widget _emptyText(String text) {
//     return Container(
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: AppColors.stroke),
//       ),
//       child: Text(text, style: const TextStyle(color: AppColors.gray)),
//     );
//   }

//   Widget _recentBillItem(OwnerRecentBillModel bill) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: AppColors.stroke),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.receipt_long_outlined, color: AppColors.primary),
//           const SpaceWidth(12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   bill.tenantName ?? '-',
//                   style: const TextStyle(fontWeight: FontWeight.w800),
//                 ),
//                 const SpaceHeight(4),
//                 Text(
//                   '${bill.propertyName ?? '-'} • ${bill.roomCode ?? '-'}',
//                   style: const TextStyle(color: AppColors.gray, fontSize: 12),
//                 ),
//               ],
//             ),
//           ),
//           Text(
//             bill.totalAmountRp,
//             style: const TextStyle(fontWeight: FontWeight.w900),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _pendingRequestItem(OwnerPendingRequestModel item) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: AppColors.stroke),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.pending_actions_outlined, color: AppColors.primary),
//           const SpaceWidth(12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   item.typeLabel,
//                   style: const TextStyle(fontWeight: FontWeight.w800),
//                 ),
//                 const SpaceHeight(4),
//                 Text(
//                   item.tenantName ?? '-',
//                   style: const TextStyle(color: AppColors.gray, fontSize: 12),
//                 ),
//               ],
//             ),
//           ),
//           const Icon(Icons.arrow_forward_ios_rounded, size: 16),
//         ],
//       ),
//     );
//   }
// }

// kode 2
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/data/models/response/owner/owner_dashboard_response_model.dart';
import 'package:sewain/presentasion/bloc/owner_dashboard/owner_dashboard_bloc.dart';
import 'package:sewain/presentasion/owner/bill/owner_bill_page.dart';
import 'package:sewain/presentasion/owner/contract/contract_request/owner_contract_request_page.dart';
import 'package:sewain/presentasion/owner/contract/owner_contract_page.dart';
import 'package:sewain/presentasion/owner/menu/owner_menu_page.dart';
import 'package:sewain/presentasion/owner/menu/owner_report_page.dart';
import 'package:sewain/presentasion/owner/payment/owner_payment_page.dart';
import 'package:sewain/presentasion/owner/property/owner_property_page.dart';
import 'package:sewain/presentasion/owner/tenant/owner_tenant_page.dart';

class OwnerDashboardPage extends StatefulWidget {
  const OwnerDashboardPage({super.key});

  @override
  State<OwnerDashboardPage> createState() => _OwnerDashboardPageState();
}

class _OwnerDashboardPageState extends State<OwnerDashboardPage> {
  @override
  void initState() {
    super.initState();
    _getDashboard();
  }

  void _getDashboard() {
    context.read<OwnerDashboardBloc>().add(
      const OwnerDashboardEvent.getDashboard(),
    );
  }

  Future<void> _refresh() async {
    _getDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      body: SafeArea(
        child: BlocBuilder<OwnerDashboardBloc, OwnerDashboardState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (data) {
                final stats = data.stats;

                return RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      _header(),
                      const SpaceHeight(24),
                      _incomeCard(stats),
                      const SpaceHeight(16),
                      Row(
                        children: [
                          Expanded(
                            child: _summaryCard(
                              title: 'Properti',
                              value: '${stats?.totalProperties ?? 0}',
                              icon: Icons.home_work_outlined,
                            ),
                          ),
                          const SpaceWidth(12),
                          Expanded(
                            child: _summaryCard(
                              title: 'Kamar',
                              value: '${stats?.totalRooms ?? 0}',
                              icon: Icons.meeting_room_outlined,
                            ),
                          ),
                        ],
                      ),
                      const SpaceHeight(12),
                      Row(
                        children: [
                          Expanded(
                            child: _summaryCard(
                              title: 'Terisi',
                              value: '${stats?.occupiedRooms ?? 0}',
                              icon: Icons.bed_rounded,
                            ),
                          ),
                          const SpaceWidth(12),
                          Expanded(
                            child: _summaryCard(
                              title: 'Kosong',
                              value: '${stats?.availableRooms ?? 0}',
                              icon: Icons.bed_outlined,
                            ),
                          ),
                        ],
                      ),
                      const SpaceHeight(24),
                      _sectionTitle('Quick Action'),
                      const SpaceHeight(12),
                      _quickAction(),
                      const SpaceHeight(24),
                      _sectionTitle('Tagihan Terbaru'),
                      const SpaceHeight(12),
                      if (data.recentBills.isEmpty)
                        _emptyText('Belum ada tagihan terbaru.')
                      else
                        ...data.recentBills.map(_recentBillItem),
                      const SpaceHeight(24),
                      _sectionTitle('Pengajuan Pending'),
                      const SpaceHeight(12),
                      if (data.pendingRequests.isEmpty)
                        _emptyText('Belum ada pengajuan pending.')
                      else
                        ...data.pendingRequests.map(_pendingRequestItem),
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
      ),
    );
  }

  Widget _header() {
    return const Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Owner Dashboard',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
              ),
              SpaceHeight(4),
              Text(
                'Ringkasan properti dan pemasukan',
                style: TextStyle(color: AppColors.gray, fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _incomeCard(OwnerDashboardStatsModel? stats) {
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
            'Pendapatan Bulan Ini',
            style: TextStyle(color: AppColors.white, fontSize: 14),
          ),
          const SpaceHeight(10),
          Text(
            stats?.totalIncomeRp ?? 0.currencyFormatRp,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SpaceHeight(14),
          Row(
            children: [
              Expanded(
                child: _incomeSmallInfo(
                  title: 'Pending',
                  value: stats?.totalPendingRp ?? 0.currencyFormatRp,
                ),
              ),
              Expanded(
                child: _incomeSmallInfo(
                  title: 'Tenant Aktif',
                  value: '${stats?.activeTenants ?? 0}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _incomeSmallInfo({required String title, required String value}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.all(12),
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
            value,
            style: const TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary),
          const SpaceHeight(12),
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
          ),
          const SpaceHeight(4),
          Text(
            title,
            style: const TextStyle(color: AppColors.gray, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _quickAction() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: .82,
      children: [
        _quickButton(
          icon: Icons.home_work_outlined,
          title: 'Properti',
          onTap: () {
            context.push(const OwnerPropertyPage());
          },
        ),
        _quickButton(
          icon: Icons.people_outline,
          title: 'Tenant',
          onTap: () {
            context.push(const OwnerTenantPage());
          },
        ),
        _quickButton(
          icon: Icons.receipt_long_outlined,
          title: 'Tagihan',
          onTap: () {
            context.push(const OwnerBillPage());
          },
        ),
        _quickButton(
          icon: Icons.assignment_outlined,
          title: 'Kontrak',
          onTap: () {
            context.push(const OwnerContractPage());
          },
        ),
        _quickButton(
          icon: Icons.payments_outlined,
          title: 'Payment',
          onTap: () {
            context.push(const OwnerPaymentPage());
          },
        ),
        _quickButton(
          icon: Icons.pending_actions_outlined,
          title: 'Request',
          onTap: () {
            context.push(const OwnerContractRequestPage());
          },
        ),
        _quickButton(
          icon: Icons.bar_chart_rounded,
          title: 'Report',
          onTap: () {
            context.push(const OwnerReportPage());
          },
        ),
        _quickButton(
          icon: Icons.more_horiz,
          title: 'Menu',
          onTap: () {
            context.push(const OwnerMenuPage());
          },
        ),
      ],
    );
  }

  Widget _quickButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.stroke),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: AppColors.primary.withOpacity(.12),
              child: Icon(icon, color: AppColors.primary),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
    );
  }

  Widget _emptyText(String text) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Text(text, style: const TextStyle(color: AppColors.gray)),
    );
  }

  Widget _recentBillItem(OwnerRecentBillModel bill) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Row(
        children: [
          const Icon(Icons.receipt_long_outlined, color: AppColors.primary),
          const SpaceWidth(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bill.tenantName ?? '-',
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                const SpaceHeight(4),
                Text(
                  '${bill.propertyName ?? '-'} • ${bill.roomCode ?? '-'}',
                  style: const TextStyle(color: AppColors.gray, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            bill.totalAmountRp,
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }

  Widget _pendingRequestItem(OwnerPendingRequestModel item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Row(
        children: [
          const Icon(Icons.pending_actions_outlined, color: AppColors.primary),
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
                  item.tenantName ?? '-',
                  style: const TextStyle(color: AppColors.gray, fontSize: 12),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        ],
      ),
    );
  }
}
