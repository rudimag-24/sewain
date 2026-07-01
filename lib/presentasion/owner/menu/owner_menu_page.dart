import 'package:flutter/material.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/presentasion/owner/contract/contract_request/owner_contract_request_page.dart';
import 'package:sewain/presentasion/owner/contract/owner_contract_page.dart';
import 'package:sewain/presentasion/owner/menu/owner_report_page.dart';
import 'package:sewain/presentasion/owner/payment/owner_payment_page.dart';

class OwnerMenuPage extends StatelessWidget {
  const OwnerMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Menu Owner',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
            ),
            const SpaceHeight(6),
            const Text(
              'Kelola fitur lanjutan owner',
              style: TextStyle(color: AppColors.gray, fontSize: 14),
            ),
            const SpaceHeight(24),

            _menuItem(
              icon: Icons.assignment_outlined,
              title: 'Kontrak Sewa',
              subtitle: 'Kelola kontrak aktif dan riwayat kontrak',
              onTap: () {
                context.push(const OwnerContractPage());
              },
            ),

            _menuItem(
              icon: Icons.payments_outlined,
              title: 'Pembayaran',
              subtitle: 'Monitoring pembayaran tenant',
              onTap: () {
                context.push(const OwnerPaymentPage());
              },
            ),

            _menuItem(
              icon: Icons.pending_actions_outlined,
              title: 'Pengajuan Tenant',
              subtitle: 'Setujui atau tolak pengajuan tenant',
              onTap: () {
                context.push(const OwnerContractRequestPage());
              },
            ),

            _menuItem(
              icon: Icons.bar_chart_rounded,
              title: 'Laporan',
              subtitle: 'Laporan hunian, tagihan, dan pemasukan',
              onTap: () {
                context.push(const OwnerReportPage());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
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
              child: Icon(icon, color: AppColors.primary),
            ),
            const SpaceWidth(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SpaceHeight(4),
                  Text(
                    subtitle,
                    style: const TextStyle(color: AppColors.gray, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: AppColors.gray,
            ),
          ],
        ),
      ),
    );
  }
}
