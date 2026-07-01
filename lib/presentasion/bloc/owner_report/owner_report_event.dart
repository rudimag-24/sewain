part of 'owner_report_bloc.dart';

@freezed
class OwnerReportEvent with _$OwnerReportEvent {
  const factory OwnerReportEvent.started() = _Started;

  const factory OwnerReportEvent.getReport() = _GetReport;
}
