
import 'package:flutter/material.dart';
import 'package:sewain/presentasion/navbar/widget/tenant_bottom_navbar.dart';
import 'package:sewain/presentasion/tenant/bill/tenant_bill_page.dart';
import 'package:sewain/presentasion/tenant/contract/tenant_contract_request/tenant_contract_request_page.dart';
import 'package:sewain/presentasion/tenant/dashboard/tenant_dashboard_page.dart';
import 'package:sewain/presentasion/tenant/payment/tenant_payment_page.dart';
import 'package:sewain/presentasion/tenant/profile/tenant_profile_page.dart';

class TenantMainNavPage extends StatefulWidget {
  const TenantMainNavPage({super.key});

  @override
  State<TenantMainNavPage> createState() => _TenantMainNavPageState();
}

class _TenantMainNavPageState extends State<TenantMainNavPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    TenantDashboardPage(),
    TenantBillPage(),
    TenantPaymentPage(),
    TenantContractRequestPage(),
    TenantProfilePage(),
  ];

  void _onChangePage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: TenantBottomNavbar(
        selectedIndex: _selectedIndex,
        onTap: _onChangePage,
      ),
    );
  }
}
