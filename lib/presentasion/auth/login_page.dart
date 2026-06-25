import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:sewain/core/components/custom_text_field.dart';
import 'package:sewain/core/components/spaces.dart';
import 'package:sewain/core/constants/colors.dart';
import 'package:sewain/data/models/request/auth_request_model.dart';
import 'package:sewain/presentasion/auth/bloc/auth_bloc.dart';

import '../../core/components/buttons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailC = TextEditingController();
  final passwordC = TextEditingController();

  @override
  void dispose() {
    emailC.dispose();
    passwordC.dispose();
    super.dispose();
  }

  void _submit() {
    if (emailC.text.trim().isEmpty || passwordC.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email & password wajib diisi')),
      );
      return;
    }

    context.read<AuthBloc>().add(
      AuthEvent.login(
        LoginRequestModel(email: emailC.text.trim(), password: passwordC.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            loginSuccess: (data) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(data.message)));

              if (data.user.role == 'owner') {
                // context.pushReplacement(const OwnerMainPage());
              } else {
                // context.pushReplacement(const TenantMainPage());
              }
            },
            error: (msg) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(msg), backgroundColor: AppColors.red),
            ),
            orElse: () {},
          );
        },
        builder: (context, state) {
          final loading = state.maybeWhen(
            loading: () => true,
            orElse: () => false,
          );

          return SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(24.0),
              children: [
                const SpaceHeight(40),
                Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.home_work_rounded,
                    color: AppColors.primary,
                    size: 42,
                  ),
                ),
                const SpaceHeight(24),
                const Text(
                  'Selamat datang di KosYuk',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
                ),
                const SpaceHeight(8),
                const Text(
                  'Masuk sebagai owner atau tenant untuk mengelola kos.',
                  style: TextStyle(color: AppColors.gray),
                ),
                const SpaceHeight(32),
                CustomTextField(
                  controller: emailC,
                  label: 'Email',
                  hintText: 'Masukkan email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
                const SpaceHeight(16),
                CustomTextField(
                  controller: passwordC,
                  label: 'Password',
                  hintText: 'Masukkan password',
                  obscureText: true,
                  prefixIcon: const Icon(Icons.lock_outline),
                ),
                const SpaceHeight(24),
                Button.filled(
                  onPressed: _submit,
                  disabled: loading,
                  label: loading ? 'Memproses...' : 'Login',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
