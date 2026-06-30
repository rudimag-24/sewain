import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/constants/variables.dart';
import 'package:sewain/core/theme/app_theme.dart';
import 'package:sewain/data/datasources/auth/auth_remote_datasource.dart';
import 'package:sewain/data/datasources/tenant/tenant_bill_remote_datasource.dart';
import 'package:sewain/data/datasources/tenant/tenant_contract_remote_datasource.dart';
import 'package:sewain/data/datasources/tenant/tenant_contract_request_remote_datasource.dart';
import 'package:sewain/data/datasources/tenant/tenant_dashboard_remote_datasource.dart';
import 'package:sewain/data/datasources/tenant/tenant_notification_remote_datasource.dart';
import 'package:sewain/data/datasources/tenant/tenant_payment_remote_datasource.dart';
import 'package:sewain/data/datasources/tenant/tenant_profile_remote_datasource.dart';
import 'package:sewain/presentasion/auth/auth/auth_bloc.dart';
import 'package:sewain/presentasion/auth/splash_page.dart';
import 'package:sewain/presentasion/bloc/tenant_bill/tenant_bill_bloc.dart';
import 'package:sewain/presentasion/bloc/tenant_contract_request/tenant_contract_request_bloc.dart';
import 'package:sewain/presentasion/bloc/tenant_dashboard/tenant_dashboard_bloc.dart';
import 'package:sewain/presentasion/bloc/tenant_notification/tenant_notification_bloc.dart';
import 'package:sewain/presentasion/bloc/tenant_payment/tenant_payment_bloc.dart';
import 'package:sewain/presentasion/bloc/tenant_profile/tenant_profile_bloc.dart';
import 'package:sewain/presentasion/bloc/tenant_contract/tenant_contract_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(AuthRemoteDatasource()),
        ),

        BlocProvider(
          create: (context) =>
              TenantDashboardBloc(TenantDashboardRemoteDatasource()),
        ),

        BlocProvider(
          create: (context) =>
              TenantProfileBloc(TenantProfileRemoteDatasource()),
        ),

        BlocProvider(
          create: (context) =>
              TenantContractBloc(TenantContractRemoteDatasource()),
        ),

        BlocProvider(
          create: (context) => TenantContractRequestBloc(
            TenantContractRequestRemoteDatasource(),
          ),
        ),

        BlocProvider(
          create: (context) =>
              TenantNotificationBloc(TenantNotificationRemoteDatasource()),
        ),

        BlocProvider(
          create: (context) => TenantBillBloc(TenantBillRemoteDatasource()),
        ),

        BlocProvider(
          create: (context) =>
              TenantPaymentBloc(TenantPaymentRemoteDatasource()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Variables.appName,
        theme: AppTheme.light,
        home: const SplashPage(),
      ),
    );
  }
}
