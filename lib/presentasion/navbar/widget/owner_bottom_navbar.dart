import 'package:flutter/material.dart';
import 'package:sewain/core/constants/colors.dart';

class OwnerBottomNavbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int index) onTap;

  const OwnerBottomNavbar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.gray,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      elevation: 12,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_outlined),
          activeIcon: Icon(Icons.dashboard_rounded),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home_work_outlined),
          activeIcon: Icon(Icons.home_work_rounded),
          label: 'Properti',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_outline),
          activeIcon: Icon(Icons.people_rounded),
          label: 'Tenant',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long_outlined),
          activeIcon: Icon(Icons.receipt_long_rounded),
          label: 'Tagihan',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_rounded),
          activeIcon: Icon(Icons.menu_open_rounded),
          label: 'Menu',
        ),
      ],
    );
  }
}
