import 'package:flutter/material.dart';
import 'package:sewain/data/datasources/auth_local_datasource.dart';
import 'package:sewain/presentasion/auth/login_page.dart';
import 'package:sewain/presentasion/navbar/main_navigation_page.dart';

import '../../../core/core.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(seconds: 2));

    final isAuth = await AuthLocalDatasource().isAuth();

    if (!mounted) return;

    if (isAuth) {
      context.pushReplacement(const MainNavigationPage());
    } else {
      context.pushReplacement(const LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 96,
              width: 96,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Center(
                child: Text(
                  'KY',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const SpaceHeight(24),
            const Text(
              'KosYuk',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SpaceHeight(8),
            const Text(
              'Cari kos jadi lebih mudah',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SpaceHeight(40),
            const SizedBox(
              height: 28,
              width: 28,
              child: CircularProgressIndicator(
                color: AppColors.white,
                strokeWidth: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
