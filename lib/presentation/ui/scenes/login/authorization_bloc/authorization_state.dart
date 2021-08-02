part of 'authorization_bloc.dart';

@immutable
abstract class AuthorizationState {}

class AuthorizationInitial extends AuthorizationState {}

class AccessAuthorization extends AuthorizationState {}

class ErrorAuthorization extends AuthorizationState {
  final String err;

  ErrorAuthorization(this.err);
}

class LoadingAuthorization extends AuthorizationState {}

class LoginData extends AuthorizationState {
  final bool isLoading;
  final bool isLogin;

  LoginData({this.isLoading, this.isLogin});
}