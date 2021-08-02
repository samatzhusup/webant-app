import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as Storage;
import 'package:webant/data/repositories/http_oauth_gateway.dart';
import 'package:webant/presentation/resources/http_strings.dart';

class HttpOauthInterceptor extends Interceptor {
  final Dio _dio;
  final _storage = Storage.FlutterSecureStorage();
  final HttpOauthGateway _httpOauthGateway;

  HttpOauthInterceptor(this._dio, this._httpOauthGateway);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String accessToken = await _storage.read(key: HttpStrings.userAccessToken);
    if (accessToken.isNotEmpty || accessToken != null) {
      options.headers = {HttpStrings.authorization: 'Bearer $accessToken'};
    }
    return handler.next(options);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      String accessToken =
          await _httpOauthGateway.refreshToken().catchError((onError) {
             handler.reject(err);
          });
      if (accessToken != null) {
        print(accessToken);
        err.requestOptions.headers =
            ({HttpStrings.authorization: 'Bearer $accessToken'});
        _dio.fetch(err.requestOptions).then((r) => handler.resolve(r),
        onError: (e) => handler.reject(e),
        );
        return;
      }
     //else return handler.next(err);
    }
    else return handler.next(err);
  }
}
