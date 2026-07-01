part of 'owner_property_bloc.dart';

@freezed
class OwnerPropertyState with _$OwnerPropertyState {
  const factory OwnerPropertyState.initial() = _Initial;
  const factory OwnerPropertyState.loading() = _Loading;

  const factory OwnerPropertyState.listLoaded(List<OwnerPropertyModel> items) =
      _ListLoaded;

  const factory OwnerPropertyState.detailLoaded(OwnerPropertyModel? item) =
      _DetailLoaded;

  const factory OwnerPropertyState.success(String message) = _Success;

  const factory OwnerPropertyState.error(String message) = _Error;
}
