import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sewain/data/datasources/auth/auth_remote_datasource.dart';
import 'package:sewain/data/datasources/auth_local_datasource.dart';
import 'package:sewain/data/models/request/auth_request_model.dart';
import 'package:sewain/data/models/response/auth_response_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRemoteDatasource remoteDatasource;
  AuthBloc(this.remoteDatasource) : super(const _Initial()) {
    on<_Login>(_onLogin);
    on<_Logout>(_onLogout);
    on<_GetMe>(_onGetMe);
    on<_ChangePassword>(_onChangePassword);
  }

  Future<void> _onLogin(_Login event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final res = await remoteDatasource.login(event.request);
    await res.fold((l) async => emit(AuthState.error(l)), (r) async {
      await AuthLocalDatasource().saveAuthData(r);
      emit(AuthState.loginSuccess(r));
    });
  }

  Future<void> _onLogout(_Logout event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final res = await remoteDatasource.logout();
    await res.fold((l) async => emit(AuthState.error(l)), (r) async {
      await AuthLocalDatasource().removeAuthData();
      emit(AuthState.success(r));
    });
  }

  Future<void> _onGetMe(_GetMe event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final res = await remoteDatasource.me();
    await res.fold((l) async => emit(AuthState.error(l)), (r) async {
      await AuthLocalDatasource().updateAuthData(r);
      emit(AuthState.userLoaded(r.user));
    });
  }

  Future<void> _onChangePassword(
    _ChangePassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final res = await remoteDatasource.changePassword(event.request);
    await res.fold((l) async => emit(AuthState.error(l)), (r) async {
      await AuthLocalDatasource().removeAuthData();
      emit(AuthState.success(r));
    });
  }
}
