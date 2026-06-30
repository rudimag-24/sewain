import 'dart:convert';

class TenantContractExtendRequestModel {
  final int extendMonths;
  final String? tenantNotes;

  TenantContractExtendRequestModel({
    required this.extendMonths,
    this.tenantNotes,
  });

  String toJson() => jsonEncode({
    'extend_months': extendMonths,
    if (tenantNotes != null && tenantNotes!.isNotEmpty)
      'tenant_notes': tenantNotes,
  });
}

class TenantContractStopRequestModel {
  final String requestedStopDate;
  final String reason;
  final String? tenantNotes;

  TenantContractStopRequestModel({
    required this.requestedStopDate,
    required this.reason,
    this.tenantNotes,
  });

  String toJson() => jsonEncode({
    'requested_stop_date': requestedStopDate,
    'reason': reason,
    if (tenantNotes != null && tenantNotes!.isNotEmpty)
      'tenant_notes': tenantNotes,
  });
}
