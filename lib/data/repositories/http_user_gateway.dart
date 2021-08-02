import 'package:dio/dio.dart';
import 'package:webant/domain/models/user/user_model.dart';
import 'package:webant/domain/repositories/user_gateway.dart';
import 'package:webant/presentation/resources/http_strings.dart';
import 'http_oauth_gateway.dart';
import 'http_oauth_interceptor.dart';

class HttpUserGateway extends UserGateway {
  HttpUserGateway();

  Dio _dio = Dio()
    ..interceptors.add(LogInterceptor(
        responseBody: true,
        requestBody: true,
        error: true))
    ..options.baseUrl = HttpStrings.baseUrl;

  @override
  Future<void> registration(UserModel userModel) async {
    await _dio.post('/users', data: userModel.toJson());
  }

  @override
  Future<String> getUserName(String userUrl) async {
    Response user = await _dio.get('http://gallery.dev.webant.ru$userUrl');
    UserModel userModel = UserModel.fromJson(user.data);
    return userModel.username;
  }

  @override
  Future<void> updateUser(UserModel userModel) async {
    _dio.interceptors.add(HttpOauthInterceptor(_dio, HttpOauthGateway()));
    await _dio.put('/users/${userModel.id}', data: {
      'username': userModel.username,
      'email': userModel.email,
      'birthday': userModel.birthday,
    });
  }

  @override
  Future<void> deleteUser(UserModel userModel) async {
    _dio.interceptors.add(HttpOauthInterceptor(_dio, HttpOauthGateway()));
    await _dio.delete('/users/${userModel.id}');
  }

  @override
  Future<void> updatePasswordUser(
      UserModel userModel, String oldPassword, String newPassword) async {
    _dio.interceptors.add(HttpOauthInterceptor(_dio, HttpOauthGateway()));
    await _dio.put('/users/update_password/${userModel.id}',
        data: {'oldPassword': oldPassword, 'newPassword': newPassword});
  }
}
