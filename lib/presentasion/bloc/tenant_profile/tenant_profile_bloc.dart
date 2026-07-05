import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sewain/data/datasources/tenant/tenant_profile_remote_datasource.dart';
import 'package:sewain/data/models/request/tenant/tenant_profile_request_model.dart';
import 'package:sewain/data/models/response/tenant/tenant_profile_response_model.dart';

part 'tenant_profile_event.dart';
part 'tenant_profile_state.dart';
part 'tenant_profile_bloc.freezed.dart';

class TenantProfileBloc extends Bloc<TenantProfileEvent, TenantProfileState> {
  final TenantProfileRemoteDatasource remoteDatasource;
  TenantProfileBloc(this.remoteDatasource) : super(const _Initial()) {
    on<_GetProfile>(_onGetProfile);
    on<_UpdateProfile>(_onUpdateProfile);
  }

  Future<void> _onGetProfile(
    _GetProfile event,
    Emitter<TenantProfileState> emit,
  ) async {
    emit(const TenantProfileState.loading());

    try {
      final result = await remoteDatasource.getProfile();

      result.fold(
        (error) => emit(TenantProfileState.error(error)),
        (data) => emit(TenantProfileState.loaded(data)),
      );
    } catch (e) {
      emit(TenantProfileState.error(e.toString()));
    }
  }

  Future<void> _onUpdateProfile(
    _UpdateProfile event,
    Emitter<TenantProfileState> emit,
  ) async {
    emit(const TenantProfileState.loading());

    try {
      final result = await remoteDatasource.updateProfile(event.request);

      result.fold(
        (error) => emit(TenantProfileState.error(error)),
        (data) => emit(TenantProfileState.success(data.message)),
      );
    } catch (e) {
      emit(TenantProfileState.error(e.toString()));
    }
  }
}
