import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as Storage;
import 'package:webant/data/repositories/http_oauth_interceptor.dart';
import 'package:webant/domain/models/oauth/oauth_model.dart';
import 'package:webant/domain/models/user/user_model.dart';
import 'package:webant/domain/repositories/oauth_gateway.dart';
import 'package:webant/presentation/resources/http_strings.dart';

class HttpOauthGateway extends OauthGateway {
  HttpOauthGateway();

  final _storage = Storage.FlutterSecureStorage();
  final Dio _dio = Dio()
    ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true, error: true));


  UserModel userModel;
  OauthModel oauthModel;

  @override
  // ignore: missing_return
  Future<UserModel> authorization(String username, String password) async {
    _dio
      ..interceptors.clear()
      ..interceptors.add(
          LogInterceptor(responseBody: true, requestBody: true, error: true));

    Response client = await _dio.post(HttpStrings.urlClients, data: {
      HttpStrings.name: username,
      HttpStrings.allowedGrantTypes: [
        HttpStrings.password,
        HttpStrings.refreshToken
      ]
    });
    if (client.statusCode == 201) {
      oauthModel = OauthModel.fromJson(client.data);
      final Map<String, dynamic> queryParameters = <String, dynamic>{
        HttpStrings.clientId: '${oauthModel.id}_${oauthModel.randomId}',
        HttpStrings.grantType: HttpStrings.password,
        HttpStrings.username: username,
        HttpStrings.password: password,
        HttpStrings.clientSecret: oauthModel.secret,
      };
      var getToken = await _dio.get(HttpStrings.tokenEndpoint,
          queryParameters: queryParameters);
      if (getToken.statusCode == 200) {
        String accessToken = getToken.data[HttpStrings.accessToken];
        String refreshToken = getToken.data[HttpStrings.refreshToken];
        String secret = oauthModel.secret;
        String id = '${oauthModel.id}_${oauthModel.randomId}';
        _writeTokens(
            accessToken: accessToken,
            refreshToken: refreshToken,
            id: id,
            secret: secret);
        userModel = await getUser();
        return userModel;
      }
    }
  }

  @override
  Future<UserModel> getUser() async {
      _dio.interceptors.clear();
      _dio.interceptors
        ..add(HttpOauthInterceptor(_dio, this));

      await _storage.write(key: HttpStrings.userAccessToken, value: '000');
      var user = await _dio.get(HttpStrings.currentUser);
      userModel = UserModel.fromJson(user.data);
      return userModel;

  }

  @override
  Future<String> refreshToken() async {
      String refreshToken =
          await _storage.read(key: HttpStrings.userRefreshToken);
      final id = await _storage.read(key: HttpStrings.userId);
      final secret = await _storage.read(key: HttpStrings.userSecret);
      final Map<String, dynamic> queryParameters = <String, dynamic>{
        HttpStrings.clientId: id,
        HttpStrings.grantType: HttpStrings.refreshToken,
        HttpStrings.refreshToken: refreshToken,
        HttpStrings.clientSecret: secret,
      };
      var getToken = await _dio
          .get(HttpStrings.tokenEndpoint, queryParameters: queryParameters);
      if (getToken.statusCode == 200) {
        String accessToken = getToken.data[HttpStrings.accessToken];
        String refreshToken = getToken.data[HttpStrings.refreshToken];
        _writeTokens(
            accessToken: accessToken,
            refreshToken: refreshToken,
            id: id,
            secret: secret);
        return accessToken;
      } return '';
  }

  void _writeTokens(
      {String accessToken,
      String refreshToken,
      String id,
      String secret}) async {
    await _storage.write(key: HttpStrings.userAccessToken, value: accessToken);
    await _storage.write(
        key: HttpStrings.userRefreshToken, value: refreshToken);
    await _storage.write(key: HttpStrings.userId, value: id);
    await _storage.write(key: HttpStrings.userSecret, value: secret);
  }
}
