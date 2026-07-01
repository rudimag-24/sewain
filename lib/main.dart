import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/constants/variables.dart';
import 'package:sewain/core/theme/app_theme.dart';
import 'package:sewain/data/datasources/auth/auth_remote_datasource.dart';
import 'package:sewain/data/datasources/owner/owner_bill_remote_datasource.dart';
import 'package:sewain/data/datasources/owner/owner_contract_remote_datasource.dart';
import 'package:sewain/data/datasources/owner/owner_contract_request_remote_datasource.dart';
import 'package:sewain/data/datasources/owner/owner_dashboard_remote_datasource.dart';
import 'package:sewain/data/datasources/owner/owner_payment_remote_datasource.dart';
import 'package:sewain/data/datasources/owner/owner_property_remote_datasource.dart';
import 'package:sewain/data/datasources/owner/owner_report_remote_datasource.dart';
import 'package:sewain/data/datasources/owner/owner_room_remote_datasource.dart';
import 'package:sewain/data/datasources/owner/owner_tenant_remote_datasource.dart';
import 'package:sewain/data/datasources/tenant/tenant_bill_remote_datasource.dart';
import 'package:sewain/data/datasources/tenant/tenant_contract_remote_datasource.dart';
import 'package:sewain/data/datasources/tenant/tenant_contract_request_remote_datasource.dart';
import 'package:sewain/data/datasources/tenant/tenant_dashboard_remote_datasource.dart';
import 'package:sewain/data/datasources/tenant/tenant_notification_remote_datasource.dart';
import 'package:sewain/data/datasources/tenant/tenant_payment_remote_datasource.dart';
import 'package:sewain/data/datasources/tenant/tenant_profile_remote_datasource.dart';
import 'package:sewain/presentasion/auth/auth/auth_bloc.dart';
import 'package:sewain/presentasion/auth/splash_page.dart';
import 'package:sewain/presentasion/bloc/owner_bill/owner_bill_bloc.dart';
import 'package:sewain/presentasion/bloc/owner_contract/owner_contract_bloc.dart';
import 'package:sewain/presentasion/bloc/owner_contract_request/owner_contract_request_bloc.dart';
import 'package:sewain/presentasion/bloc/owner_dashboard/owner_dashboard_bloc.dart';
import 'package:sewain/presentasion/bloc/owner_payment/owner_payment_bloc.dart';
import 'package:sewain/presentasion/bloc/owner_property/owner_property_bloc.dart';
import 'package:sewain/presentasion/bloc/owner_report/owner_report_bloc.dart';
import 'package:sewain/presentasion/bloc/owner_room/owner_room_bloc.dart';
import 'package:sewain/presentasion/bloc/owner_tenant/owner_tenant_bloc.dart';
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

        // ############################### OWNER ###########################
        BlocProvider(
          create: (context) =>
              OwnerDashboardBloc(OwnerDashboardRemoteDatasource()),
        ),

        BlocProvider(
          create: (context) =>
              OwnerPropertyBloc(OwnerPropertyRemoteDatasource()),
        ),

        BlocProvider(
          create: (context) => OwnerRoomBloc(OwnerRoomRemoteDatasource()),
        ),

        BlocProvider(
          create: (context) => OwnerTenantBloc(OwnerTenantRemoteDatasource()),
        ),

        BlocProvider(
          create: (context) =>
              OwnerContractBloc(OwnerContractRemoteDatasource()),
        ),

        BlocProvider(
          create: (context) => OwnerBillBloc(OwnerBillRemoteDatasource()),
        ),

        BlocProvider(
          create: (context) => OwnerPaymentBloc(OwnerPaymentRemoteDatasource()),
        ),

        BlocProvider(
          create: (context) =>
              OwnerContractRequestBloc(OwnerContractRequestRemoteDatasource()),
        ),

        BlocProvider(
          create: (context) => OwnerReportBloc(OwnerReportRemoteDatasource()),
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
