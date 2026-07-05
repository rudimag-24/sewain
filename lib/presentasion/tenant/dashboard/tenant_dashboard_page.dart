import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/presentasion/bloc/tenant_dashboard/tenant_dashboard_bloc.dart';
import 'package:sewain/presentasion/tenant/contract/tenant_contract_page.dart';
import 'package:sewain/presentasion/tenant/contract/tenant_contract_request/tenant_contract_request_page.dart';
import 'package:sewain/presentasion/tenant/dashboard/tenant_notification_page.dart';

class TenantDashboardPage extends StatefulWidget {
  const TenantDashboardPage({super.key});

  @override
  State<TenantDashboardPage> createState() => _TenantDashboardPageState();
}

class _TenantDashboardPageState extends State<TenantDashboardPage> {
  @override
  void initState() {
    super.initState();
    _getDashboard();
  }

  void _getDashboard() {
    context.read<TenantDashboardBloc>().add(
      const TenantDashboardEvent.getDashboard(),
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
        child: BlocBuilder<TenantDashboardBloc, TenantDashboardState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (data) {
                if (!data.hasContract) {
                  return _emptyContract(data.message ?? 'Tidak ada kontrak.');
                }

                final contract = data.contract;
                final currentBill = data.currentBill;

                return RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      _header(),
                      const SpaceHeight(24),

                      InkWell(
                        borderRadius: BorderRadius.circular(22),
                        onTap: () {
                          context.push(const TenantContractPage());
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(
                                    Icons.home_work_rounded,
                                    color: AppColors.white,
                                  ),
                                  SpaceWidth(8),
                                  Text(
                                    'Kos Aktif',
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    'Lihat Detail',
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SpaceWidth(4),
                                  Icon(
                                    Icons.arrow_forward_rounded,
                                    color: AppColors.white,
                                    size: 18,
                                  ),
                                ],
                              ),
                              const SpaceHeight(18),
                              Text(
                                contract?.propertyName ?? '-',
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SpaceHeight(6),
                              Text(
                                'Kamar ${contract?.roomCode ?? '-'}',
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 15,
                                ),
                              ),
                              const SpaceHeight(10),
                              Text(
                                contract?.propertyAddress ?? '-',
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SpaceHeight(16),

                      Row(
                        children: [
                          Expanded(
                            child: _summaryCard(
                              title: 'Sisa Kontrak',
                              value: '${contract?.remainingMonths ?? 0} bulan',
                              icon: Icons.calendar_month,
                            ),
                          ),
                          const SpaceWidth(12),
                          Expanded(
                            child: _summaryCard(
                              title: 'Belum Bayar',
                              value: '${data.unpaidCount}',
                              icon: Icons.warning_amber_rounded,
                            ),
                          ),
                        ],
                      ),

                      const SpaceHeight(16),

                      _currentBillCard(
                        amount: currentBill?.totalAmount ?? 0,
                        period: currentBill?.period ?? '-',
                        status: currentBill?.status ?? '-',
                        dueDate: currentBill?.dueDate ?? '-',
                      ),

                      const SpaceHeight(24),

                      const Text(
                        'Akses Cepat',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SpaceHeight(12),

                      Row(
                        children: [
                          Expanded(
                            child: _quickAction(
                              icon: Icons.assignment_outlined,
                              title: 'Kontrak',
                              onTap: () {
                                context.push(const TenantContractPage());
                              },
                            ),
                          ),
                          const SpaceWidth(12),
                          Expanded(
                            child: _quickAction(
                              icon: Icons.receipt_long_outlined,
                              title: 'Tagihan',
                              onTap: () {
                                // nanti arahkan ke TenantBillPage / ubah index navbar
                              },
                            ),
                          ),
                          const SpaceWidth(12),
                          Expanded(
                            child: _quickAction(
                              icon: Icons.pending_actions_outlined,
                              title: 'Pengajuan',
                              onTap: () {
                                context.push(const TenantContractRequestPage());
                              },
                            ),
                          ),
                        ],
                      ),

                      const SpaceHeight(24),

                      const Text(
                        'Tagihan Terbaru',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SpaceHeight(12),

                      if (data.recentBills.isEmpty)
                        const Text(
                          'Belum ada tagihan.',
                          style: TextStyle(color: AppColors.gray),
                        )
                      else
                        ...data.recentBills.map(
                          (bill) => _recentBillItem(
                            period: bill.period ?? '-',
                            amount: bill.totalAmount ?? 0,
                            status: bill.status ?? '-',
                          ),
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
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Halo 👋',
                style: TextStyle(color: AppColors.gray, fontSize: 14),
              ),
              SpaceHeight(4),
              Text(
                'Selamat datang kembali',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            context.push(const TenantNotificationPage());
          },
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.notifications_none_rounded,
                  color: AppColors.black,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: const BoxDecoration(
                    color: AppColors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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
              Icons.home_work_outlined,
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
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
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

  Widget _currentBillCard({
    required num amount,
    required String period,
    required String status,
    required String dueDate,
  }) {
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
            'Tagihan Bulan Ini',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
          const SpaceHeight(12),
          Text(
            amount.currencyFormatRp,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: AppColors.primary,
            ),
          ),
          const SpaceHeight(8),
          Text(
            'Periode: $period',
            style: const TextStyle(color: AppColors.gray),
          ),
          const SpaceHeight(4),
          Text(
            'Jatuh tempo: $dueDate',
            style: const TextStyle(color: AppColors.gray),
          ),
          const SpaceHeight(12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              status.toUpperCase(),
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _quickAction({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.stroke),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary),
            const SpaceHeight(8),
            Text(
              title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recentBillItem({
    required String period,
    required num amount,
    required String status,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
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
                  period,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SpaceHeight(4),
                Text(
                  amount.currencyFormatRp,
                  style: const TextStyle(color: AppColors.gray),
                ),
              ],
            ),
          ),
          Text(
            status.toUpperCase(),
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// kode 2
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sewain/core/core.dart';
// import 'package:sewain/presentasion/bloc/tenant_dashboard/tenant_dashboard_bloc.dart';
// import 'package:sewain/presentasion/tenant/contract/tenant_contract_page.dart';
// import 'package:sewain/presentasion/tenant/contract/tenant_contract_request/tenant_contract_request_page.dart';
// import 'package:sewain/presentasion/tenant/dashboard/tenant_notification_page.dart';

// class TenantDashboardPage extends StatefulWidget {
//   const TenantDashboardPage({super.key});

//   @override
//   State<TenantDashboardPage> createState() => _TenantDashboardPageState();
// }

// class _TenantDashboardPageState extends State<TenantDashboardPage> {
//   @override
//   void initState() {
//     super.initState();
//     _getDashboard();
//   }

//   void _getDashboard() {
//     context.read<TenantDashboardBloc>().add(
//       const TenantDashboardEvent.getDashboard(),
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
//         child: BlocConsumer<TenantDashboardBloc, TenantDashboardState>(
//           listener: (context, state) {
//             state.maybeWhen(
//               error: (message) {
//                 context.showDialogError('Gagal Memuat Dashboard', message);
//               },
//               orElse: () {},
//             );
//           },
//           builder: (context, state) {
//             return state.maybeWhen(
//               loading: () => const Center(child: CircularProgressIndicator()),
//               error: (message) => _errorState(message),
//               loaded: (data) {
//                 if (!data.hasContract) {
//                   return _emptyContract(data.message ?? 'Tidak ada kontrak.');
//                 }

//                 final contract = data.contract;
//                 final currentBill = data.currentBill;

//                 return RefreshIndicator(
//                   onRefresh: _refresh,
//                   child: ListView(
//                     padding: const EdgeInsets.all(20),
//                     children: [
//                       _header(),
//                       const SpaceHeight(24),

//                       InkWell(
//                         borderRadius: BorderRadius.circular(22),
//                         onTap: () {
//                           context.push(const TenantContractPage());
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.all(20),
//                           decoration: BoxDecoration(
//                             color: AppColors.primary,
//                             borderRadius: BorderRadius.circular(22),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Row(
//                                 children: [
//                                   Icon(
//                                     Icons.home_work_rounded,
//                                     color: AppColors.white,
//                                   ),
//                                   SpaceWidth(8),
//                                   Text(
//                                     'Kos Aktif',
//                                     style: TextStyle(
//                                       color: AppColors.white,
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                   Spacer(),
//                                   Text(
//                                     'Lihat Detail',
//                                     style: TextStyle(
//                                       color: AppColors.white,
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                   SpaceWidth(4),
//                                   Icon(
//                                     Icons.arrow_forward_rounded,
//                                     color: AppColors.white,
//                                     size: 18,
//                                   ),
//                                 ],
//                               ),
//                               const SpaceHeight(18),
//                               Text(
//                                 contract?.propertyName ?? '-',
//                                 style: const TextStyle(
//                                   color: AppColors.white,
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.w900,
//                                 ),
//                               ),
//                               const SpaceHeight(6),
//                               Text(
//                                 'Kamar ${contract?.roomCode ?? '-'}',
//                                 style: const TextStyle(
//                                   color: AppColors.white,
//                                   fontSize: 15,
//                                 ),
//                               ),
//                               const SpaceHeight(10),
//                               Text(
//                                 contract?.propertyAddress ?? '-',
//                                 style: const TextStyle(
//                                   color: AppColors.white,
//                                   fontSize: 13,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),

//                       const SpaceHeight(16),

//                       Row(
//                         children: [
//                           Expanded(
//                             child: _summaryCard(
//                               title: 'Sisa Kontrak',
//                               value: '${contract?.remainingMonths ?? 0} bulan',
//                               icon: Icons.calendar_month,
//                             ),
//                           ),
//                           const SpaceWidth(12),
//                           Expanded(
//                             child: _summaryCard(
//                               title: 'Belum Bayar',
//                               value: '${data.unpaidCount}',
//                               icon: Icons.warning_amber_rounded,
//                             ),
//                           ),
//                         ],
//                       ),

//                       const SpaceHeight(16),

//                       _currentBillCard(
//                         amount: currentBill?.totalAmount ?? 0,
//                         period: currentBill?.period ?? '-',
//                         status: currentBill?.status ?? '-',
//                         dueDate: currentBill?.dueDate ?? '-',
//                       ),

//                       const SpaceHeight(24),

//                       const Text(
//                         'Akses Cepat',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w800,
//                         ),
//                       ),
//                       const SpaceHeight(12),

//                       Row(
//                         children: [
//                           Expanded(
//                             child: _quickAction(
//                               icon: Icons.assignment_outlined,
//                               title: 'Kontrak',
//                               onTap: () {
//                                 context.push(const TenantContractPage());
//                               },
//                             ),
//                           ),
//                           const SpaceWidth(12),
//                           Expanded(
//                             child: _quickAction(
//                               icon: Icons.receipt_long_outlined,
//                               title: 'Tagihan',
//                               onTap: () {
//                                 // nanti arahkan ke TenantBillPage / ubah index navbar
//                               },
//                             ),
//                           ),
//                           const SpaceWidth(12),
//                           Expanded(
//                             child: _quickAction(
//                               icon: Icons.pending_actions_outlined,
//                               title: 'Pengajuan',
//                               onTap: () {
//                                 context.push(const TenantContractRequestPage());
//                               },
//                             ),
//                           ),
//                         ],
//                       ),

//                       const SpaceHeight(24),

//                       const Text(
//                         'Tagihan Terbaru',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w800,
//                         ),
//                       ),
//                       const SpaceHeight(12),

//                       if (data.recentBills.isEmpty)
//                         const Text(
//                           'Belum ada tagihan.',
//                           style: TextStyle(color: AppColors.gray),
//                         )
//                       else
//                         ...data.recentBills.map(
//                           (bill) => _recentBillItem(
//                             period: bill.period ?? '-',
//                             amount: bill.totalAmount ?? 0,
//                             status: bill.status ?? '-',
//                           ),
//                         ),
//                     ],
//                   ),
//                 );
//               },
//               orElse: () => const SizedBox(),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _header() {
//     return Row(
//       children: [
//         const Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Halo 👋',
//                 style: TextStyle(color: AppColors.gray, fontSize: 14),
//               ),
//               SpaceHeight(4),
//               Text(
//                 'Selamat datang kembali',
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
//               ),
//             ],
//           ),
//         ),
//         InkWell(
//           borderRadius: BorderRadius.circular(50),
//           onTap: () {
//             context.push(const TenantNotificationPage());
//           },
//           child: Stack(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: const BoxDecoration(
//                   color: AppColors.white,
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(
//                   Icons.notifications_none_rounded,
//                   color: AppColors.black,
//                 ),
//               ),
//               Positioned(
//                 top: 8,
//                 right: 8,
//                 child: Container(
//                   width: 9,
//                   height: 9,
//                   decoration: const BoxDecoration(
//                     color: AppColors.red,
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _emptyContract(String message) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Icon(
//               Icons.home_work_outlined,
//               size: 80,
//               color: AppColors.gray,
//             ),
//             const SpaceHeight(16),
//             const Text(
//               'Belum Ada Kontrak Aktif',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
//             ),
//             const SpaceHeight(8),
//             Text(
//               message,
//               textAlign: TextAlign.center,
//               style: const TextStyle(color: AppColors.gray),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _errorState(String message) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Icon(
//               Icons.error_outline_rounded,
//               size: 80,
//               color: AppColors.red,
//             ),
//             const SpaceHeight(16),
//             const Text(
//               'Gagal Memuat Dashboard',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
//             ),
//             const SpaceHeight(8),
//             Text(
//               message,
//               textAlign: TextAlign.center,
//               style: const TextStyle(color: AppColors.gray),
//             ),
//             const SpaceHeight(24),
//             Button.filled(
//               label: 'Coba Lagi',
//               width: 180,
//               height: 46,
//               onPressed: _getDashboard,
//             ),
//           ],
//         ),
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
//             style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
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

//   Widget _currentBillCard({
//     required num amount,
//     required String period,
//     required String status,
//     required String dueDate,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: AppColors.stroke),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Tagihan Bulan Ini',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
//           ),
//           const SpaceHeight(12),
//           Text(
//             amount.currencyFormatRp,
//             style: const TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.w900,
//               color: AppColors.primary,
//             ),
//           ),
//           const SpaceHeight(8),
//           Text(
//             'Periode: $period',
//             style: const TextStyle(color: AppColors.gray),
//           ),
//           const SpaceHeight(4),
//           Text(
//             'Jatuh tempo: $dueDate',
//             style: const TextStyle(color: AppColors.gray),
//           ),
//           const SpaceHeight(12),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//             decoration: BoxDecoration(
//               color: AppColors.primary.withOpacity(0.12),
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: Text(
//               status.toUpperCase(),
//               style: const TextStyle(
//                 color: AppColors.primary,
//                 fontWeight: FontWeight.w700,
//                 fontSize: 12,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _quickAction({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return Button.outlined(
//       onPressed: onTap,
//       label: title,
//       height: 60,
//       mainAxisAlignment: MainAxisAlignment.center,
//       icon: Icon(icon, color: AppColors.primary, size: 20),
//       textColor: AppColors.black,
//       fontSize: 12,
//       fontWeight: FontWeight.w700,
//       borderRadius: 18,
//     );
//   }

//   Widget _recentBillItem({
//     required String period,
//     required num amount,
//     required String status,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(14),
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
//                   period,
//                   style: const TextStyle(fontWeight: FontWeight.w700),
//                 ),
//                 const SpaceHeight(4),
//                 Text(
//                   amount.currencyFormatRp,
//                   style: const TextStyle(color: AppColors.gray),
//                 ),
//               ],
//             ),
//           ),
//           Text(
//             status.toUpperCase(),
//             style: const TextStyle(
//               color: AppColors.primary,
//               fontSize: 12,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
