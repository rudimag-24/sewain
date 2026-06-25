
import 'package:sewain/data/models/response/auth_response_model.dart';
import 'package:sewain/data/models/response/user_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {
  Future<void> saveAuthData(AuthResponseModel data) async {
    final pref = await SharedPreferences.getInstance();
    // await pref.setString('auth_data', data.toJson());
    await pref.setString('auth_data', data.toRawJson());
  }

  Future<void> updateAuthData(UserResponseModel data) async {
    final pref = await SharedPreferences.getInstance();
    final authData = await getAuthData();
    if (authData != null) {
      // final updatedData = authData.copyWith(user: data.user);
      final updatedData = AuthResponseModel(
        token: authData.token,
        user: data.user,
      );
      // await pref.setString('auth_data', updatedData.toJson());
      await pref.setString('auth_data', updatedData.toRawJson());
    }
  }

  Future<void> removeAuthData() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('auth_data');
  }

  Future<AuthResponseModel?> getAuthData() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString('auth_data');
    if (data != null) {
      // return AuthResponseModel.fromJson(data);
      return AuthResponseModel.fromRawJson(data);
    } else {
      return null;
    }
  }

  Future<bool> isAuth() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString('auth_data');
    return data != null;
  }
}