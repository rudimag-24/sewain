import 'package:flutter/material.dart';
import 'package:sewain/presentasion/navbar/widget/owner_bottom_navbar.dart';
import 'package:sewain/presentasion/owner/bill/owner_bill_page.dart';
import 'package:sewain/presentasion/owner/dashboard/owner_dashboard_page.dart';
import 'package:sewain/presentasion/owner/menu/owner_menu_page.dart';
import 'package:sewain/presentasion/owner/property/owner_property_page.dart';
import 'package:sewain/presentasion/owner/tenant/owner_tenant_page.dart';

class OwnerMainNavPage extends StatefulWidget {
  const OwnerMainNavPage({super.key});

  @override
  State<OwnerMainNavPage> createState() => _OwnerMainNavPageState();
}

class _OwnerMainNavPageState extends State<OwnerMainNavPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    OwnerDashboardPage(),
    OwnerPropertyPage(),
    OwnerTenantPage(),
    OwnerBillPage(),
    OwnerMenuPage(),
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
      bottomNavigationBar: OwnerBottomNavbar(
        selectedIndex: _selectedIndex,
        onTap: _onChangePage,
      ),
    );
  }
}
