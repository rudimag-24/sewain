part of 'owner_report_bloc.dart';

@freezed
class OwnerReportState with _$OwnerReportState {
  const factory OwnerReportState.initial() = _Initial;

  const factory OwnerReportState.loading() = _Loading;

  const factory OwnerReportState.loaded(OwnerReportResponseModel data) =
      _Loaded;

  const factory OwnerReportState.error(String message) = _Error;
}
